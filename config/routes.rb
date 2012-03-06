Salarios::Application.routes.draw do
  devise_scope :admin do
    get '/admin', :to => "devise/sessions#new", :as => :admin_session
    post '/admin', :to => "devise/sessions#create", :as => :admin_session
    delete '/sign_out', :to => "devise/sessions#destroy", :as => :destroy_admin_session
  end

  root :to => 'salaries#index'
  resources :salaries do
  end
  get "/cities/in/:state" => "state#cities", as: :get_cities
  post "/salary" => "salaries#create", as: :create_salary
end
