# frozen_string_literal: true

payment_types = Payments::Type.all

10.times do
  customer = Customer.create!(
    name: Faker::Name.unique.name,
    payment_type: payment_types.sample
  )
  rand(1..5).times do
    customer.invoices.create!(
      status: 'pending',
      amount_cents: rand(1_99..99_99)
    )
  end
end
