Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'profile', to: "profile#index"
  post 'profile/update'
  post 'profile/highlights'
  post 'profile/profile_info'
  post 'profile/update_profile_pic'
  get 'profile/get_modal'
  delete 'profile/delete'
  resources :resumes, only: [:show]

  devise_scope :user do
    authenticated :user do
      root 'profile#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end
