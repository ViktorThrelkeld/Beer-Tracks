require_relative 'helper'

class TestListingEntries < BeerTest
  def test_list_returns_relevant_results
    `./beertracks add Stella --style pilsner --ounces 12 --cost 5 --environment test`
    `./beertracks add Guiness --style stout --ounces 12 --cost 5.50 --environment test`
    `./beertracks add Bush --style pilsner --ounces 12 --cost 5.50 --environment test`

    command = "./beertracks list"
    expected = <<EOS.chomp
All Entries:
Bush: pilsner style, 12 oz, $5.50
Guiness: stout style, 12 oz, $5.50
Stella: pilsner style, 12 oz, $5.00
EOS
    assert_command_output expected, command
  end
end