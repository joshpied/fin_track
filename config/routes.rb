Rails.application.routes.draw do
  # root to: "home#index"

  # Signed in home -> Transactions
  constraints Clearance::Constraints::SignedIn.new do
    root to: "transactions#index", as: :signed_in_root
  end

  # Signed out home -> Home
  constraints Clearance::Constraints::SignedOut.new do
    root to: "home#index"
  end

  resources :transactions
end
