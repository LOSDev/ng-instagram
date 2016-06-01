Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'registrations'}
  resources :users, only: :show do
    resources :following_relationships, only: [:create, :show, :destroy]
    member do
      get 'following'
      get 'followers'
      get 'followed_users'
      get 'posts'
      get 'likes'
    end
    collection do
      get 'search/:id', to: 'search#search'
      get 'feed'
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'application#angular'

  # Example of regular route:
  get 'hashtag/:id' => 'hashtag#show'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase
  # Example resource route (maps HTTP verbs to controller actions automatically):
  resources :posts do
    resources :comments, only: [:create, :destroy, :index]
    resources :likes, only: [:create]
    member do
      get 'like'
      delete 'unlike'
    end
  end

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
