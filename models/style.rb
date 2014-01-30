class Style
  attr_accessor :name
  attr_reader :id

  def initialize(name)
    self.name = name
  end

  def name=(name)
    @name = name.strip
  end

  def self.all
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select * from style order by name ASC")
    results.map do |row_hash|
      style = Style.new(row_hash["name"])
      style.send("id=", row_hash["id"])
      style
    end
  end

  def self.find_or_create name
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select * from style where name = '#{name}'")
    style = Style.new(name)

    if results.empty?
      database.execute("insert into style(name) values('#{style.name}')")
      style.send("id=", database.last_insert_row_id)
    else
      row_hash = results[0]
      style.send("id=", row_hash["id"])
    end
    style
  end

  protected

  def id=(id)
    @id = id
  end
end