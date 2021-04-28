# Ruby Interview Checkout

set Ruby version 2.4.0 or higher to be able to use Enumerable#sum

```
rvm use ruby-2.4.0
```

#### example promotion structure:

```
promos = [
  {min_sum: 60, min_count: 0, product_code: nil, promo_price: nil, discount: 10},
  {min_sum: 0, min_count: 2, product_code: 001, discount_price: 8.50, discount: nil},
]

```

#### products are hardcoded in checkout.rb:

```
PRODUCT_LIST = [
  {code: 001, name: 'Red Scarf', price: 9.25},
  {code: 002, name: 'Silver cufflinks', price: 45.00},
  {code: 003, name: 'Silk Dress', price: 19.95},
]
```

#### How to run:
- irb
```
require './checkout.rb'
promos = [
    {min_sum: 60, min_count: 0, product_code: nil, promo_price: nil, discount: 10},
    {min_sum: 0, min_count: 2, product_code: 001, discount_price: 8.50, discount: nil},
  ]
checkout = Checkout.new(promos)
checkout.scan(001)
checkout.scan(002)
checkout.scan(003)
checkout.total
```

#### How to run tests

- ruby checkout_test.rb
