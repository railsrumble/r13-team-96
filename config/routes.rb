Confman::Application.routes.draw do
  get "schedule/show"

  get "schedule/update"

  get "schedule/destroy"

  get "schedule/create"

  resources :topics, only: [:index]
  resources :topics
  resources :speakers

  get "invitations/accept"
  get '/dashboard', to: 'home#dashboard'
  resources :conferences do
    resources :addresses
    resources :sponsors
    resources :rooms
    resources :slots
    resources :email_templates
    resources :appeals do
      member do
        post 'comment'
        get 'upvote'
        get 'downvote'
        get 'accept'
        get 'reject'
      end
    end
    resource :schedule, :controller => 'schedule'
    member do
     get 'appeal_types'
    end
  end

  resources :organizations do
    member do
      post 'invite'
    end
  end

  get "invitations/accept", as: :accept_invitation

  get "home/index"

  get "home/guest_session", as: :guest_signin

  devise_for :users

  authenticated :user do
    root :to => "home#dashboard"
  end
  root :to => 'home#index'

end
