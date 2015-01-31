Rails.application.routes.draw do
  root to: "linkedin_profiles#index"
  resources :linkedin_profiles
end
