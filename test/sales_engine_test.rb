require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  attr_reader :se
  def setup
    @se = SalesEngine.from_csv({
      :items => "./test/fixtures/item_fixture.csv",
      :merchants => "./test/fixtures/merchant_fixture.csv",
      :invoices => "./test/fixtures/invoice_fixture.csv",
      :invoice_items => "./test/fixtures/invoice_item_fixture.csv",
      :transactions => "./test/fixtures/transaction_fixture.csv",
      :customers => "./test/fixtures/customer_fixture.csv",
      })
  end

  def test_child_instances_created
    assert_instance_of ItemRepository, se.items
    assert_instance_of MerchantRepository, se.merchants
    assert_instance_of InvoiceRepository, se.invoices
  end

  def test_merchant_items
    merchant = se.merchants.find_by_id(12334123)
    assert_equal 25, merchant.items.count
    assert_equal "Adidas Breitner Super Fußballschuh", merchant.items.first.name
  end

  def test_item_merchant
    item = se.items.find_by_id(263500126)
    assert_equal "FlavienCouche", item.merchant.name
  end

  def test_find_merchant_invoices
    merchant = se.merchants.find_by_id(12334141)
    assert_equal 18, merchant.invoices.count
    assert_equal 641, merchant.invoices.first.id
  end

  def test_find_invoice_merchant
    invoice = se.invoices.find_by_id(819)
    assert_equal 'jejum', invoice.merchant.name
  end

  def test_invoice_invoice_items
    invoice = se.invoices.find_by_id(641)
    assert_equal 2, invoice.invoice_items.count
    assert_instance_of InvoiceItem, invoice.invoice_items[0]
  end

  def test_invoice_items
    invoice = se.invoices.find_by_id(1012)
    assert_equal 2, invoice.items.count
    assert_instance_of Item, invoice.items[0]
  end

  def test_invoice_transactions
    invoice = se.invoices.find_by_id(4966)
    assert_equal 3, invoice.transactions.count
    assert_instance_of Transaction, invoice.transactions[0]
  end

  def test_invoice_customer
    invoice = se.invoices.find_by_id(4966)
    assert_equal 996, invoice.customer.id
    assert_instance_of Customer, invoice.customer
  end

  def test_transactions_invoice
    transaction = se.transactions.find_by_id(1175)
    assert_equal 3983, transaction.invoice.id
    assert_instance_of Invoice, transaction.invoice
  end

  def test_merchant_customers
    merchant = se.merchants.find_by_id(12334123)
    assert_equal 10, merchant.customers.length
    assert_equal 34, merchant.customers.first.id
  end

  def test_is_paid_in_full?
    invoice = se.invoices.find_by_id(4966)
    assert invoice.is_paid_in_full?
  end

  def test_invoice_total
    invoice = se.invoices.find_by_id(1058)
    assert_equal 4403.94, invoice.total
  end

end
