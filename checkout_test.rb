require './checkout.rb'
require 'test/unit'

class CheckoutTest < Test::Unit::TestCase
  PROMOS = [
    {min_sum: 60, min_count: 0, product_code: nil, promo_price: nil, discount: 10},
    {min_sum: 0, min_count: 2, product_code: 001, discount_price: 8.50, discount: nil},
  ].freeze

  def test_with_products1
    checkout = Checkout.new(PROMOS)

    checkout.scan(001)
    checkout.scan(002)
    checkout.scan(003)

    assert_equal(66.78, checkout.total)
  end

  def test_with_products2
    checkout = Checkout.new(PROMOS)

    checkout.scan(001)
    checkout.scan(003)
    checkout.scan(001)

    assert_equal(36.95, checkout.total)
  end

  def test_with_products3
    checkout = Checkout.new(PROMOS)

    checkout.scan(001)
    checkout.scan(002)
    checkout.scan(001)
    checkout.scan(003)

    assert_equal(73.76, checkout.total)
  end

  def test_with_empty_basket
    checkout = Checkout.new(PROMOS)

    expectation = 'You dont have any products in your basket'

    assert_equal(expectation, checkout.total)
  end

  def test_with_not_found_product_code
    checkout = Checkout.new(PROMOS)

    expectation = 'Product with provided code not found'

    assert_equal(expectation, checkout.scan(004))
  end
end
