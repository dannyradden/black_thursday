require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  attr_reader :sa, :se
  def setup
    @se = SalesEngine.from_csv({
      :items     => "./test/fixtures/item_fixture.csv",
      :merchants => "./test/fixtures/merchant_fixture.csv"
    })
    @sa = SalesAnalyst.new(se)
  end

  def test_average_items_per_merchant
    assert_equal 1.88, sa.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    assert_equal 1.88, sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    assert_equal 4, sa.merchants_with_high_item_count.length
    assert_instance_of Merchant, sa.merchants_with_high_item_count.first
  end

  def test_average_item_price_for_merchant
    assert_equal (BigDecimal.new(5050)/100), sa.average_item_price_for_merchant(12334365)
  end

  def test_average_average_price_per_merchant
    assert_equal (BigDecimal.new(15525)/100), sa.average_average_price_per_merchant
  end

  def test_average_item_price
    assert_equal (BigDecimal.new(16686)/100), sa.average_item_price
  end

  def test_average_item_price_standard_deviation
    assert_equal 376.88, sa.average_item_price_standard_deviation
  end

  def test_golden_items
    assert_equal 1, sa.golden_items.length
    assert_instance_of Item, sa.golden_items.first
  end
end
