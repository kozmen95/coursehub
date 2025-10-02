Rails.application.routes.draw do
  devise_for :users

  resources :courses do
    resources :lessons
    resources :enrollments, only: [:index, :create, :update, :destroy]
  end

  namespace :admin do
  resources :enrollments, only: [:index, :show]
  end

 if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
end

  # root teraz na stronę domową
  root "home#index"

  require 'sidekiq/web'
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end

