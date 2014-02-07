class Entry < ActiveRecord::Base
  belongs_to :style
  default_scope { order("name ASC")}
  before_create :set_default_style

  def self.search(search_term = nil)
    Entry.where("name LIKE ?", "%#{search_term}%").to_a
  end

  def formatted_cost
    "$%04.2f" % cost
  end

  def to_s
    "#{name}: #{ounces} oz, #{formatted_cost}, id: #{id}"
  end

private

  def set_default_style
    self.style ||=Style.default
  end
end