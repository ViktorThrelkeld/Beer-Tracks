
class Entries

  def self.create(options)
    require "sqlite3"
    database = Environment.database_connection(options[:environment])
    statement = "insert into entries(name, style, ounces, cost) values('#{options[:name]}', '#{options[:style]}', #{options[:ounces]}, #{options[:cost]})"
    database.execute(statement)
    puts "I drank #{options[:ounces]} oz of #{options[:name]}, which is a #{options[:style]} style beer, costing me $#{options[:cost]}"
  end

  def self.search(options)
  end

end