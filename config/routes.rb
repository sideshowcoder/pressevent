Pressevent::Application.routes.draw do
  devise_for :users

  resources :wp_installations do
    resources :reports, only: [:new]
  end

  root :to => 'high_voltage/pages#show', :id => 'home'

  if Rails.env.development?
    mount MailPreview => 'mail_view'
  end
end
