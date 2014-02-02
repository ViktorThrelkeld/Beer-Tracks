require 'pry'
class Style
  attr_accessor :name, :abv, :calories_per_ounce
  attr_reader :id

  def self.default
    @@default ||= Style.find_or_create(name: "Unknown")
  end

  def initialize attributes = {}
    update_attributes(attributes)
  end

  def name=(name)
    @name = name.strip
  end

  def self.all
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select * from style order by name ASC")
    results.map do |row_hash|
      style = Style.new(name: row_hash["name"], abv: row_hash["abv"], calories_per_ounce: row_hash["calories_per_ounce"])
      style.send("id=", row_hash["id"])
      style
    end
  end

  def self.find_or_create attributes = {}
    database = Environment.database_connection
    database.results_as_hash = true
    style = Style.new(attributes)
    results = database.execute("select * from style where name = '#{style.name}'")
    if results.empty?
      database.execute("insert into style(name, abv, calories_per_ounce) values('#{style.name}', #{attributes[:abv].to_f}, #{attributes[:calories_per_ounce].to_f})")
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

  def update_attributes(attributes)
    [:name, :abv, :calories_per_ounce].each do |attr|
      if attributes[attr]
        self.send("#{attr}=", attributes[attr])
      end
    end
  end
end