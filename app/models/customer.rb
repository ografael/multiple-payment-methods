# frozen_string_literal: true

class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy

  validates :name, :payment_type, :recurring_payment_day, presence: true
  validates :recurring_payment_day, inclusion: 1..31

  default_scope { order(name: :asc) }

  def payment_types
    Payments::Type.all
  end

  def self.recurring_payment_today
    today = Time.zone.now
    current_day = today.day
    last_day_of_month = today.end_of_month.day

    if current_day >= last_day_of_month
      where('recurring_payment_day >= ?', last_day_of_month)
    else
      where('recurring_payment_day == ?', current_day)
    end
  end
end
