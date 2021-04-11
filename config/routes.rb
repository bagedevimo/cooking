# typed: strict
Rails.application.routes.draw do
  root to: 'static#app'

  namespace :api do
    namespace :v1 do
      resources :recipes
    end
  end

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
end
