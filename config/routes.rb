Salarios::Application.routes.draw do
  namespace :admin do
    resources :salaries, only: [:index, :destroy]
  end
  devise_for :admins, :skip => :session
  as :admin do
    get '/admin', :to => "devise/sessions#new", :as => :admin_session
    post '/admin', :to => "devise/sessions#create", :as => :admin_session
    delete '/sign_out', :to => "devise/sessions#destroy", :as => :destroy_admin_session
  end

  root :to => 'salaries#index'
  resources :salaries
  get "/cities/in/:state" => "state#cities", as: :get_cities
  post "/salary" => "salaries#create", as: :create_salary
end
