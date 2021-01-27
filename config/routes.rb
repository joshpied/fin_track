Rails.application.routes.draw do
  # root to: "home#index"

  # Signed in: home is transactions/index.html.erb
  constraints Clearance::Constraints::SignedIn.new do
    root to: "dashboards#index", as: :signed_in_root
  end

  # Signed out: home is home/index.html.erb
  constraints Clearance::Constraints::SignedOut.new do
    root to: "home#index"
  end

  # get "/dashboard", to: "dashboard#index", controller: 'dashboard'
  resources :dashboards, only: [:index], as: "dashboard"

  resources :transactions

  # get "/reports/months", to: 'reports#months'
  resources :reports, only: [:index, :show] do
    get :months, on: :collection
    get 'years', action: :years, on: :collection
    get 'years/:year', action: :year, on: :collection, as: :year
  end

  resources :budgets, only: [:new, :create, :edit, :update, :destroy]
end
