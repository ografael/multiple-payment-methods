# frozen_string_literal: true

class CustomersController < ApplicationController
  before_action :set_customer, only: %i[show edit update destroy]

  def index
    @customers = Kaminari.paginate_array(Customer.default_scoped).page(params[:page])
  end

  def show; end

  def new
    @customer = Customer.new
  end

  def edit; end

  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      redirect_to customer_url(@customer), notice: 'Cliente criado.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @customer.update(customer_params)
      redirect_to customer_url(@customer), notice: 'Cliente atualizado.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @customer.destroy

    redirect_to customers_url, notice: 'Cliente deletado.'
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
    @invoices = Invoice.default_scoped.where(customer: @customer)
  end

  def customer_params
    params.require(:customer).permit(:name, :payment_type, :recurring_payment_day)
  end
end
