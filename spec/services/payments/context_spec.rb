# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Payments::Context do
  let(:payment_types) do
    ['bank_slip', 'credit_card']
  end

  describe '#pay' do
    let(:customer) { create(:customer, payment_type: payment_types.first) }
    let(:invoice) { create(:invoice, customer:) }
    let(:payment_context) { described_class.new(customer.payment_type) }

    context 'with a valid payment_type' do
      it 'update the invoice status' do
        payment_context.pay(invoice)
        expect(invoice.reload.status).to eq('Boleto pago')
      end
    end

    context 'with a invalid payment_type' do
      let(:message) { 'Invalid Payment Type' }

      it 'when the payment_type is invalid' do
        expect do
          described_class.new('invalid').pay(invoice)
        end.to raise_error(ArgumentError, message)
        expect(invoice.reload.status).to eq('pending')
      end

      it 'when the payment_type is nil' do
        expect do
          described_class.new(nil).pay(invoice)
        end.to raise_error(ArgumentError, 'Invalid Payment Type')
        expect(invoice.reload.status).to eq('pending')
      end

      it 'when the payment_type is blank' do
        expect do
          described_class.new('').pay(invoice)
        end.to raise_error(ArgumentError, 'Invalid Payment Type')
        expect(invoice.reload.status).to eq('pending')
      end
    end
  end
end
