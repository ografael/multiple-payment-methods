# frozen_string_literal: true

module Payments
  module Types
    class CreditCard < Payments::Type
      def pay(invoice)
        invoice.update(status: 'credit_card paid')
      end
    end
  end
end
