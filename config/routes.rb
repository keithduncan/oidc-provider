Oidc::Engine.routes.draw do
  root to: 'application#root'
  get '.well-known/openid-configuration', to: 'application#configuration', as: "configuration"
  resource :keyset, only: [:show], to: 'application#keyset'
end
