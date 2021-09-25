Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"
  post "/index", to: "routes#add"
  get "/index", to: "routes#index"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
