class Entries
  attr_accessor :name, :style, :ounces, :cost

  def initialize attributes = {}
    # Long Way: @price = attributes[:price]
    # Short Way:
    attributes.each_pair do |attribute, value|
      self.send("#{attribute}=", value)
    end
  end

  def to_s
    "#{name}: #{style} style, #{ounces} oz, $#{cost}"
  end
end