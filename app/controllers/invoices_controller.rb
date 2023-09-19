# frozen_string_literal: true

class InvoicesController < ApplicationController
  before_action :set_invoice, only: %i[show edit update destroy]

  def index
    @invoices = Kaminari.paginate_array(Invoice.default_scoped).page(params[:page])
  end

  def show; end

  def new
    @invoice = Invoice.new
  end

  def edit; end

  def create
    @invoice = Invoice.new(invoice_params)
    @invoice.status = 'pending'

    if @invoice.save
      redirect_to invoice_url(@invoice), notice: 'Fatura criada.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @invoice.update(invoice_params)
      redirect_to invoice_url(@invoice), notice: 'Fatura atualizada.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @invoice.destroy

    redirect_to invoices_url, notice: 'Fatura deletada.'
  end

  private

  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  def invoice_params
    params.require(:invoice).permit(:customer_id, :amount)
  end
end
