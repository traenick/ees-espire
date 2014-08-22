EesAcre::Application.routes.draw do
  get "workspace/index"

  resources :response_choices

  resources :message_sub_types

  resources :message_types

  resources :message_links

  resources :users

  resources :message_flows

  resources :messages

  root to: 'workspace#index'

  match 'messages/add_link' => 'messages#add_link', as:'add_link'

  match 'message_sub_types/add_response_choice' => 'message_sub_types#add_response_choice', as:'add_response_choice'

  match 'messages/add_user_to_flow/:message_id/:user_id' => 'messages#add_user_to_flow', as:'add_user_to_flow'
  match 'messages/toggle_date/:message_id/:mf_id/:date_type' => 'messages#toggle_date', as:'toggle_date'


  match 'workspace/load_message/:message_id' => 'workspace#load_message', as:'load_message'
  match 'workspace/update_selected_message_from_JSON' => 'workspace#update_selected_message_from_JSON', as:'update_selected_message_from_JSON'
  match 'workspace/update_message_digest_from_JSON' => 'workspace#update_message_digest_from_JSON', as:'update_message_digest_from_JSON'
  match 'workspace/get_message_JSON_from_URL' => 'workspace#get_message_JSON_from_URL', as:'get_message_JSON_from_URL'
  match 'workspace/(:user_id/(:show_json))' => 'workspace#index', as:'workspace'





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
