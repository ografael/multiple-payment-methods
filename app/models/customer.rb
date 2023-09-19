# frozen_string_literal: true

class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy

  validates :name, :payment_type, presence: true

  default_scope { order(name: :asc) }

  def payment_types
    Payments::Type.all
  end
end
