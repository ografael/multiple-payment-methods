# frozen_string_literal: true

class Invoice < ApplicationRecord
  belongs_to :customer

  monetize :amount_cents

  validates :status, presence: true

  validates :amount, numericality: { greater_than: 0 }

  default_scope { includes([:customer]) }

  scope :not_pending, -> { where.not(status: 'pending') }

  scope :pending, -> { where(status: 'pending') }
end
