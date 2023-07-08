# Cashier

## Stack

- Docker
- Docker Compose
- Ruby 3.2.2
- RSpec
- FactoryBot
- SimpleCov
- Github Actions

## Execution

When you execute the command bellow, it will runs bin/console

```
docker-compose run --rm app
```

Tests

```
docker-compose run --rm app bundle exec rspec spec
```

## Explanation

Products:

If you need to modify products:

```
fixtures/products.json
```

Interface:

```ruby
pricing_rules = PricingRuleUseCase.call

checkout = Checkout.new(pricing_rules)
checkout.scan('GR1')
checkout.scan('SR1')
checkout.scan('CF1')
checkout.total
```
