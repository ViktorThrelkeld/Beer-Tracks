require 'csv'

class Importer
  def self.import(from_filename)
    CSV.foreach(from_filename, headers: true) do |row_hash|
     import_product(row_hash)
    Style.create(row_hash["style"])
  end
end

def self.import_product(row_hash)
  entries = Entries.create(
    name: row_hash["beer_name"],
    # style: row_hash["style"],
    ounces: row_hash["ounces"].to_i,
    cost: row_hash["cost"].to_f
    )
  end
end