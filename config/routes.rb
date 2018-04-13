Rails.application.routes.draw do

  get ':short_url_id', to: 'url_mappers#redirect_to_original_url', as: 'redirect_to_original_url'

  get 'url_mapper/short_url', to: 'url_mappers#short_url', as: 'short_url'

  root 'url_mappers#index'
end
