class RecipesController < ApplicationController
  def index
    @recipes = current_user.recipes
    render json: { recipes: recipes }
  end
end
