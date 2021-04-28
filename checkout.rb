# frozen_string_literal: true
# rvm use ruby-2.4.0 or higher to be able to use Enumerable#sum

class Checkout
  attr_accessor :promo_rules, :products

  promos = [
    {min_sum: 60, min_count: 0, product_code: nil, discount_price: nil, discount: 10},
    {min_sum: 0, min_count: 2, product_code: 001, discount_price: 8.50, discount: nil},
  ]

  PRODUCT_LIST = [
    {code: 001, name: 'Red Scarf', price: 9.25},
    {code: 002, name: 'Silver cufflinks', price: 45.00},
    {code: 003, name: 'Silk Dress', price: 19.95},
  ].freeze

  def initialize(promo_rules)
    @promo_rules = promo_rules.uniq
    @products = []
  end

  def scan(product_code)
    product = PRODUCT_LIST.detect do |prod|
      prod.dig(:code) == product_code
    end
    if product
      products << product
    else
      'Product with provided code not found'
    end
  end

  def total
    if products.empty?
      'You dont have any products in your basket'
    else
      total = calculate_total.round(2)
      puts "Total price: #{total}"
      total
    end
  end

  private

  def calculate_total
    apply_promo_rules_for_product
    apply_promo_rules_for_basket
  end

  def apply_promo_rules_for_product
    promo_rules.map do |promo|
      promo_products = products.select do |product|
        product.dig(:code) == promo.dig(:product_code)
      end

      next if promo.dig(:min_count) > promo_products.count

      promo_products.map do |product|
        product[:price] = promo.dig(:discount_price)
      end
    end
  end

  def apply_promo_rules_for_basket
    sum = calculate_basket

    promo_rules_for_basket.map do |promo|
      next if promo.dig(:min_sum) > sum

      sum -= calculate_precent(sum, promo.dig(:discount))
    end

    sum
  end

  def calculate_precent(amount, discount)
    amount * discount / 100.0
  end

  def calculate_basket
    products.sum { |product| product.dig(:price) }
  end

  def promo_rules_for_basket
    promo_rules.select do |promo|
      promo.dig(:min_sum).positive?
    end
  end
end
