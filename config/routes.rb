Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'profile', to: "profile#index"
  post 'profile/update'
  post 'profile/profile_info'
  get 'profile/get_modal'
  delete 'profile/delete'
end
