require_relative 'helper'
require_relative '../models/entries'

class TestEntry < BeerTest
  def test_to_s_prints_details
    entry = Entries.new(name: "FooBeer", style: "porter", ounces: "20", cost: "10.00")
    expected = "FooBeer: porter style, 20 oz, $10.00"
    assert_equal expected, entry.to_s
  end

  def test_all_returns_all_entries_in_alphabetical_order
    database.execute("insert into entries(name, style, ounces, cost) values('foo', 'porter', 12, 1.50)")
    database.execute("insert into entries(name, style, ounces, cost) values('bar', 'stout', 5, 1.00)")
    results = Entries.all
    expected = ["bar", "foo"]
    actual = results.map{ |entry| entry.name }
    # ^ is equivalent to:
    # actual = []
    # results.each do |purchase|
    #   actual << purchase.name
    # end
    assert_equal expected, actual
  end

  def test_all_returns_empty_array_if_no_entries
    results = Entries.all
    assert_equal [], results
  end
end