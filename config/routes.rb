Libr::Application.routes.draw do

  root to: 'home#index'
  match 'books/new' => 'book#new'
  match 'books/:id' => 'book#view'
  match '/users/:id/books' => 'user#books'
  put '/users/:id/borrowedbooks/:instance_id' => 'user#return_book'
  post 'books' => 'book#add_to_lib'
  get 'books' => 'book#list'
  post 'books/:id/borrow' => 'book#borrow'
  get '/search/book/:arg' => 'book#search'
  get '/login' => 'user#login'
  get '/logout' => 'user#logout'
  get '/login/douban' => 'user#auth_douban'
  get '/login/qq' => 'user#auth_qq'
  get '/douban_callback' => 'home#douban_callback'
  get '/qq_callback' => 'home#qq_callback'
  get '/users/:id' => 'user#view'
  get '/users/:id/edit' =>'user#edit'
  put '/users/:id' => 'user#update'
  get '/search' => 'search#do_search'
  delete '/users/:user_id/books/:instance_id' => 'user#delete_book'

  get '/users/:id/keys' => 'auth_key#index'
  post '/users/:id/keys' => 'auth_key#new'
  delete '/users/:id/keys/:key_id' => 'auth_key#delete'
  # api will return json
  get 'api/bookinfo/:isbn' => 'api#book_info'
  get 'api/userinfo/:user_id' => 'api#user_info'
  get 'api/books' => 'api#books'
  post 'api/auth' =>'api#auth'
  get 'api/books/search/:keyword'=>'api#search'
  post 'api/books/add' => 'api#add_book'
  post  'api/books/return' =>'api#return_book'

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


  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
