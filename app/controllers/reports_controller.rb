# frozen_string_literal: true

class ReportsController < ApplicationController
  def index
    @invoices_pending = Invoice.pending
    @invoices_not_pending = Invoice.not_pending
  end

  def pay
    Invoices::Payments.pay

    redirect_to reports_path
  end

  def reset
    Invoice.all.update(status: 'pending')

    redirect_to reports_path
  end
end
