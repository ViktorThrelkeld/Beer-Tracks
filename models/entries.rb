class Entries
  attr_accessor :name, :style, :ounces, :cost

  def initialize attributes = {}
    [:name, :style, :ounces, :cost].each do |attr|
      self.send("#{attr}=", attributes[attr])
    end
  end

  def save
    database = Environment.database_connection
    database.execute("insert into entries(name, style, ounces, cost) values('#{name}', '#{style}', #{ounces}, #{cost})")
  end

  def self.all
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select * from entries order by name ASC")
    results.map do |row_hash|
      Entries.new(name: row_hash["name"], style: row_hash["style"], ounces: row_hash["ounces"], cost: row_hash["cost"])
    end
  end

  def to_s
    formatted_cost = sprintf('%.2f', cost)
    "#{name}: #{style} style, #{ounces} oz, $#{formatted_cost}"
  end
end