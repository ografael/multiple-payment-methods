# Problem
We need to support multiple payment methods to receive from our customers.

At the moment, the system supports payments using bank slip and credit card. In the future, new forms like deposit may emerge.

Each customer can choose how they want to make the payment.

This choice must be recorded in the system and taken into account every time a bill is generated for the customer.

# Solution
The solution used to implement the various payment methods was based on the Strategy pattern.

Strategy is a behavioral design pattern that allows you to define a family of algorithms,
put them in separate classes, and make their objects interchangeable.


Architecture organized in the folder:
```
/app/services/payments
```

Example of use:
```ruby
   Payments::Context.new('bank_slip').pay(invoice)
   Payments::Context.new('credit_card').pay(invoice)
```

# How to add a new payment type?

Currently the system supports 2 payment methods bank_slip and credit_card.

```
/app/services/payments/types/bank_slip.rb
/app/services/payments/types/credit_card.rb
```

To add deposit as a new payment method, create a new file at the destination:
```
/app/services/payments/types/deposit.rb
```

```ruby
module Payments
  module Types
    class Deposit < Payments::Type
      def pay(invoice)
        invoice.update(status: 'deposit paid')
      end
    end
  end
end
```

This is it. The rest of the system must identify this new payment method.

The type_spec.rb test file checks the system's payment methods.

Update the type_spec.rb test with the new payment method:

```
spec/services/payments/type_spec.rb
```

```ruby
  let(:payment_types) do
      ['bank_slip', 'credit_card', 'deposit']
  end
```

# Configuration

```
ruby --version
ruby 3.1.2p20

rails --version
Rails 7.0.7
```

# How to execute the project?
```
rails db:create db:migrate db:seed
```

```
rails s
```

Access localhost:3000.


# How to run the tests?

```
bundle exec rspec
```

# Some gems added during development
- faker - It's a library for generating fake data such as names, addresses, and phone numbers.
- money-rails - This library provides integration of the money gem with Rails.
- shoulda-matchers - Shoulda Matchers provides RSpec- and Minitest-compatible one-liners to test common Rails functionality that, if written by hand, would be much longer, more complex, and error-prone.
- kaminari - A Scope & Engine based, clean, powerful, customizable and sophisticated paginator for modern web app frameworks and ORMs.
- rubocop - RuboCop is a Ruby static code analyzer (a.k.a. linter) and code formatter.
- guard - Guard automates various tasks by running custom rules whenever file or directories are modified.
- bullet - Help to kill N+1 queries and unused eager loading

# This is just an example application

Although this is apparently a real problem with a billing system, it was written for testing purposes only.
