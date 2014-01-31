require_relative 'helper'
require_relative '../lib/importer'

class TestImportingEntries < BeerTest
  def import_data
    Importer.import("data/sample_entries_data.csv")
  end

  def test_the_correct_number_of_entries_are_imported
    import_data
    assert_equal 4, Entries.all.count
  end

  def test_entries_are_imported_fully
    import_data
    expected = [
    "Anchor Steam, 12, 4.50, porter",
    "Bush, 25, 2.70, pilsner",
    "Guinness, 20, 10.00, stout",
    "Yazoo Pale Ale, 16, 5.50, IPA"
    ]
    actual = Entries.all.map do |beer|
      "#{beer.name}, #{beer.ounces}, #{beer.cost}, #{beer.style.name}"
    end
    assert_equal expected, actual
  end

  def test_extra_categories_arent_created
    skip
    import_data
    assert_equal 4, Style.all.count
  end

  def test_categories_are_created_as_needed
    skip
    Style.find_or_create(name: "stout")
    Style.find_or_create(name: "Pets")
    import_data
    assert_equal 4, Style.all.count, "The categories were: #{Style.all.map(&:name)}"
  end

  def test_data_isnt_duplicated
    skip
    import_data
    expected = ["stout", "pilsner", "porter", "IPA"]
    assert_equal expected, Style.all.map(&:name)
  end
end