# frozen_string_literal: true

module Invoices
  class RecurringPaymentToday
    def self.pay
      Customer.recurring_payment_today.find_each do |customer|
        customer.invoices.pendings.each do |invoice|
          Payments::Context.new(customer.payment_type).pay(invoice)
        end
      end
    end
  end
end
