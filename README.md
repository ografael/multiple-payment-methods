# Problem
We need to support multiple payment methods to receive from our customers.

They can pay by bank slip, by credit card, by deposit and tomorrow new forms like Pix may emerge.

Each customer can choose how they want to make payment. This choice must be recorded in the system and taken into account every time a bill is generated for the customer.

Billing must be carried out once a month on the due date chosen by the customer and using the payment method chosen by the customer.


# Solution used
The solution used to implement the various payment methods was based on the Strategy standard.

Strategy is a behavioral design pattern that allows you to define a family of algorithms,
put them in separate classes, and make their objects interchangeable.


Arquitetura organizada na pasta:
```
/app/services/payments
```

Exemplo de uso:
```ruby
   Payments::Context.new('bank_slip').pay(invoice)
   Payments::Context.new('credit_card').pay(invoice)
```

# Como adicionar um novo tipo de pagamento?
Atualmente o sistema suporta 2 meios de pagamentos bank_slip e credit_card.
```
/app/services/payments/types/bank_slip.rb
/app/services/payments/types/credit_card.rb
```

Para adicionar o pix como um novo meio de pagamento, crie um novo arquivo no destino:
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

Pronto. Todo o restante do sistema deve identificar esse novo meio de pagamento.

O arquivo de teste type_spec.rb verifica quais os meios de pagamentos do sistema.

Atualize o teste type_spec.rb com o novo meio de pagamento pix:

```
spec/services/payments/type_spec.rb
```

```ruby
  let(:payment_types) do
      ['bank_slip', 'credit_card', 'pix']
  end
```

# Configuração

```
ruby --version
ruby 3.1.2p20

rails --version
Rails 7.0.7
```

# Como executar o projeto?
```
rails db:create db:migrate db:seed
```

```
rails s
```

Acesse o localhost:3000.


# Como executar os testes?

```
rspec
```

# Algumas gems adicionadas durante o desenvolvimento
- faker - It's a library for generating fake data such as names, addresses, and phone numbers.
- money-rails - This library provides integration of the money gem with Rails.
- shoulda-matchers - Shoulda Matchers provides RSpec- and Minitest-compatible one-liners to test common Rails functionality that, if written by hand, would be much longer, more complex, and error-prone.
- kaminari - A Scope & Engine based, clean, powerful, customizable and sophisticated paginator for modern web app frameworks and ORMs.
- rubocop - RuboCop is a Ruby static code analyzer (a.k.a. linter) and code formatter.
- guard - Guard automates various tasks by running custom rules whenever file or directories are modified.


# This is just an example application

Although this is apparently a real problem with a billing system, it was written for testing purposes only.
