require_relative 'helper'


class TestEnteringData < BeerTest
  def test_user_is_presented_with_style_list
    style1 = Style.find_or_create(name: "Foo")
    style2 = Style.find_or_create(name: "Bar")
    style3 = Style.find_or_create(name: "IPA")
    shell_output = ""
    IO.popen('./beertracks add Accumulation --ounces 12 --cost 4.50 --environment test', 'r+') do |pipe|
      pipe.puts "3"
      shell_output = pipe.read
    end
    assert_includes_in_order shell_output,
    "Choose a style:",
    "1. Bar",
    "2. Foo",
    "3. IPA"
  end

  def test_user_chooses_category
    style1 = Style.find_or_create(name: "Foo")
    style2 = Style.find_or_create(name: "Bar")
    style3 = Style.find_or_create(name: "IPA")
    shell_output = ""
    IO.popen('./beertracks add Accumulation --ounces 12 --cost 4.50 --environment test', 'r+') do |pipe|
      pipe.puts "3"
      shell_output = pipe.read
    end
    expected = "Congratulations! You drank 12 oz of Accumulation (IPA), costing you $4.50."
  end

  def test_user_skips_entering_style
    style3 = Style.find_or_create(name: "IPA")
    shell_output = ""
    IO.popen('./beertracks add Accumulation --ounces 12 --cost 4.50 --environment test', 'r+') do |pipe|
      pipe.puts ""
      shell_output = pipe.read
    end
    expected = "Congratulations! You drank 12 oz of Accumulation (Unknown), costing you $4.50."
    assert_in_output shell_output, expected
  end

  def test_valid_drinking_information_gets_printed
    skip #righteous beer art. need to do a assert includes
    command = "./beertracks add 'Yazoo Pale' --ounces 40 --cost 10"
    expected = "Congratulations! You drank 40 oz of Yazoo Pale (Unknown), costing you $10.00."
    assert_command_output expected, command


  end

  def test_valid_drinking_information_gets_saved
    execute_popen("./beertracks add 'Yazoo Pale' --ounces 40 --cost 10 --environment test")
    database.results_as_hash = false
    results = database.execute("select name, ounces, cost from entries")
    expected = ["Yazoo Pale", 40, 10]
    assert_equal expected, results[0]

    result = database.execute("select count(id) from entries")
    assert_equal 1, result[0][0]
  end

  def test_invalid_drinking_information_doesnt_get_saved
    execute_popen("./beertracks add Guiness")
    result = database.execute("select count(id) from entries")
    assert_equal 0, result[0][0]
  end

  def test_error_message_for_missing_cost
    command = "./beertracks add 'Yazoo Pale' --ounces 12"
    expected = "You must provide the cost of the beer you drank."
    assert_command_output expected, command
  end

  def test_error_message_for_missing_oz_and_cost
    command = "./beertracks add YazooPale"
    expected = "You must provide the cost and total ounces of the beer you drank."
    assert_command_output expected, command
  end

  def test_error_message_for_missing_oz
    command = "./beertracks add YazooPale --cost 5"
    expected = "You must provide the total ounces of the beer you drank."
    assert_command_output expected, command
  end

  def test_error_message_for_missing_beer_name
    command = "./beertracks add"
    expected = "You must provide the name of the beer you drank. You must provide the cost and total ounces of the beer you drank."
    assert_command_output expected, command
  end
end
