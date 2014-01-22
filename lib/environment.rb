class Environment
  def self.database_connection(environment = "production")
    @connection ||= SQLite3::Database.new("db/beertracks_#{environment}.sqlite3")
  end
end