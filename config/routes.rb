Pressevent::Application.routes.draw do
  devise_for :users

  resources :wordpress_instances, only: [:new, :create]

  root :to => 'high_voltage/pages#show', :id => 'home'
end
