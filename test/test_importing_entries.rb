require_relative 'helper'
require_relative '../lib/importer'

class TestImportingEntries < BeerTest
  def import_data
    Importer.import("data/sample_entries_data.csv")
  end

  def test_the_correct_number_of_entries_are_imported
    import_data
    assert_equal 4, Entry.all.count
  end

  def test_entries_are_imported_fully
    import_data
    expected = [
    "Anchor Steam, 12, 4.5, Porter",
    "Bush, 25, 2.7, Pilsner",
    "Guinness, 20, 10.0, Stout",
    "Yazoo Pale Ale, 16, 5.5, IPA"
    ]
    actual = Entry.all.map do |beer|
      "#{beer.name}, #{beer.ounces}, #{beer.cost}, #{beer.style.name}"
    end
    assert_equal expected, actual
  end

  def test_extra_categories_arent_created

    import_data
    assert_equal 4, Style.all.count
  end

  def test_categories_are_created_as_needed

    Style.find_or_create_by(name: "Stout")
    Style.find_or_create_by(name: "Pets")
    import_data
    assert_equal 5, Style.all.count, "The categories were: #{Style.all.map(&:name)}"
  end

  def test_data_isnt_duplicated

    import_data
    expected = ["Stout", "Pilsner", "Porter", "IPA"].sort
    assert_equal expected, Style.all.map(&:name)
  end
end