Cat::Application.routes.draw do
  match '/v1/notices' => 'exceptions#exception'

  devise_for :users

  match '/auth/:provider/callback', :to => 'authentications#create'
  match '/auth/failure', :to => 'authentications#failure'
  match '/auth/facebook/logout' => 'authentications#facebook_logout', :as => :facebook_logout
  match 'pages/home' => 'high_voltage/pages#show', :id => 'home'

  get 'project/:project_id/errors/' => "errors#exceptions", :as => :exception
  get 'project/:project_id/resolved/' => "errors#resolved", :as => :resolved
  get 'project/:project_id/all_exceptions/' => "errors#all_exceptions", :as => :all_exception

  get 'project/:project_id/error/:error_id/error_trace' => "errors#error_trace", :as => :error_trace

  put 'project/:project_id/error/:error_id/update_resolved' => "errors#update_resolved", :as => :update_resolved
  put 'project/:project_id/error/:error_id/update_unresolved' => "errors#update_unresolved", :as => :update_unresolved
  get 'project/:project_id/errors/delete' => "errors#delete_permanently", :as => :delete_permanently

  match 'dashboard' => 'home#dashboard', :as => :dashboard

  resources :projects do
    member do
      put 'accept'
      delete 'decline'
      post 'invitation'
    end
  end

  root :to => 'home#index'
end
