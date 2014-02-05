require_relative 'helper'
class TestAverage < BeerTest
  def test_average_of_price_calories_abv
    style1 = Style.find_or_create(name: "porter", abv: 4.5, calories_per_ounce: 8)
    style2 = Style.find_or_create(name: "IPA", abv: 6, calories_per_ounce: 15)
    Entries.create(name: "YazooPale", ounces: 20, cost: 7, style: style1)
    Entries.create(name: "Guiness", ounces: 12, cost: 5, style: style2)
    shell_output = ""
    IO.popen('./beertracks average --environment test', 'r+') do |pipe|
      pipe.close_write
      shell_output = pipe.read
    end
    assert_in_output shell_output, "Your average beer costs you $6.00, adds 170 calories to your diet, and has an abv of 5.1%."
  end

  def test_average_of_price_calories_abv_II
    style1 = Style.find_or_create(name: "porter", abv: 6.5, calories_per_ounce: 8)
    style2 = Style.find_or_create(name: "IPA", abv: 3.5, calories_per_ounce: 15)
    Entries.create(name: "YazooPale", ounces: 12, cost: 7, style: style1)
    Entries.create(name: "Guiness", ounces: 72, cost: 5, style: style2)
    shell_output = ""
    IO.popen('./beertracks average --environment test', 'r+') do |pipe|
      pipe.close_write
      shell_output = pipe.read
    end
    assert_in_output shell_output, "Your average beer costs you $1.71, adds 168 calories to your diet, and has an abv of 3.9%."
  end

end