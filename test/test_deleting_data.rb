require_relative 'helper'

class TestDeletingEntries < BeerTest
  def test_deleting_a_record_that_exists
    entries = Entries.new(name: "Guinness", ounces: 12, cost: 5.50)
    entries.save
    id = entries.id
    command = "./beertracks delete --id #{id}"
    expected = "Entry #{entries.id} which was Guinness, with 12 ounces and $5.50 cost has been deleted."
    assert_command_output expected, command
  end
end