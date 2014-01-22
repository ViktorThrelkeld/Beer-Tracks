require_relative 'helper'

class TestEnteringData < MiniTest::Unit::TestCase
  def test_valid_drinking_information_gets_printed
    command = "./beertracks add YazooPale --oz 40 --cost 10 --style pale"
    expected = "Theoretically creating: I drank 40 oz of YazooPale, which is a pale style beer, costing me $10"
    assert_command_output expected, command
  end

  def test_valid_entry_gets_saved
    skip "needs implementation"
    assert false, "Missing test implementation"
  end

  def test_invalid_entry_doesnt_get_saved
    skip "needs implementation"
    assert false, "Missing test implementation"
  end

  def test_error_message_for_missing_cost
    command = "./beertracks add YazooPale --oz 12 --style pale"
    expected = "You must provide the cost of the beer you drank."
    assert_command_output expected, command
  end

  def test_error_message_for_missing_oz_and_cost
    command = "./beertracks add YazooPale --style pale"
    expected = "You must provide the cost and total ounces of the beer you drank."
    assert_command_output expected, command
  end

  def test_error_message_for_missing_oz_and_cost_and_style
    command = "./beertracks add YazooPale"
    expected = "You must provide the style and cost and total ounces of the beer you drank."
    assert_command_output expected, command
  end

  def test_error_message_for_missing_oz
    command = "./beertracks add YazooPale --cost 5 --style pale"
    expected = "You must provide the total ounces of the beer you drank."
    assert_command_output expected, command
  end

  def test_error_message_for_missing_beer_name
    command = "./beertracks add"
    expected = "You must provide the name of the beer you drank.\nYou must provide the style and cost and total ounces of the beer you drank."
    assert_command_output expected, command
  end
end