class Style < ActiveRecord::Base
  default_scope { order("name ASC")}


  def self.default
    Style.find_or_create_by(name: "Unknown", calories_per_ounce: 12)
  end
end