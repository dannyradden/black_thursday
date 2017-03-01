require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer_repository'


class CustomerRepositoryTest < Minitest::Test
  attr_reader :cr

  def setup
    @cr = CustomerRepository.new('test/fixtures/customer_fixture.csv')
  end

  def test_pull_csv
    assert_instance_of CSV, cr.pull_csv
  end

  def test_all
    assert_equal 62, cr.all.count
  end

  def test_find_by_id
    assert_equal 14, cr.find_by_id(14).id
    assert_nil cr.find_by_id(101)
  end

  def test_find_all_by_first_name
    assert_equal 1, cr.find_all_by_first_name("Broo").count
    assert_equal 2, cr.find_all_by_first_name("san").count
    assert_equal 125, cr.find_all_by_first_name("San")[0].id
  end

  def test_find_all_by_last_name
    assert_equal 1, cr.find_all_by_last_name("man").count
    assert_equal 1, cr.find_all_by_last_name("von").count
    assert_equal 370, cr.find_all_by_last_name("von")[0].id
  end
end
