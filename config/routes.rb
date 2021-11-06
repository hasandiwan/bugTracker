Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "welcome#home"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"

  resources :users, only: [:new, :create, :edit, :update, :index, :show] do
    # projects resource is the child and it's also uniquely identified with a shallow option
    resources :projects, only: [:new, :create, :show, :index, :edit], shallow: true do
      resources :tickets, only: [:show, :new, :create, :edit, :update] do
        resources :comments, only: [:create]
      end
    end
  end

  get "/users/:id/tickets", to: "tickets#index", as: "user_tickets"
  patch "/users/:id/projects/:id", to: "projects#update"

  # resources :projects
end
