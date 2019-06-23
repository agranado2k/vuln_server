Rails.application.routes.draw do
  resources :vulnerabilities, only: [:index]
end
