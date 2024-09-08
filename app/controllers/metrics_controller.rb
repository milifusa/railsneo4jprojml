# app/controllers/metrics_controller.rb
class MetricsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:log_metric, :delete_metric]
  
    # POST /metric/:key
    def log_metric
      key = params[:key]
      value = params[:value].to_i
      metric = Metric.new(key, value)
      metric.save
  
      render json: {}, status: :ok
    end
  
    # DELETE /metric/:key
    def delete_metric
      key = params[:key]
      Metric.delete_by_key(key)
  
      render json: {}, status: :ok
    end
  
    # GET /metrics
    def get_metrics
        puts "Fetching metrics aggregated for the last hour..."
        metrics = Metric.aggregated_last_hour
        puts "Metrics fetched: #{metrics.inspect}"
        render json: metrics, status: :ok
      end
  end
  