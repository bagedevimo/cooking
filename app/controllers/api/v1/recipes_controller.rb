class Api::V1::RecipesController < ApplicationController
  def index
    recipes = current_user.recipes.map(&:for_api)
    render json: { recipes: recipes }
  end
end
