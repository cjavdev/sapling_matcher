Rails.application.routes.draw do
  root to: "linkedin_profiles#index"
  resources :linkedin_profiles do
    resources :profile_matches, only: [:create]
  end
end
