Salarios::Application.routes.draw do
  root :to => 'home#index'
  resources :salaries do
  end
  get "/cities/in/:state" => "state#cities", as: :get_cities
  post "/salary" => "salaries#create", as: :create_salary
>>>>>>> 63ef8e47055c0e14ba3d6cce88533cbc0d0cd0a3
end
