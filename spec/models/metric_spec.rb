# spec/models/metric_spec.rb
require 'rails_helper'

RSpec.describe Metric, type: :model do
  describe '#save' do
    it 'saves a metric with valid attributes' do
      metric = Metric.new('test_key', 10)
      expect { metric.save }.not_to raise_error
    end
  end

  describe '.delete_by_key' do
    it 'deletes metrics by key' do
      metric = Metric.new('test_key', 10)
      metric.save
      expect { Metric.delete_by_key('test_key') }.not_to raise_error
    end
  end

  describe '.aggregated_last_hour' do
    it 'returns aggregated metrics for the last hour' do
      metric1 = Metric.new('test_key', 10, Time.now - 30.minutes)
      metric2 = Metric.new('test_key', 15, Time.now - 30.minutes)
      metric1.save
      metric2.save

      result = Metric.aggregated_last_hour
      expect(result).to include({ key: 'test_key', total: 25 })
    end
  end
end

