module Main exposing (..)

import Browser
import Browser.Navigation exposing (Key)
import Html exposing (Html, h1, text)
import Html.Attributes exposing (class)
import Http
import Json.Decode as JD
import RemoteData exposing (RemoteData)
import Time
import Url exposing (Url)



-- MODEL


type alias Recipe =
    { name : String
    , createdAt : Time.Posix
    }


type alias Model =
    { urlKey : Key
    , recipes : RemoteData Http.Error (List Recipe)
    }



-- INIT


init : () -> Url -> Key -> ( Model, Cmd Message )
init _ _ key =
    ( { urlKey = key
      , recipes = RemoteData.NotAsked
      }
    , fetchRecipes
    )



-- VIEW


view : Model -> Browser.Document Message
view model =
    { title = "Cooking"
    , body =
        [ h1 [ class "title" ] [ text "Recipes" ]
        , viewRecipes model
        ]
    }


viewRecipes : Model -> Html Message
viewRecipes model =
    case model.recipes of
        RemoteData.NotAsked ->
            text "Pending"

        RemoteData.Loading ->
            text "Loading"

        RemoteData.Success recipes ->
            text (String.fromInt (List.length recipes))

        RemoteData.Failure error ->
            text (Debug.toString error)



-- MESSAGE


type Message
    = ClickedLink Browser.UrlRequest
    | ChangedUrl Url
    | GotRecipes (Result Http.Error (List Recipe))



-- UPDATE


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case message of
        ClickedLink _ ->
            ( model, Cmd.none )

        ChangedUrl _ ->
            ( model, Cmd.none )

        GotRecipes (Err error) ->
            ( { model | recipes = RemoteData.Failure error }, Cmd.none )

        GotRecipes (Ok recipes) ->
            ( { model | recipes = RemoteData.Success recipes }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Message
subscriptions _ =
    Sub.none



-- MAIN


main : Program () Model Message
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = ClickedLink
        , onUrlChange = ChangedUrl
        }



-- HTTP


fetchRecipes : Cmd Message
fetchRecipes =
    Http.get
        { url = "/api/v1/recipes"
        , expect = Http.expectJson GotRecipes recipesDecoder
        }



-- DECODERS


recipesDecoder : JD.Decoder (List Recipe)
recipesDecoder =
    JD.field "recipes" (JD.list recipeDecoder)


recipeDecoder : JD.Decoder Recipe
recipeDecoder =
    JD.map2 Recipe
        (JD.field "name" JD.string)
        (JD.field "createdAt" (JD.map Time.millisToPosix JD.int))
