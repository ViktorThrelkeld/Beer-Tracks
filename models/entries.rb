class Entries
  attr_accessor :name, :style, :ounces, :cost
  attr_reader :id

  def initialize attributes = {}
    update_attributes(attributes)
  end

  def self.create(attributes = {})
    entries = Entries.new(attributes)
    entries.save
    entries
  end

  def update attributes = {}
    update_attributes(attributes)
    save
  end

  def save
    database = Environment.database_connection
    if id
      database.execute("update entries set name = '#{name}', style = '#{style}', ounces = '#{ounces}', cost = '#{cost}' where id = #{id}")
    else
      database.execute("insert into entries(name, style, ounces, cost) values('#{name}', '#{style}', #{ounces}, #{cost})")
      @id = database.last_insert_row_id
    end
  end

  def self.find id
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select * from entries where id = #{id}")[0]
    if results
      entries = Entries.new(name: results["name"], style: results["style"], ounces: results["ounces"], cost: results["cost"])
      entries.send("id=", results["id"])
      entries
    else
      nil
    end
  end

  def self.all
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select * from entries order by name ASC")
    results.map do |row_hash|
    entries = Entries.new(name: row_hash["name"], style: row_hash["style"], ounces: row_hash["ounces"], cost: row_hash["cost"])
    entries.send("id=", row_hash["id"])
    entries
    end
  end

  def cost
    sprintf('%.2f', @cost) if @cost
  end

  def to_s
    "#{name}: #{style} style, #{ounces} oz, $#{cost}, id: #{id}"
  end

  protected

  def id=(id)
    @id = id
  end

  def update_attributes(attributes)
    [:name, :style, :ounces, :cost].each do |attr|
      if attributes[attr]
        self.send("#{attr}=", attributes[attr])
      end
    end
  end
end