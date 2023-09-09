# frozen_string_literal: true

FactoryBot.define do
  factory :invoice do
    customer
    amount_cents { 10_99 }
    status { 'pending' }
    due_at { Time.zone.today }
  end
end
