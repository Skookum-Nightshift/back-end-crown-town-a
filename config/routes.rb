Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # API
  namespace :api, defaults: {format: :json} do
    devise_for :users, skip: [:registrations]

    namespace :v1 do
      post "/sign_in", to: "sessions#login" #api.lvh.me:3000/v1/sign_in
      resource :sign_up, only: [:create], controller: :registrations #api.lvh.me:3000/v1/sign_up

      scope :users do #api.lvh.me:3000/v1/users
        post "/", to: "users#update"
        post "/password", to: "users#update_password"
      end

    end

    get "*any", to: "pages#not_found"
  end

  root "pages#not_found"

  get "*any", to: "pages#not_found"

end
