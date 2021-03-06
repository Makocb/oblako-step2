Rails.application.routes.draw do
  resources :todos
  resources :projects
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get '/', to: redirect('/projects')
  
  get '/projects', to: 'project#index'
  patch '/projects/:pid/todo/:tid',  to: 'projects#update_todo'
   
  get '/todos', to: 'todo#index'
end
