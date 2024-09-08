
Rails.application.routes.draw do
  post '/metric/:key', to: 'metrics#log_metric'
  delete '/metric/:key', to: 'metrics#delete_metric'
  get '/metrics', to: 'metrics#get_metrics'
end
