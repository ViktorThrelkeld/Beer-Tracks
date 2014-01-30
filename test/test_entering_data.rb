require_relative 'helper'


class TestEnteringData < BeerTest
  def test_valid_drinking_information_gets_printed
    command = "./beertracks add 'Yazoo Pale' --ounces 40 --cost 10 --type pale"
    expected = "I drank 40 oz of Yazoo Pale, which is a pale type beer, costing me $10"
    assert_command_output expected, command
  end

  def test_valid_drinking_information_gets_saved
    database.results_as_hash = false
    `./beertracks add 'Yazoo Pale' --ounces 40 --cost 10 --type pale --environment test`
    results = database.execute("select name, type, ounces, cost from entries")
    expected = ["Yazoo Pale", "pale", 40, 10]
    assert_equal expected, results[0]

    result = database.execute("select count(id) from entries")
    assert_equal 1, result[0][0]
  end

  def test_invalid_drinking_information_doesnt_get_saved
    `./beertracks add Guiness --type stout`
    result = database.execute("select count(id) from entries")
    assert_equal 0, result[0][0]
  end

  def test_error_message_for_missing_cost
    command = "./beertracks add 'Yazoo Pale' --ounces 12 --type pale"
    expected = "You must provide the cost of the beer you drank."
    assert_command_output expected, command
  end

  def test_error_message_for_missing_oz_and_cost
    command = "./beertracks add YazooPale --type pale"
    expected = "You must provide the cost and total ounces of the beer you drank."
    assert_command_output expected, command
  end

  def test_error_message_for_missing_oz_and_cost_and_type
    command = "./beertracks add YazooPale"
    expected = "You must provide the type and cost and total ounces of the beer you drank."
    assert_command_output expected, command
  end

  def test_error_message_for_missing_oz
    command = "./beertracks add YazooPale --cost 5 --type pale"
    expected = "You must provide the total ounces of the beer you drank."
    assert_command_output expected, command
  end

  def test_error_message_for_missing_beer_name
    command = "./beertracks add"
    expected = "You must provide the name of the beer you drank.\nYou must provide the type and cost and total ounces of the beer you drank."
    assert_command_output expected, command
  end
end
