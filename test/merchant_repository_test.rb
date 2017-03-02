require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository'


class MerchantRepositoryTest < Minitest::Test

  def test_pull_csv
    mr = MerchantRepository.new("./test/fixtures/merchant_fixture.csv")

    assert_instance_of CSV, mr.pull_csv
  end

  def test_parse_csv
    mr = MerchantRepository.new("./test/fixtures/merchant_fixture.csv")
    assert_instance_of Merchant, mr.merchants_array[0]
  end

  def test_find_by_id
    mr = MerchantRepository.new("./test/fixtures/merchant_fixture.csv")
    assert_equal 'FlavienCouche', mr.find_by_id(12334195).name
    refute_equal 'FlavienCouche', mr.find_by_id(12334141).name
    assert_nil   mr.find_by_id(100)
  end

  def test_find_by_name
    mr = MerchantRepository.new("./test/fixtures/merchant_fixture.csv")
    assert_equal 12334105, mr.find_by_name('Shopin1901').id
    assert_equal 12334105, mr.find_by_name('SHOPIN1901').id
  end

  def test_find_all_by_name
    mr = MerchantRepository.new("./test/fixtures/merchant_fixture.csv")
    assert_equal 1, mr.find_all_by_name('co').count
    assert_equal "FlavienCouche", mr.find_all_by_name('co')[0].name
    assert_equal [], mr.find_all_by_name('efbwrhjbfr')
  end
end
