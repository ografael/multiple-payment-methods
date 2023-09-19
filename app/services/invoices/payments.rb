# frozen_string_literal: true

module Invoices
  class Payments
    def self.pay
      Invoice.pending.each do |invoice|
        customer = invoice.customer
        ::Payments::Context.new(customer.payment_type).pay(invoice)
      end
    end
  end
end
