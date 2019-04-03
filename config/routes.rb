Rails.application.routes.draw do
  root 'homepage#home'
  match 'create_user', to: 'homepage#create_user', via: [:post]
end
