# frozen_string_literal: true

class Invoice < ApplicationRecord
  belongs_to :customer

  monetize :amount_cents

  validates :due_at, :status, presence: true

  validates :amount, numericality: { greater_than: 0 }

  default_scope { includes([:customer]).order(due_at: :asc) }

  scope :not_pending, -> { where.not(status: 'pending') }

  scope :pendings, -> { where(status: 'pending') }
end
