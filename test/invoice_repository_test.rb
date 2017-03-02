require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_repository'


class InvoiceRepositoryTest < Minitest::Test

  def test_pull_csv
    ir = InvoiceRepository.new('./test/fixtures/invoice_fixture.csv')

    assert_instance_of CSV, ir.pull_csv
  end

  def test_parse_csv
    ir = InvoiceRepository.new('./test/fixtures/invoice_fixture.csv')

    assert_instance_of Invoice, ir.invoices_array[0]
  end

  def test_all
    ir = InvoiceRepository.new('./test/fixtures/invoice_fixture.csv')
    assert_equal 64, ir.all.count
  end

  def test_find_by_id
    ir = InvoiceRepository.new('./test/fixtures/invoice_fixture.csv')
    assert_equal 74, ir.find_by_id(74).id
    assert_nil   ir.find_by_id(75)
  end

  def test_find_all_by_customer_id
    ir = InvoiceRepository.new('./test/fixtures/invoice_fixture.csv')
    assert_equal 2, ir.find_all_by_customer_id(704).count
    assert_equal 3556, ir.find_all_by_customer_id(704)[0].id
    assert_equal [], ir.find_all_by_customer_id(2)
  end

  def test_find_all_by_merchant_id
    ir = InvoiceRepository.new('./test/fixtures/invoice_fixture.csv')
    assert_equal 10, ir.find_all_by_merchant_id(12334105).count
    assert_equal 74, ir.find_all_by_merchant_id(12334105)[0].id
    assert_equal [], ir.find_all_by_merchant_id(2)
  end

  def test_find_all_by_status
    ir = InvoiceRepository.new('./test/fixtures/invoice_fixture.csv')
    assert_equal 30, ir.find_all_by_status(:shipped).count
    assert_equal 548, ir.find_all_by_status(:shipped)[0].id
    assert_equal [], ir.find_all_by_status(:'not a status')
  end
end
