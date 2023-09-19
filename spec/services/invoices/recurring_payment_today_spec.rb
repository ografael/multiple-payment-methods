# frozen_string_literal: true

require 'rails_helper'

# RSpec.describe Invoices::RecurringPaymentToday do
#   describe '.pay' do
#     let!(:customer) do
#       create(:customer, recurring_payment_day:)
#     end

#     context 'with a pending invoice and recurring today' do
#       let(:recurring_payment_day) { Time.zone.now.day }
#       let!(:invoice) { create(:invoice, customer:) }

#       it 'update the invoice status' do
#         described_class.pay
#         expect(invoice.reload.status).not_to eq('pending')
#       end
#     end

#     context 'with recurring_payment_day is greater then last day of the month' do
#       let(:time_now) { Time.zone.local(2023, 2, 28) }
#       let(:recurring_payment_day) { 31 }
#       let!(:invoice) { create(:invoice, customer:) }

#       before do
#         allow(Time).to receive(:now).and_return(time_now)
#       end

#       it 'update the invoice status' do
#         described_class.pay
#         expect(invoice.reload.status).not_to eq('pending')
#       end
#     end

#     context 'with a pending invoice and recurring tomorrow' do
#       let(:recurring_payment_day) { Time.zone.tomorrow.day }
#       let!(:invoice) { create(:invoice, customer:) }

#       it 'dont update the invoice status' do
#         described_class.pay
#         expect(invoice.reload.status).to eq('pending')
#       end
#     end
#   end
# end
