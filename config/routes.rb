Libr::Application.routes.draw do

  root to: 'home#index'
  get 'books/new' => 'book#new'
  get 'books/:id' => 'book#view'
  get '/users/:id/books' => 'user#books'
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

  get '/users/:id' => 'user#view', id: /\d{1,8}/
  get '/users/:id/edit' => 'user#edit', id: /\d{1,8}/
  put '/users/:id' => 'user#update', id: /\d{1,8}/
  get '/search' => 'search#do_search'
  delete '/users/:user_id/books/:instance_id' => 'user#delete_book'

  get '/users/:id/keys' => 'auth_key#index', id: /\d{1,8}/
  post '/users/:id/keys' => 'auth_key#new', id: /\d{1,8}/
  delete '/users/:id/keys/:key_id' => 'auth_key#delete', id: /\d{1,8}/
  get '/records' => 'history#index'
  get '/users/:user_id/records' => 'history#records_for_user', id: /\d{1,8}/

  # api will return json
  get 'api/bookinfo/:isbn' => 'api#book_info'
  get 'api/userinfo/:user_id' => 'api#user_info'
  get 'api/books' => 'api#books'
  get 'api/users/:user_id/books' => 'api#user_books'
  post 'api/auth' => 'api#auth'
  get 'api/books/search/:keyword' => 'api#search'
  post 'api/books/add' => 'api#add_book'
  post 'api/books/return' => 'api#return_book'
  post 'api/books/borrow' => 'api#borrow_book'


  #for weixin
  get 'wx/query' => 'wei_xin#verify'
  post 'wx/query' => 'wei_xin#query'

  devise_for :users

  namespace :api do
    namespace :v1 do
      devise_scope :user do
        resources :sessions, :only => [:create, :destroy, :failure]
      end

      get 'locations/detail' => 'locations#get_location'

      resource :locations, :only => [:create, :destroy]
      get 'locations' => 'locations#index'
      resource :books, :only => [:create]
      get 'books' => 'books#index'

      get 'books/bookinfo/:isbn' => 'books#book_info'

      get 'books/newbooks/:after_book_id' => 'books#fetch_new_books'

      get 'recommend/locations/:location_id' => 'recommend#popular_books_around_me'
    end
  end

end
