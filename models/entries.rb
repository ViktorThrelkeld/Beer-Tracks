class Entries
  attr_accessor :name, :ounces, :cost, :style
  attr_reader :id

  def initialize attributes = {}
    update_attributes(attributes)
    self.style ||= Style.default
  end

  def cost=(cost)
    @cost = cost.to_f
  end

  def ounces=(ounces)
    @ounces = ounces.to_i
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

  def delete attribute
    database = Environment.database_connection
    database.execute("delete from entries where id = #{id}")
  end

  def save
    database = Environment.database_connection
    style_id = style.nil? ? "NULL" : style.id
    if id
      database.execute("update entries set name = '#{name}', ounces = '#{ounces}', cost = '#{cost}', style_id = #{style_id} where id = #{id}")
    else
      database.execute("insert into entries(name, ounces, cost, style_id) values('#{name}', #{ounces}, #{cost}, #{style_id})")
      @id = database.last_insert_row_id
    end
  end

  def self.find id
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select * from entries where id = #{id}")[0]
    if results
      entries = Entries.new(name: results["name"], ounces: results["ounces"], cost: results["cost"])
      entries.send("id=", results["id"])
      entries
    else
      nil
    end
  end

  def self.search(search_term = nil)
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select entries.* from entries where name LIKE '%#{search_term}%' order by name ASC")
    results.map do |row_hash|
      entries = Entries.new(
        name: row_hash["name"],
        ounces: row_hash["ounces"],
        cost: row_hash["cost"])
      style = Style.all.find{|style| style.id == row_hash["style_id"]}
      entries.style = style
      entries.send("id=", row_hash["id"])
      entries
    end
  end

  def self.all
    search
  end


  def cost
    sprintf('%.2f', @cost) if @cost
  end

  def to_s
    "#{name}: #{ounces} oz, $#{cost}, id: #{id}"
  end

  def ==(other)
     other.is_a?(Entries) && self.to_s == other.to_s
  end

  def total_calories
    total = ounces * style.calories_per_ounce
    total
  end

  protected

  def id=(id)
    @id = id
  end

  def update_attributes(attributes)
    [:name, :ounces, :cost, :style].each do |attr|
      if attributes[attr]
        self.send("#{attr}=", attributes[attr])
      end
    end
  end
end