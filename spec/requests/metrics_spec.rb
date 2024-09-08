# spec/requests/metrics_spec.rb
require 'rails_helper'

RSpec.describe 'Metrics API', type: :request do
  describe 'POST /metric/:key' do
    it 'logs a metric value for a specific key' do
      post '/metric/test_key', params: { value: 10 }, as: :json

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq('{}')
    end
  end

  describe 'DELETE /metric/:key' do
    it 'deletes all metrics associated with a specific key' do
      post '/metric/test_key', params: { value: 10 }, as: :json
      delete '/metric/test_key'

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq('{}')
    end
  end

  describe 'GET /metrics' do
    it 'retrieves aggregated metrics for the most recent hour' do
      post '/metric/test_key', params: { value: 10 }, as: :json
      post '/metric/test_key', params: { value: 20 }, as: :json

      get '/metrics'

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json).to include({ 'key' => 'test_key', 'total' => 30 })
    end
  end
end

