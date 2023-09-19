# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Invoices::Payments do
  describe '.pay' do
    let!(:customer) do
      create(:customer)
    end

    context 'with a pending invoice' do
      let!(:invoice) { create(:invoice, status: 'pending', customer:) }

      it 'update the invoice status to paid' do
        described_class.pay
        expect(invoice.reload.status).to eq("#{customer.payment_type} paid")
      end
    end
  end
end
