# frozen_string_literal: true

FactoryBot.define do
  factory :customer do
    name { Faker::Name.unique.name }
    payment_type { Payments::Type.all.sample }
  end
end
