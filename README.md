# Problem
We need to support multiple payment methods to receive from our customers.

They can pay by bank slip, by credit card, by deposit and tomorrow new forms like Pix may emerge.

Each customer can choose how they want to make payment. This choice must be recorded in the system and taken into account every time a bill is generated for the customer.

Billing must be carried out once a month on the due date chosen by the customer and using the payment method chosen by the customer.


# Solution used
The solution used to implement the various payment methods was based on the Strategy standard.

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

To add pix as a new payment method, create a new file at the destination:
```
/app/services/payments/types/pix.rb
```

```ruby
module Payments
  module Types
    class Pix < Payments::Type
      def pay(invoice)
        invoice.update(status: 'Pix pago')
      end
    end
  end
end
```

This is it. The rest of the system must identify this new payment method.

The type_spec.rb test file checks the system's payment methods.

Update the type_spec.rb test with the new pix payment method:

```
spec/services/payments/type_spec.rb
```

```ruby
  let(:payment_types) do
      ['bank_slip', 'credit_card', 'pix']
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


# This is just an example application

Although this is apparently a real problem with a billing system, it was written for testing purposes only.
