# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CustomersController do
  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    let(:customer) { create(:customer) }

    it 'returns a successful response' do
      get :show, params: { id: customer.id }
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
      it 'creates a new customer' do
        customer_params = build(:customer).attributes
        expect do
          post :create, params: { customer: customer_params }
        end.to change(Customer, :count).by(1)
      end

      it 'redirects to the created customer' do
        customer_params = build(:customer).attributes
        post :create, params: { customer: customer_params }
        expect(response).to redirect_to(Customer.last)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new customer' do
        expect do
          post :create, params: { customer: { name: '' } }
        end.not_to change(Customer, :count)
      end
    end
  end

  describe 'GET #edit' do
    let(:customer) { create(:customer) }

    it 'returns a successful response' do
      get :edit, params: { id: customer.id }
      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    let(:customer) { create(:customer) }

    context 'with valid attributes' do
      it 'updates the customer' do
        patch :update, params: { id: customer.id, customer: { name: 'Updated Post' } }
        customer.reload
        expect(customer.name).to eq('Updated Post')
      end

      it 'redirects to the updated customer' do
        patch :update, params: { id: customer.id, customer: { name: 'Updated Post' } }
        expect(response).to redirect_to(customer)
      end
    end

    context 'with invalid attributes' do
      it 'does not update the customer' do
        original_name = customer.name
        patch :update, params: { id: customer.id, customer: { name: '' } }
        customer.reload
        expect(customer.name).to eq(original_name)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:customer) { create(:customer) }

    it 'destroys the customer' do
      expect do
        delete :destroy, params: { id: customer.id }
      end.to change(Customer, :count).by(-1)
    end

    it 'redirects to the customers index' do
      delete :destroy, params: { id: customer.id }
      expect(response).to redirect_to(customers_path)
    end
  end
end
