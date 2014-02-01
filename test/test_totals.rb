require_relative 'helper'
class TestTotals < BeerTest
  def test_totals_of_price_and_calories
    style1 = Style.find_or_create(name: "porter", calories_per_ounce: 8)
    style2 = Style.find_or_create(name: "IPA", calories_per_ounce: 15)
    Entries.create(name: "YazooPale", ounces: 20, cost: 8, style: style1)
    Entries.create(name: "Guiness", ounces: 12, cost: 12, style: style2)
    shell_output = ""
    IO.popen('./beertracks total --environment test', 'r+') do |pipe|
      pipe.close_write
      shell_output = pipe.read
    end
    assert_in_output shell_output, "Your total cost was $20.0 and your total calories was 340"
  end
end