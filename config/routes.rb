Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)


  get '/admin/photo_collections/:photo_collection_id/photographer' => 'admin/photo_collections#photographer', as: :photo_collection_photographer
  get '/admin/photo_collections/:photo_collection_id/viewpoint' => 'admin/photo_collections#viewpoint', as: :photo_collection_viewpoint
  get '/admin/photo_collections/:photo_collection_id/pack' => 'admin/photo_collections#pack', as: :photo_collection_pack
  post '/admin/photo_collections/:photo_collection_id/item' => 'admin/photo_collections#create_item', as: :create_photo_collection_item


  post 'captcha/regist' => 'captcha#regist'
  post 'captcha/change' => 'captcha#change'
  post 'captcha/binding' => 'captcha#binding'
  post 'captcha/check' => 'captcha#check'

  post 'users/login' => 'users#login'
  post 'users/sns' => 'users#sns'
  post 'users/complete' => 'users#complete'
  post 'users/change' => 'users#change_password'
  put 'users' => 'users#update'
  delete 'users/logout' => 'users#logout'

  post 'login/sns' => 'login#sns'

  get 'photographers' => 'photographers#index'
  #get 'photographers/:id' => 'photographers#show'
  get 'photographers/show' => 'photographers#show'
  #get 'photographers/:id/appointment' => 'photographers#appointment'
  get 'photographers/appointments' => 'photographers#appointment'

  get 'works' => 'works#index'
  #get 'works/:id' => 'works#show'
  get 'works/show' => 'works#show'
  get 'works/category' => 'works#category'
  get 'works/search' => 'works#search'

  get 'stars' => 'stars#index'

  get 'photos' => 'photos#index'
  #get 'photos/:id' => 'photos#show'
  get 'photos/show' => 'photos#show'

  get 'orders' => 'orders#index'
  #get 'orders/:id' => 'orders#show'
  get 'orders/show' => 'orders#show'
  post 'orders' => 'orders#create'
  delete 'orders/:no' => 'orders#delete'

  get 'stars' => 'stars#index'
  post 'stars' => 'stars#create'
  get 'stars/search' => 'stars#search'
  get 'stars/category' => 'stars#category'

  post 'resumes' => 'resumes#create'

  get 'comments' => 'comments#index'
  post 'comments' => 'comments#create'

  get 'deploy' => 'deploy#index'
end
