require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item_repository'


class ItemRepositoryTest < Minitest::Test

  def test_pull_csv
    ir = ItemRepository.new('./test/fixtures/item_fixture.csv')

    assert_instance_of CSV, ir.pull_csv
  end

  def test_parse_csv
    ir = ItemRepository.new('./test/fixtures/item_fixture.csv')
    assert_instance_of Item, ir.items_array[0]
  end

  def test_all
    ir = ItemRepository.new('./test/fixtures/item_fixture.csv')
    assert_equal 247, ir.all.count
  end

  def test_find_by_id
    ir = ItemRepository.new('./test/fixtures/item_fixture.csv')
    assert_equal 'Matrice monolithique', ir.find_by_id(263399263).name
    assert_nil   ir.find_by_id(100)
  end

  def test_find_by_name
    ir = ItemRepository.new('./test/fixtures/item_fixture.csv')
    assert_equal 263406625, ir.find_by_name('Poppies red flowers').id
    assert_equal 263406625, ir.find_by_name('POPPIES RED FLOWERS').id
  end

  def test_find_all_with_description
    ir = ItemRepository.new('./test/fixtures/item_fixture.csv')
    assert_equal 8, ir.find_all_with_description('by hand').count
    assert_equal "Oak Bowl", ir.find_all_with_description('by hand')[0].name
    assert_equal [], ir.find_all_with_description('fewfbhj32bh')
  end

  def test_find_all_by_price
    ir = ItemRepository.new('./test/fixtures/item_fixture.csv')
    assert_equal 9, ir.find_all_by_price(10.00).count
    assert_equal 10, ir.find_all_by_price(10.00)[0].unit_price
    assert_equal [], ir.find_all_by_price(123.45)
  end

  def test_find_all_by_price_in_range
    ir = ItemRepository.new('./test/fixtures/item_fixture.csv')
    assert_equal 212, ir.find_all_by_price_in_range(1.00..200.00).count
    assert_equal 12, ir.find_all_by_price_in_range(10.00..20.00)[0].unit_price
    assert_equal [], ir.find_all_by_price_in_range(1.01..1.50)
  end

  def test_find_all_by_merchant
    ir = ItemRepository.new('./test/fixtures/item_fixture.csv')
    assert_equal 5, ir.find_all_by_merchant_id(12334195).count
    assert_equal "Course contre la montre", ir.find_all_by_merchant_id(12334195)[0].name
    assert_equal [], ir.find_all_by_merchant_id(100)
  end

end
