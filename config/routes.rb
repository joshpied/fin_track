Rails.application.routes.draw do
  # root to: "home#index"

  # Signed in: home is transactions/index.html.erb
  constraints Clearance::Constraints::SignedIn.new do
    root to: "transactions#index", as: :signed_in_root
  end

  # Signed out: home is home/index.html.erb
  constraints Clearance::Constraints::SignedOut.new do
    root to: "home#index"
  end

  resources :transactions

  # get "/reports/months", to: 'reports#months'
  resources :reports, only: [:index, :show] do
    get :months, on: :collection
  end
end
