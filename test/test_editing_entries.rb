require_relative 'helper'

class TestEditingEntries < BeerTest
  def test_updating_a_record_that_exists
    entries = Entries.new(name: "Guinness", ounces: 12, cost: 5.50)
    entries.save
    id = entries.id
    command = "./beertracks edit --id #{id} --name Guinness! --ounces 20 --cost 10.50"
    expected = "Entry #{id} is now named Guinness!, with 20 ounces and $10.50 cost."
    # What about the db?
    assert_command_output expected, command
  end

  def test_attempting_to_update_a_nonexistant_record
    command = "./beertracks edit --id 218903123980123 --name Guinness! --ounces 12 --cost 5.50"
    expected = "Entry 218903123980123 couldn't be found."
    assert_command_output expected, command
  end

  def test_attempting_to_update_with_no_changes
    entries = Entries.new(name: "Guinness", ounces: 12, cost: 5.50)
    entries.save
    id = entries.id
    command = "./beertracks edit --id #{id} --name Guinness --ounces 12 --cost 5.50"
    expected = "Entry #{id} is now named Guinness, with 12 ounces and $5.50 cost."
    assert_command_output expected, command
  end

  def test_attempting_to_update_with_bad_data
    skip
    entries = Entries.new(name: "Guinness", ounces: 12, cost: 5.50)
    entries.save
    id = entries.id #<--- First thing we have to implement
    command = "./beertracks edit --id #{id} --name Guiness --ounces 12 --cost fifty"
    expected = "Purchase #{id} can't be updated.  Price must be a number."
    assert_command_output expected, command
  end

  def test_attempting_to_update_partial_data
    skip
    entries = Entries.new(name: "Guinness", ounces: 12, cost: 5.50)
    entries.save
    id = entries.id #<--- First thing we have to implement
    command = "./beertracks edit --id #{id} --name Guinness!"
    expected = "Purchase #{id} is now named Guinness!,  with 20 ounces and $10.50 cost."
    assert_command_output expected, command
  end
end