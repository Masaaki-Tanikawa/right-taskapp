Rails.application.routes.draw do
  # 認証ページURLパスを変更
  devise_for :users, path_names: {
  sign_in: 'login',
  sign_out: 'logout',
  sign_up: 'register'
  }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: 'boards#index'
  resources :boards , except: [:show] do
    resources :cards do
      resources :comments, only: [:new, :create]
    end
  end

  resource :profiles, only: [:show, :edit, :update]

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

end
