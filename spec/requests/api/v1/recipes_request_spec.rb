require 'swagger_helper'

describe 'Recipes API', type: :request do
  let(:user) { users(:simple_user) }
  let(:recipe) { recipes(:hot_chocolate) }

  let(:as) { user.id }

  path '/api/v1/recipes' do
    get 'Lists existing recipes' do
      tags 'Recipes'
      consumes 'application/json'

      parameter name: :as, in: :query, type: :string

      response '200', 'lists recipes' do
        schema type: :object, properties: {
          recipes: {
            type: :array,
            items: [
              type: :object,
              properties: {
                name: { type: :string },
              }, required: [:name]
            ],
          },
        }, required: [:recipes]

        run_test! do |resp|
          data = JSON.parse(resp.body)["recipes"].map { |i| i["id"] }
          expect(data).to include(recipe.id)
        end
      end
    end
  end
end
