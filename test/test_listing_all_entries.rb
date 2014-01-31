require_relative 'helper'

class TestListingEntries < BeerTest
  def test_list_returns_relevant_results
    bush = Entries.create(name: "Bush", ounces: 12, cost: 5.50)
    guinness = Entries.create(name: "Guinness", ounces: 12, cost: 5.50)
    stella = Entries.create(name: "Stella", ounces: 12, cost: 5.00)

    command = "./beertracks list"
    expected = <<EOS.chomp
All Entries:
Bush: 12 oz, $5.50, id: #{bush.id}
Guinness: 12 oz, $5.50, id: #{guinness.id}
Stella: 12 oz, $5.00, id: #{stella.id}
EOS
    assert_command_output expected, command
  end
end