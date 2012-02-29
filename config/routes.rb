Salarios::Application.routes.draw do
  root :to => 'home#index'
  resources :salaries do
  end
  get "/cities/in/:state" => "state#cities", as: :get_cities
  post "/salary" => "salaries#create", as: :create_salary
end
