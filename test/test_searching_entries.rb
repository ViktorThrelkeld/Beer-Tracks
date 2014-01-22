require_relative 'helper'
require 'sqlite3'

class TestSearchingPurchases < BeerTest
  def test_search_returns_relevant_results
    `./beertracks add "YazooPale" --style "pale" --oz 20 --cost 8 --environment test`
    `./beertracks add "Guiness" --style "stout" --oz 12 --cost 12 --environment test`
    `./beertracks add "Bush" --style "pilsner" --oz 12 --cost 2 --environment test`

    shell_output = ""
    IO.popen('./beertracks search', 'r+') do |pipe|
      pipe.puts("Bush")
      pipe.close_write
      shell_output = pipe.read
    end
    assert_in_output shell_output, "Bush"
    assert_not_in_output shell_output, "Guiness"
  end
end