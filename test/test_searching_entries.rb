require_relative 'helper'


class TestSearchingPurchases < BeerTest
  def test_search_returns_relevant_results
    `./beertracks add "YazooPale" --ounces 20 --cost 8 --environment test`
    `./beertracks add "Guiness" --ounces 12 --cost 12 --environment test`
    `./beertracks add "Bush" --ounces 12 --cost 2 --environment test`

    shell_output = ""
    IO.popen('./beertracks search --environment test', 'r+') do |pipe|
      pipe.puts("Bush")
      pipe.close_write
      shell_output = pipe.read
    end
    assert_in_output shell_output, "Bush"
    assert_not_in_output shell_output, "Guiness"
  end
end