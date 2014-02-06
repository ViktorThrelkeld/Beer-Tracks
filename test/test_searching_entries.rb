require_relative 'helper'


class TestSearchingEntries < BeerTest
  def test_search_returns_relevant_results
    Entries.create(name: "YazooPale", ounces: 20, cost: 8)
    Entries.create(name: "Guiness", ounces: 12, cost: 12)
    Entries.create(name: "Bush", ounces: 12, cost: 2)

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