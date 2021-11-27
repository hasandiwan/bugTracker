Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "welcome#home"
  get "/guest-login", to: "welcome#guest_login"
  resources :welcome, only: [:create]

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  get "/dashboard", to: "dashboard#dashboard"

  resources :users, only: [:new, :create, :edit, :update, :index, :show] do
    # projects resource is the child and it's also uniquely identified with a shallow option
    resources :projects, only: [:new, :create, :show, :index, :edit], shallow: true do
      resources :tickets, only: [:show, :new, :edit] do
        resources :comments, only: [:create]
      end
    end
  end

  get "/users/:id/tickets", to: "tickets#index", as: "user_tickets"
  patch "/users/:id/projects/:id", to: "projects#update"
  patch "tickets/:id/edit", to: "tickets#update"
  post "projects/:id/tickets/new", to: "tickets#create"
  get "/auth/facebook/callback", to: 'sessions#omniauth_login'
  
  match '/auth/github/callback', to: 'sessions#omniauth_login', via: [:get, :post]

  # get '/auth/github/callback', to: 'sessions#omniauth_login', via: [:get, :post]
  # post '/auth/github', to: 'sessions#omniauth_login', via: [:get, :post]
end
