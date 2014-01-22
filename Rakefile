 #!/usr/bin/env ruby
# -*- ruby -*-



require 'rake/testtask'

Rake::TestTask.new() do |t|
  t.pattern = "test/test_*.rb"
end

desc "Run tests"
task :default => :test

task :bootstrap_database do
  require 'sqlite3'
  database = SQLite3::Database.new("db/beertracks_test.sqlite3")
  database.execute("CREATE TABLE entries (id INTEGER PRIMARY KEY AUTOINCREMENT, name varchar(50), style varchar(20), ounces integer, cost decimal(5,2))")
end