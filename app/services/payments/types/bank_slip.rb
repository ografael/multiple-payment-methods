# frozen_string_literal: true

module Payments
  module Types
    class BankSlip < Payments::Type
      def pay(invoice)
        invoice.update(status: 'bank_slip paid')
      end
    end
  end
end
