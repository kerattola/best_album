Rails.application.routes.draw do
  root "articles#index"

 resources :articles
 resources :albums
 resources :score
end
