require_relative 'helper'


class TestStyle < BeerTest
  def test_default_creates_correctly_named_file
    style = Style.default
    assert_equal "Unknown", style.name
    refute style.new_record?
  end

  def test_default_creates_default_category
    assert_equal 0, Style.count
    Style.default
    assert_equal 1, Style.count
  end

  def test_default_doesnt_create_duplicate_default
    style = Style.find_or_create_by(name: "Unknown")
    assert_equal style.id, Style.default.id
    assert_equal 1, Style.count
  end

  def test_count_when_no_style
    assert_equal 0, Style.count
  end

  def test_count_of_multiple_styles
    Style.find_or_create_by(name: "foo")
    Style.find_or_create_by(name: "Stout")
    Style.find_or_create_by(name: "Pilsner")
    assert_equal 3, Style.count
  end

  def test_style_are_created_if_needed
    foos_before = Style.count
    Style.find_or_create_by(name: "Foo")
    foos_after = Style.count
    assert_equal foos_before + 1, foos_after
  end

  def test_styles_are_not_created_if_they_already_exist
    Style.find_or_create_by(name: "Foo")
    foos_before = Style.count
    Style.find_or_create_by(name: "Foo")
    foos_after = Style.count
    assert_equal foos_before, foos_after
  end

  def test_existing_style_is_returned_by_find_or_create_by_name
    style1 = Style.find_or_create_by(name: "Foo")
    style2 = Style.find_or_create_by(name: "Foo")
    assert_equal style1.id, style2.id, "Style ids should be identical"
  end

  def test_create_creates_an_id
    style = Style.find_or_create_by(name: "Foo")
    refute_nil style.id, "Style id shouldn't be nil"
  end

  def test_all_returns_all_style_in_alphabetical_order
    Style.find_or_create_by(name: "foo")
    Style.find_or_create_by(name: "bar")
    expected = ["bar", "foo"]
    actual = Style.all.map{ |style| style.name }
    assert_equal expected, actual
  end

  def test_all_returns_empty_array_if_no_style
    results = Style.all
    assert_equal [], results
  end
end