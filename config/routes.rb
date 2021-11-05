Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "welcome#home"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"

  resources :users, only: [:new, :create, :edit, :update, :index, :show] do
    # projects resource is the child and it's also uniquely identified with a shallow option
    resources :projects, shallow: true do
      resources :tickets do
        resources :comments, only: [:create]
      end
    end
  end

  # patch "/users/:id/projects/", to: "projects#update"
  # resources :projects
end
