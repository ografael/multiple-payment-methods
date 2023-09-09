# frozen_string_literal: true

class ReportsController < ApplicationController
  def index
    @invoices_not_pending = Invoice.not_pending
    @customers_recurring_payment_today = Customer.recurring_payment_today
  end

  def pay
    Invoices::RecurringPaymentToday.pay

    redirect_to reports_path
  end

  def reset
    Invoice.all.update(status: 'pending')

    redirect_to reports_path
  end
end
