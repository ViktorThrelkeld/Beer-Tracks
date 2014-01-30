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
    skip
    import_data
    expected = ["Guinness Draught, 20, 5.00, stout",
    "Bush, 25, 5.00, pilsner",
    "Heineken, 12, 5.00, pilsner",
    "Anchor Steam, 12, 5.00, porter"]
    actual = Entries.all.map do |beer|
      "#{beer.name}, #{beer.ounces}, #{beer.cost}, #{beer.category.name}"
    end
    assert_equal expected, actual
  end

  def test_extra_categories_arent_created
    skip
    import_data
    assert_equal 4, Category.all.count
  end

  def test_categories_are_created_as_needed
    skip
    Category.create(name: "stout")
    Category.create(name: "Pets")
    import_data
    assert_equal 4, Category.all.count, "The categories were: #{Category.all.map(&:name)}"
  end

  def test_data_isnt_duplicated
    skip
    import_data
    expected = ["stout", "pilsner", "porter", "IPA"]
    assert_equal expected, Category.all.map(&:name)
  end
end