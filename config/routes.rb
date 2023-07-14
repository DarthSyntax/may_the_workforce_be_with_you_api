Rails.application.routes.draw do
  devise_for :employers, controllers: {sessions: 'employers/sessions', registrations: 'employers/registrations'}
  resources :employers
  resources :jobs do
    post 'apply', on: :member
  end
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations'}
  resources :users


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
