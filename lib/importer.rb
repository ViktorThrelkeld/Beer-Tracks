require 'csv'

class Importer
  def self.import(from_filename)
    CSV.foreach(from_filename, headers: true) do |row_hash|
      if row_hash.has_key?("beer_name")
        import_entries(row_hash)
      else
        import_styles(row_hash)
      end
    end
  end

def self.import_entries(row_hash)
  # style = Style.find_or_create(name: row_hash["style"])
  style = Style.find_or_create_by(name: row_hash["style"].strip)

  entries = Entries.create(
    name: row_hash["beer_name"].strip,
    ounces: row_hash["ounces"].to_i,
    cost: row_hash["cost"].to_f,
    style: style
    )
  end

  def self.import_styles(row_hash)
    style = Style.find_or_create(name: row_hash["style"], abv: row_hash["abv"], calories_per_ounce: row_hash["calories_per_ounce"])
  end
end