Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :organizations, only: [:show] do
    resources :clusters, only: [:show] do
      resource :token
      mount Oidc::Engine, at: "oidc", as: "oidc"
    end
  end
end
