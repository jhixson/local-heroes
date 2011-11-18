LocalHeroes::Application.routes.draw do
  resources :replies
  get 'topics/:id/reply' => 'topics#reply', :as => :reply
  put 'topics/:id/post_reply' => 'topics#post_reply', :as => :post_reply

  resources :topics

  resources :users

  resources :locations

  controller :user_sessions do
    get 'login' => :new
    post 'login' => :create
    get 'logout' => :destroy
    delete 'logout' => :destroy
  end

  get 'static/home'
  match ':zip' => 'locations#find_by_zip', :constraints => {:zip => /\d{5}/}
  match '*a/:zip' => 'locations#find_by_zip', :constraints => {:zip => /\d{5}/}
  match ':city' => 'locations#find_by_city', :constraints => {:city => /[\w-]+/}
  match ':state/:city' => 'locations#find_by_state_and_city', :constraints => {:state => /[a-zA-Z]{2}/, :city => /[\w-]+/}

  root :to => 'static#home'

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
  # match ':controller(/:action(/:id(.:format)))'
end
