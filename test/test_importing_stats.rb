require_relative 'helper'
require_relative '../lib/importer'

class TestImportingStats < BeerTest
  def import_data
    Importer.import("test/sample_stats_data.csv")
  end

  def test_the_correct_number_of_stats_are_imported
    skip
    import_data
    assert 4, Stats.all.count
  end

  def test_stats_are_imported_fully
    skip
    import_data
    expected = ["5, 12.5, stout",
    "4.5, 11.25, pilsner",
    "6, 15, porter",
    "7, 17.5, IPA"]
    actual = Stats.all.map do |stat|
      "#{stat.abv}, #{stat.calories}, #{stat.category.name}"
    end
    assert_equal expected, actual
  end

  def test_extra_categories_arent_created
    skip
    import_data
    assert 4, Category.all.count
  end

  def test_categories_are_created_as_needed
    skip
    Category.create("stout")
    Category.create("Pets")
    import_data
    assert 4, Category.all.count
  end

  def test_data_isnt_duplicated
    skip
    import_data
    expected = ["stout", "pilsner", "porter", "IPA"]
    assert_equal expected, Category.all.map(&:name)
  end
end