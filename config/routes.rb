Rails.application.routes.draw do
  root "receipts#index"

  resources :receipts, except: %i[edit update] do
    member { get :export }
    collection { get :insights }
  end
end
