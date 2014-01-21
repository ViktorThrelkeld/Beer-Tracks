require_relative 'helper'

class TestEnteringData < MiniTest::Unit::TestCase

  def test_valid_entry_gets_saved
    skip "needs implementation"
    assert false, "Missing test implementation"
  end

  def test_invalid_entry_doesnt_get_saved
    skip "needs implementation"
    assert false, "Missing test implementation"
  end

  def test_error_message_for_missing_cost
    skip "needs implementation"
    assert false, "Missing test implementation"
  end

  def test_error_message_for_cost
    command = "./beertracks add YazooPale --oz 12"
    expected = "You must provide the cost of the beer you drank."
    assert_command_output expected, command
  end

  def test_error_message_for_missing_oz_and_cost
    command = "./beertracks add YazooPale"
    expected = "You must provide the cost and total ounces of the beer you drank."
    assert_command_output expected, command
  end

  def test_error_message_for_missing_oz
    command = "./beertracks add YazooPale --cost 5"
    expected = "You must provide the total ounces of the beer you drank."
    assert_command_output expected, command
  end

  def test_error_message_for_missing_beer_name
    command = "./beertracks add"
    expected = "You must provide the name of the beer you drank."
    assert_command_output expected, command
  end
end