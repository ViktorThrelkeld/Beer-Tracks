class Entries < ActiveRecord::Base
  belongs_to :style
  default_scope { order("name ASC")}
  before_create :set_default_style

  def cost=(cost)
    @cost = cost.to_f
  end

  def ounces=(ounces)
    @ounces = ounces.to_i
  end

  def self.search(search_term = nil)

    Entries.where("name LIKE ?", "%#{search_term}%").to_a
  end

  def formatted_cost
    "$%04.2f" % cost
  end

  def to_s
    "#{name}: #{ounces} oz, #{formatted_cost}, id: #{id}"
  end

  def total_calories
    total = ounces * style.calories_per_ounce
    total
  end

private

  def set_default_style
    self.style ||=Style.default
  end
end