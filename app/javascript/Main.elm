module Main exposing (..)

import Browser
import Html exposing (Html, h1, text)
import Html.Attributes exposing (class)
import Browser.Navigation exposing (Key)
import Url exposing (Url)

-- MODEL

type alias Model =
  {
  }

-- INIT

init : () -> Url -> Key -> (Model, Cmd Message)
init flags url key =
  (Model, Cmd.none)

-- VIEW

view : Model -> Browser.Document Message
view model =
  {
    title = "Boop",
    body = [
      h1 [class "title"]
     [text "Hello Elm!"]
     ]
     }

-- MESSAGE

type Message
  = ClickedLink Browser.UrlRequest
  | ChangedUrl Url

-- UPDATE

update : Message -> Model -> (Model, Cmd Message)
update msg model =
  (model, Cmd.none)

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Message
subscriptions model =
  Sub.none

-- MAIN

main : Program () Model Message
main =
  Browser.application
    {
      init = init,
      view = view,
      update = update,
      subscriptions = subscriptions,
      onUrlRequest = ClickedLink,
      onUrlChange = ChangedUrl
    }
