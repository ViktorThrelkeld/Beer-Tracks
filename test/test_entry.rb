require_relative 'helper'
require_relative '../models/entries'

class TestEntry < BeerTest
  def test_to_s_prints_details
    entries = Entries.new(name: "FooBeer", style: "porter", ounces: "20", cost: "10.00")
    expected = "FooBeer: porter style, 20 oz, $10.00, id: #{entries.id}"
    assert_equal expected, entries.to_s
  end

 def test_update_doesnt_insert_new_row
    entries = Entries.create(name: "Foo", style: "stout", ounces: "12", cost: "5.50")
    foos_before = database.execute("select count(id) from entries")[0][0]
    entries.update(name: "Bar")
    foos_after = database.execute("select count(id) from entries")[0][0]
    assert_equal foos_before, foos_after
  end

  def test_update_saves_to_the_database
    entries = Entries.create(name: "Foo", style: "stout", ounces: "12", cost: "5.50")
    id = entries.id
    entries.update(name: "Bar", style: "stout", ounces: "6", cost: "10.50")
    updated_entries = Entries.find(id)
    expected = ["Bar", "stout", 6, "10.50" ]
    actual = [ updated_entries.name, updated_entries.style, updated_entries.ounces, updated_entries.cost]
    assert_equal expected, actual
  end

  def test_update_is_reflected_in_existing_instance
    entries = Entries.create(name: "Foo", style: "stout", ounces: "12", cost: "5.50")
    entries.update(name: "Bar", style: "stout", ounces: "20", cost: "10.50")
    expected = ["Bar", "stout", 20, "10.50" ]
    actual = [ entries.name, entries.style, entries.ounces, entries.cost]
    assert_equal expected, actual
  end


  def test_saved_entries_are_saved
    entries = Entries.new(name: "Foo", style: "pilsner", ounces: "12", cost: "5.50")
    foos_before = database.execute("select count(id) from entries")[0][0]
    entries.save
    foos_after = database.execute("select count(id) from entries")[0][0]
    assert_equal foos_before +1, foos_after
  end

  def test_save_creates_an_id
    entries = Entries.create(name: "Foo", style: "pilsner", ounces: "12", cost: "5.50")
    refute_nil entries.id, "Entries id shouldn't be nil"
  end

  def test_search_returns_entries_objects
    Entries.create(name: "Foo", style: "pilsner", ounces: "12", cost: "5.50")
    Entries.create(name: "Guinness", style: "pilsner", ounces: "12", cost: "5.50")
    Entries.create(name: "Guinness Draught", style: "pilsner", ounces: "12", cost: "5.50")
    results = Entries.search("Guinness")
    assert results.all?{ |result| result.is_a? Entries }, "Not all results were Entries"
  end


  def test_search_returns_appropriate_results
    entry1 = Entries.create(name: "Foo", style: "pilsner", ounces: "12", cost: "5.50")
    entry2 = Entries.create(name: "Guinness", style: "pilsner", ounces: "12", cost: "5.50")
    entry3 = Entries.create(name: "Guinness Draught", style: "pilsner", ounces: "12", cost: "5.50")
    expected = [entry2, entry3]
    actual = Entries.search("Guinness")
    assert_equal expected, actual
  end

  def test_search_returns_empty_array_if_no_results
    Entries.create(name: "Foo", style: "pilsner", ounces: "12", cost: "5.50")
    Entries.create(name: "Guinness", style: "pilsner", ounces: "12", cost: "5.50")
    Entries.create(name: "Guinness Draught", style: "pilsner", ounces: "12", cost: "5.50")
    results = Entries.search("Soda")
    assert_equal [], results
  end

  def test_all_returns_all_entries_in_alphabetical_order
    Entries.create(name: "foo", style: "stout", ounces: "12", cost: "5.50")
    Entries.create(name: "bar", style: "stout", ounces: "12", cost: "5.50")
    results = Entries.all
    expected = ["bar", "foo"]
    actual = results.map{ |entry| entry.name }
    # ^ is equivalent to:
    # actual = []
    # results.each do |entries|
    #   actual << entries.name
    # end
    assert_equal expected, actual
  end

  def test_all_returns_empty_array_if_no_entries
    results = Entries.all
    assert_equal [], results
  end

 def test_equality_on_same_object
    entries = Entries.create(name: "foo", style: "stout", ounces: "12", cost: "5.50")

    assert entries == entries
  end

  def test_equality_with_different_class
    entries = Entries.create(name: "foo", style: "stout", ounces: "12", cost: "5.50")
    refute entries == "Entries"
  end

  def test_equality_with_different_entries
    entries1 = Entries.create(name: "foo", style: "stout", ounces: "12", cost: "5.50")
    entries2 = Entries.create(name: "bar", style: "stout", ounces: "12", cost: "5.50")
    refute entries1 == entries2
  end

  def test_equality_with_same_entries_different_object_id
    entries1 = Entries.create(name: "foo", style: "stout", ounces: "12", cost: "5.50")
    entries2 = Entries.find(entries1.id)
    assert entries1 == entries2
  end

end