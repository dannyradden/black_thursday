require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  attr_reader :sa, :se
  def setup
    @se = SalesEngine.from_csv({
      :items => "./test/fixtures/item_fixture.csv",
      :merchants => "./test/fixtures/merchant_fixture.csv",
      :invoices => "./test/fixtures/invoice_fixture.csv",
      :invoice_items => "./test/fixtures/invoice_item_fixture.csv",
      :transactions => "./test/fixtures/transaction_fixture.csv",
      :customers => "./test/fixtures/customer_fixture.csv"
      })
    @sa = SalesAnalyst.new(se)
  end

  # def setup
  #   @se = SalesEngine.from_csv({
  #     :items => "./data/items.csv",
  #     :merchants => "./data/merchants.csv",
  #     :invoices => "./data/invoices.csv",
  #     :invoice_items => "./data/invoice_items.csv",
  #     :transactions => "./data/transactions.csv",
  #     :customers => "./data/customers.csv"
  #     })
  #   @sa = SalesAnalyst.new(se)
  # end
  #
  def test_average_items_per_merchant
    assert_equal 57.8, sa.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    assert_equal 54.68, sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    assert_equal 0, sa.merchants_with_high_item_count.count
  end

  def test_average_item_price_for_merchant
    assert_equal (BigDecimal.new(15000)/100), sa.average_item_price_for_merchant(12334113)
  end

  def test_average_average_price_per_merchant
    assert_equal (BigDecimal.new(15240)/100), sa.average_average_price_per_merchant
  end

  def test_average_item_price
    assert_equal (BigDecimal.new(58851)/100), sa.average_item_price
  end

  def test_average_item_price_standard_deviation
    assert_equal 6068.19, sa.average_item_price_standard_deviation
  end

  def test_golden_items
    assert_equal 2, sa.golden_items.length
    assert_instance_of Item, sa.golden_items.first
  end

  def test_average_invoices_per_merchant
    assert_equal 12.8, sa.average_invoices_per_merchant
  end

  def test_average_invoices_per_merchant_standard_deviation
    assert_equal 3.35, sa.average_invoices_per_merchant_standard_deviation
  end

  def test_top_merchants_by_invoice_count
    assert_equal 0, sa.top_merchants_by_invoice_count.count
  end

  def test_bottom_merchants_by_invoice_count
    assert_equal 0, sa.bottom_merchants_by_invoice_count.count
  end

  def test_top_days_by_invoice_count
    assert_equal ['Friday'], sa.top_days_by_invoice_count
  end

  def test_invoice_status
    assert_equal 39.06, sa.invoice_status(:pending)
    assert_equal 46.88, sa.invoice_status(:shipped)
    assert_equal 14.06, sa.invoice_status(:returned)
  end

  def test_total_revenue_by_date
    date = Time.parse("2000-06-19")
    assert_equal 18698.58, sa.total_revenue_by_date(date)
  end

  def test_top_revenue_earners
    assert_equal 3, sa.top_revenue_earners(3).count
  end

  def test_merchants_with_pending_invoices
    assert_equal 5, sa.merchants_with_pending_invoices.count
    assert_instance_of Merchant, sa.merchants_with_pending_invoices[0]
  end

  def test_merchants_with_only_one_item
    assert_equal 2, sa.merchants_with_only_one_item.count
    assert_instance_of Merchant, sa.merchants_with_only_one_item[0]
  end

  def test_merchants_with_only_one_item_registered_in_month
    assert_equal 1, sa.merchants_with_only_one_item_registered_in_month('June').count
  end

  def test_revenue_by_merchant
    assert_equal 64725.4, sa.revenue_by_merchant(12334123)
  end

  def test_most_sold_item_for_merchant
    assert_equal 2, sa.most_sold_item_for_merchant(12334123).count
    assert_instance_of Item , sa.most_sold_item_for_merchant(12334123)[1]
  end

  def test_best_item_for_merchant
    assert_equal 263553486, sa.best_item_for_merchant(12334141).id
  end

end
