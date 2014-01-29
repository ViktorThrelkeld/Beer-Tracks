 #!/usr/bin/env ruby
# -*- ruby -*-

require_relative 'lib/environment'
require 'rake/testtask'

Rake::TestTask.new() do |t|
  t.pattern = "test/test_*.rb"
end

desc "Run tests"
task :default => :test

desc 'create the production database setup'
task :bootstrap_database do
  Environment.environment = "production"
  database = Environment.database_connection
   create_tables(database)
end

desc 'prepare the test database'
task :test_prepare do
  File.delete("db/beertracks_test.sqlite3")
  Environment.environment = "test"
  database = Environment.database_connection
  create_tables(database)
end

def create_tables(database_connection)
  database_connection.execute("CREATE TABLE entries (id INTEGER PRIMARY KEY AUTOINCREMENT, name varchar(50), style varchar(20), ounces integer, cost decimal(5,2))")
  database_connection.execute("CREATE TABLE categories (id INTEGER PRIMARY KEY AUTOINCREMENT, name varchar(50))")
end