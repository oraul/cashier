# Cashier

```ruby
products = ProductRepository.all
pricing_rules = PricingRuleUseCase.apply(products:)

checkout = Checkout.new(pricing_rules)
checkout.scan('GR1')
checkout.scan('SR1')
checkout.scan('CF1')
checkout.total
```
