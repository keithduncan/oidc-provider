Rails.application.routes.draw do
  mount Oidc::Engine => "/oidc"
end
