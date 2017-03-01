require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test
attr_reader :tr

  def setup
    @tr = TransactionRepository.new('./test/fixtures/transaction_fixture.csv')
  end

  def test_pull_csv
    assert_instance_of CSV, tr.pull_csv
  end

  def test_all
    assert_equal 64, tr.all.count
  end

  def test_find_by_id
    assert_equal 324, tr.find_by_id(324).id
    assert_nil   tr.find_by_id(300)
  end

  def test_find_all_by_invoice_id
    assert_equal 2, tr.find_all_by_invoice_id(2551).count
    assert_equal 1139, tr.find_all_by_invoice_id(2551)[0].id
    assert_equal [], tr.find_all_by_invoice_id(3)
  end

  def test_find_all_by_credit_card_number
    assert_equal 1, tr.find_all_by_credit_card_number(4618376415482255).count
    assert_equal 1756, tr.find_all_by_credit_card_number(4618376415482255)[0].id
    assert_equal [], tr.find_all_by_credit_card_number(1111111111111111)
  end

  def test_find_all_by_result
    assert_equal 7, tr.find_all_by_result('failed').count
    assert_equal 14, tr.find_all_by_result('failed')[0].id
    assert_equal [], tr.find_all_by_result('not a result')
  end
end
