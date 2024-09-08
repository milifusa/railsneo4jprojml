# app/models/metric.rb
class Metric
    attr_accessor :key, :value, :created_at
  
    def initialize(key, value, created_at = Time.now)
      @key = key
      @value = value
      @created_at = created_at
    end
  
    def save
      $neo4j_driver.session do |session|
        session.write_transaction do |tx|
          tx.run("CREATE (m:Metric {key: $key, value: $value, created_at: datetime($created_at)})",
                 key: @key, value: @value, created_at: @created_at.iso8601)
        end
      end
    end
  
    def self.delete_by_key(key)
      $neo4j_driver.session do |session|
        session.write_transaction do |tx|
          tx.run("MATCH (m:Metric {key: $key}) DELETE m", key: key)
        end
      end
    end
  
    def self.aggregated_last_hour
        one_hour_ago = (Time.now - 1.hour).iso8601
      
        result = []
      
        $neo4j_driver.session do |session|
          session.read_transaction do |tx|
            query = <<-CYPHER
              MATCH (m:Metric)
              WHERE m.created_at >= datetime($one_hour_ago)
              RETURN m.key AS key, sum(m.value) AS total
            CYPHER
      
            tx.run(query, one_hour_ago: one_hour_ago).each do |record|
              result << { key: record[:key], total: record[:total] }
            end
          end
        end
      
        result
      end
  
    private
  
    
  end
  