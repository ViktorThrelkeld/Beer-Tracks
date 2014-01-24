require_relative 'helper'
require_relative '../models/entries'

class TestEntry < BeerTest
  def test_to_s_prints_details
    purchase = Entries.new(name: "FooBeer", style: "porter", ounces: "20", cost: "10.00")
    expected = "FooBeer: porter style, 20 oz, $10.00"
    assert_equal expected, purchase.to_s
  end
end