Rails.application.routes.draw do
  devise_for :users

  resources :courses do
    resources :lessons
    resources :enrollments, only: [:index, :create, :update, :destroy]
  end

  resources :enrollments, only: [:index, :show]

  # root teraz na stronę domową
  root "home#index"
end
