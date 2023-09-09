# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InvoicesController do
  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    let(:invoice) { create(:invoice) }

    it 'returns a successful response' do
      get :show, params: { id: invoice.id }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let!(:customer) { create(:customer) }

      it 'creates a new invoice' do
        expect do
          post :create, params: {
            invoice: {
              customer_id: customer.id,
              amount: '1.000,99',
              due_at: '01/01/2023'
            }
          }
        end.to change(Invoice, :count).by(1)
        expect(Invoice.last.amount_cents).to eq(1_000_99)
      end

      it 'redirects to the created invoice' do
        post :create, params: {
          invoice: {
            customer_id: customer.id,
            amount: '99,99',
            due_at: '01/01/2023'
          }
        }
        expect(response).to redirect_to(Invoice.last)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new invoice' do
        expect do
          post :create, params: { invoice: { name: '' } }
        end.not_to change(Invoice, :count)
      end
    end
  end

  describe 'GET #edit' do
    let(:invoice) { create(:invoice) }

    it 'returns a successful response' do
      get :edit, params: { id: invoice.id }
      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    let(:invoice) { create(:invoice) }

    context 'with valid attributes' do
      it 'updates theinvoice' do
        patch :update, params: { id: invoice.id, invoice: { amount: '10,99' } }
        invoice.reload
        expect(invoice.amount_cents).to eq(1099)
      end

      it 'redirects to the updated invoice' do
        patch :update, params: { id: invoice.id, invoice: { amount: '10,99' } }
        expect(response).to redirect_to(invoice)
      end
    end

    context 'with invalid attributes' do
      it 'does not update the invoice' do
        original_amount_cents = invoice.amount_cents
        patch :update, params: { id: invoice.id, invoice: { name: '' } }
        invoice.reload
        expect(invoice.amount_cents).to eq(original_amount_cents)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:invoice) { create(:invoice) }

    it 'destroys the invoice' do
      expect do
        delete :destroy, params: { id: invoice.id }
      end.to change(Invoice, :count).by(-1)
    end

    it 'redirects to the invoices index' do
      delete :destroy, params: { id: invoice.id }
      expect(response).to redirect_to(invoices_path)
    end
  end
end
