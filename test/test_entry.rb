require_relative 'helper'


class TestEntry < BeerTest
  def test_count_when_no_entries
    assert_equal 0, Entry.count
  end

  def test_count_of_multiple_entries
    Entry.create(name: "foo", ounces: 40, cost: 1.50)
    Entry.create(name: "Guinness", ounces: 20, cost: 2.50)
    Entry.create(name: "Heineken", ounces: 72, cost: 8.50)
    assert_equal 3, Entry.count
  end

  def test_style_defaults_to_unknown
    entries = Entry.create(name: "Foo", ounces: "20", cost: "10")
    assert_equal "Unknown", entries.style.name
  end


  def test_to_s_prints_details
    entries = Entry.new(name: "FooBeer", ounces: "20", cost: "10.00")
    expected = "FooBeer: 20 oz, $10.00, id: #{entries.id}"
    assert_equal expected, entries.to_s
  end

 def test_update_doesnt_insert_new_row
    entries = Entry.create(name: "Foo", ounces: "12", cost: "5.50")
    foos_before = Entry.count
    entries.update(name: "Bar")
    foos_after = Entry.count
    assert_equal foos_before, foos_after
  end

  def test_update_saves_to_the_database
    entries = Entry.create(name: "Foo", ounces: "12", cost: "5.50")
    id = entries.id
    entries.update(name: "Bar", ounces: "6", cost: "10.50")
    updated_entries = Entry.find(id)
    expected = ["Bar", 6, 10.50 ]
    actual = [ updated_entries.name, updated_entries.ounces, updated_entries.cost]
    assert_equal expected, actual
  end

  def test_update_is_reflected_in_existing_instance
    entries = Entry.create(name: "Foo", ounces: "12", cost: "5.50")
    entries.update(name: "Bar", ounces: "20", cost: "10.50")
    expected = ["Bar", 20, 10.50 ]
    actual = [ entries.name, entries.ounces, entries.cost]
    assert_equal expected, actual
  end


  def test_saved_entries_are_saved
    entries = Entry.new(name: "Foo", ounces: "12", cost: "5.50")
    foos_before = Entry.count
    entries.save
    foos_after = Entry.count
    assert_equal foos_before +1, foos_after
  end

  def test_save_creates_an_id
    entries = Entry.create(name: "Foo", ounces: "12", cost: "5.50")
    refute_nil entries.id, "Entry id shouldn't be nil"
  end

  def test_save_saves_style_id
    style = Style.find_or_create_by(name: "Barley Wine")
    entries = Entry.create(name: "Foo", ounces: 6, cost: 5.00, style: style)
    # style_id = database.execute("select style_id from entries where id='#{entries.id}'")[0][0]
    style_id = Entry.find(entries.id).style.id
    assert_equal style.id, style_id, "Style.id and entries.style_id should be the same"
  end

  def test_save_update_style_id
    style1 = Style.find_or_create_by(name: "APA")
    style2 = Style.find_or_create_by(name: "Lager")
    entries = Entry.create(name: "Foo", ounces: 20, cost: 5.50, style: style1)
    entries.style = style2
    entries.save
    # style_id = database.execute("select style_id from entries where id='#{entries.id}'")[0][0]
    style_id = Entry.find(entries.id).style.id
    assert_equal style2.id, style_id, "Style2.id and entries.style_id should be the same"
  end



  def test_find_returns_the_row_as_purchase_object
    style = Style.find_or_create_by(name: "Things")
    entries = Entry.create(name: "Foo", ounces: "20", cost: "2.50", style: style)
    found = Entry.find(entries.id)
    assert_equal entries.name, found.name
    assert_equal entries.id, found.id
    assert_equal entries.ounces, found.ounces
    assert_equal entries.cost, found.cost
  end
  def test_find_returns_the_entries_with_correct_style
    style = Style.find_or_create_by(name: "Things")
    entries = Entry.create(name: "Foo", ounces: "20", cost: "2.50", style: style)
    found = Entry.find(entries.id)
    refute_equal Style.default.id, found.style.id
    assert_equal style.id, found.style.id
  end


  def test_search_returns_entries_objects
    Entry.create(name: "Foo", ounces: "12", cost: "5.50")
    Entry.create(name: "Guinness", ounces: "12", cost: "5.50")
    Entry.create(name: "Guinness Draught", ounces: "12", cost: "5.50")
    results = Entry.search("Guinness")
    assert results.all?{ |result| result.is_a? Entry }, "Not all results were Entry"
  end


  def test_search_returns_appropriate_results
    entry1 = Entry.create(name: "Foo", ounces: "12", cost: "5.50")
    entry2 = Entry.create(name: "Guinness", ounces: "12", cost: "5.50")
    entry3 = Entry.create(name: "Guinness Draught", ounces: "12", cost: "5.50")
    expected = [entry2, entry3]
    actual = Entry.search("Guinness")
    assert_equal expected, actual
  end

  def test_search_returns_empty_array_if_no_results
    Entry.create(name: "Foo", ounces: "12", cost: "5.50")
    Entry.create(name: "Guinness", ounces: "12", cost: "5.50")
    Entry.create(name: "Guinness Draught", ounces: "12", cost: "5.50")
    results = Entry.search("Soda")
    assert_equal [], results
  end

  def test_all_returns_all_entries_in_alphabetical_order
    Entry.create(name: "foo", ounces: "12", cost: "5.50")
    Entry.create(name: "bar", ounces: "12", cost: "5.50")
    results = Entry.all
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
    results = Entry.all
    assert_equal [], results
  end

 def test_equality_on_same_object
    entries = Entry.create(name: "foo", ounces: "12", cost: "5.50")

    assert entries == entries
  end

  def test_equality_with_different_class
    entries = Entry.create(name: "foo", ounces: "12", cost: "5.50")
    refute entries == "Entry"
  end

  def test_equality_with_different_entries
    entries1 = Entry.create(name: "foo", ounces: "12", cost: "5.50")
    entries2 = Entry.create(name: "bar", ounces: "12", cost: "5.50")
    refute entries1 == entries2
  end

  def test_equality_with_same_entries_different_object_id
    entries1 = Entry.create(name: "foo", ounces: "12", cost: "5.50")
    entries2 = Entry.find(entries1.id)
    assert entries1 == entries2
  end
end