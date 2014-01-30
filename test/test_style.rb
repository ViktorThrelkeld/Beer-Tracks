require_relative 'helper'
require_relative '../models/style'

class TestStyle < BeerTest
  def test_style_are_created_if_needed
    foos_before = database.execute("select count(id) from style")[0][0]
    Style.find_or_create("Foo")
    foos_after = database.execute("select count(id) from style")[0][0]
    assert_equal foos_before + 1, foos_after
  end

  def test_styles_are_not_created_if_they_already_exist
    Style.find_or_create("Foo")
    foos_before = database.execute("select count(id) from style")[0][0]
    Style.find_or_create("Foo")
    foos_after = database.execute("select count(id) from style")[0][0]
    assert_equal foos_before, foos_after
  end

  def test_existing_is_returned_by_find_or_create
    style1 = Style.find_or_create("Foo")
    style2 = Style.find_or_create("Foo")
    assert_equal style1.id, style2.id, "Style ids should be identical"
  end

  def test_create_creates_an_id
    style = Style.find_or_create("Foo")
    refute_nil style.id, "Style id shouldn't be nil"
  end

  def test_all_returns_all_style_in_alphabetical_order
    Style.find_or_create("foo")
    Style.find_or_create("bar")
    expected = ["bar", "foo"]
    actual = Style.all.map{ |style| style.name }
    assert_equal expected, actual
  end

  def test_all_returns_empty_array_if_no_style
    results = Style.all
    assert_equal [], results
  end
end