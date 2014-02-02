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
    assert_in_output shell_output, "You are $20.00 poorer and 340 calories fatter."
  end
  def test_totals_of_cost_greater_than_100
    style1 = Style.find_or_create(name: "porter", calories_per_ounce: 8)
    style2 = Style.find_or_create(name: "IPA", calories_per_ounce: 15)
    Entries.create(name: "YazooPale", ounces: 20, cost: 100, style: style1)
    Entries.create(name: "Guiness", ounces: 12, cost: 12, style: style2)
    shell_output = ""
    IO.popen('./beertracks total --environment test', 'r+') do |pipe|
      pipe.close_write
      shell_output = pipe.read
    end
    assert_includes shell_output, "You are $112.00 poorer and 340 calories fatter.\nYou are on your way to being a homeless drunk."
  end

  def test_totals_of_calories_greater_than_10000
    style1 = Style.find_or_create(name: "porter", calories_per_ounce: 1)
    style2 = Style.find_or_create(name: "IPA", calories_per_ounce: 10000)
    Entries.create(name: "YazooPale", ounces: 20, cost: 10, style: style1)
    Entries.create(name: "Guiness", ounces: 1, cost: 12, style: style2)

    shell_output = ""
    IO.popen('./beertracks total --environment test', 'r+') do |pipe|
      pipe.close_write
      shell_output = pipe.read
    end
    assert_includes shell_output, "You are $22.00 poorer and 10020 calories fatter.\nYou are a fatass drunk."
  end

  def test_totals_of_cost_greater_than_100_calories_greater_than_10000
    style1 = Style.find_or_create(name: "porter", calories_per_ounce: 1)
    style2 = Style.find_or_create(name: "IPA", calories_per_ounce: 10000)
    Entries.create(name: "YazooPale", ounces: 20, cost: 100, style: style1)
    Entries.create(name: "Guiness", ounces: 1, cost: 12, style: style2)

    shell_output = ""
    IO.popen('./beertracks total --environment test', 'r+') do |pipe|
      pipe.close_write
      shell_output = pipe.read
    end
    assert_includes shell_output, "You are $112.00 poorer and 10020 calories fatter.\nYou are on your way to being a homeless fatass drunk."
  end


end