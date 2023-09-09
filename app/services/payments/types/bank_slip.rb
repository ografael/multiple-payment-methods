# frozen_string_literal: true

module Payments
  module Types
    class BankSlip < Payments::Type
      def pay(invoice)
        invoice.update(status: 'Boleto pago')
      end
    end
  end
end
