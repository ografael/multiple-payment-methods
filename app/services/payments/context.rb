# frozen_string_literal: true

module Payments
  class Context
    attr_writer :payment_type

    def initialize(payment_type)
      @payment_type = payment_type_class(payment_type)
    end

    def pay(invoice)
      @payment_type.pay(invoice)
    end

    private

    def payment_type_class(payment_type)
      raise ArgumentError, 'Invalid Payment Type' unless Payments::Type.all.include?(payment_type)

      Object.const_get("Payments::Types::#{payment_type.camelize}").new
    end
  end
end
