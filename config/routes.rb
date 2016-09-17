Rails.application.routes.draw do
  scope "/", format: false do
    resources :todos, only: [:index, :show]
  end

  root :to => "home#index"
end
