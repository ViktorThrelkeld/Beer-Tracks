require_relative 'helper'

class TestListingEntries < BeerTest
  def test_list_returns_relevant_results
    bush = Entries.create(name: "Bush", type: "pilsner", ounces: 12, cost: 5.50)
    guinness = Entries.create(name: "Guinness", type: "stout", ounces: 12, cost: 5.50)
    stella = Entries.create(name: "Stella", type: "pilsner", ounces: 12, cost: 5.00)

    command = "./beertracks list"
    expected = <<EOS.chomp
All Entries:
Bush: pilsner type, 12 oz, $5.50, id: #{bush.id}
Guinness: stout type, 12 oz, $5.50, id: #{guinness.id}
Stella: pilsner type, 12 oz, $5.00, id: #{stella.id}
EOS
    assert_command_output expected, command
  end
end