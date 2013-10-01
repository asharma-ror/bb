Cat::Application.routes.draw do
  
  match '/v1/notices' => 'exceptions#exception'

  devise_for :users

  match '/auth/:provider/callback', :to => 'authentications#create'
  match '/auth/failure', :to => 'authentications#failure'
  match '/auth/facebook/logout' => 'authentications#facebook_logout', :as => :facebook_logout
  match 'pages/home' => 'high_voltage/pages#show', :id => 'home'

  get 'projects/tracker/' => "errors#tracker", :as => :tracker
  get 'projects/chat/' => "errors#chat", :as => :chat
  get 'project/:project_id/errors/' => "errors#exceptions", :as => :exception
  get 'project/:project_id/resolved/' => "errors#resolved", :as => :resolved
  get 'project/:project_id/all_exceptions/' => "errors#all_exceptions", :as => :all_exception

  get 'project/:project_id/error/:error_id/error_trace' => "errors#error_trace", :as => :error_trace

  put 'project/:project_id/error/:error_id/update_resolved' => "errors#update_resolved", :as => :update_resolved
  put 'project/:project_id/error/:error_id/update_unresolved' => "errors#update_unresolved", :as => :update_unresolved
  get 'project/:project_id/errors/delete' => "errors#delete_permanently", :as => :delete_permanently

  match 'dashboard' => 'home#dashboard', :as => :dashboard
 
 resources :chat_files
 
 resources :users do
    collection do
      get 'upgrade'
    end

    member do
      get 'cancel_user_plan'
    end
  end

  resources :hooks do
    collection do
      post 'receiver'
    end
  end
  
  get "story/new"

  resources :projects do
    resources :changesets, :only => [:index]
    resources :stories, :only => [:index, :create, :update, :destroy, :show] do
      resources :notes, :only => [:index, :create, :show, :destroy]
      collection do
        get :done
        get :in_progress
        get :backlog
        get :import
        post :import_upload
      end
      member do
        put :start
        put :finish
        put :deliver
        put :accept
        put :reject
      end
    end
    member do
      get 'project_camp'
      get 'user_chat/:user_id', :action => "user_chat", :as => "user_chat"
      get 'accept'
      delete 'decline'
      post 'invitation'
      post 'pivotal_authenticate'
      post 'pivotal'
      delete 'pivotal_delete'
      get 'settings'
      get 'pivotal_detail'
      post 'campfire_authenticate'
      delete 'campfire_delete'
      get 'campfire_detail'
    end
    
    collection do
      get 'get_project_errors'
    end
  end

  resources :subscriptions do
    collection do
      get 'express_paypal'
      get 'complete'
      get 'unsubscribe'
    end
  end

  root :to => 'home#index'
end
