require 'neo4j/driver'

# config/initializers/neo4j.rb
require 'neo4j/driver'

begin
  driver = Neo4j::Driver::GraphDatabase.driver(
    'neo4j+s://22fc6445.databases.neo4j.io:7687',
    Neo4j::Driver::AuthTokens.basic('neo4j', 'F-Wk-Zwmburp8Eq9tUgUjABlnwWlTvZf3ut79tUQNBU')
  )
  

  # Verifica si la conexión es exitosa
  driver.verify_connectivity
  $neo4j_driver = driver
  puts "Connected to Neo4j Aura: #{driver}"

rescue Neo4j::Driver::Exceptions::ServiceUnavailableException => e
  puts "Failed to connect to Neo4j Aura: #{e.message}"
  $neo4j_driver = nil
rescue StandardError => e
  puts "An unexpected error occurred: #{e.message}"
  $neo4j_driver = nil
end