Grammar::Application.routes.draw do

  resources :settings


  root to: "home#index"
  
  get "logout" => "user_sessions#destroy", :as => "logout"
  get "login" => "user_sessions#new", :as => "login"
  get "notifications/mark_all_as_read" => "notifications#mark_all_as_read"
  
  get "key_requests/list_friend_requests" => "key_requests#list_friend_requests"
  get "key_requests/send_friend_request" => "key_requests#send_friend_request"
  get "key_requests/accept_friend_request" => "key_requests#accept_friend_request"
  
  get "user_friends/remove_friend" => "user_friends#remove_friend"
  
  get "users/list_friends" => "users#list_friends"
  get "users/show_friend" => "users#show_friend"
  get "users/search_users_window" => "users#search_users_window"
  get "users/search_users" => "users#search_users"
  
  
  resources :user_sessions
  resources :users
  resources :notifications do
    member do
      get 'mark_as_seen'
      get 'mark_as_read'
    end
  end
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
