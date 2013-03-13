Cat::Application.routes.draw do
  match '/v1/notices' => 'exceptions#exception'
  
  devise_for :users

  match '/auth/:provider/callback', :to => 'authentications#create'
  match '/auth/failure', :to => 'authentications#failure'
  match '/auth/facebook/logout' => 'authentications#facebook_logout', :as => :facebook_logout
  match 'pages/home' => 'high_voltage/pages#show', :id => 'home'

  get 'project/:project_id/errors/' => "errors#exceptions", :as => :exception
  get 'project/:project_id/resolved/' => "errors#resolved", :as => :resolved
  get 'project/:project_id/unresolved/' => "errors#unresolved", :as => :unresolved
  get 'project/:project_id/error/:error_id/error_trace' => "errors#error_trace", :as => :error_trace
  
  match 'dashboard' => 'home#dashboard', :as => :dashboard
  
  resources :projects

  root :to => 'home#index'
end
