# frozen_string_literal: true

payment_types = Payments::Type.all

10.times do
  customer = Customer.create!(
    name: Faker::Name.unique.name,
    payment_type: payment_types.sample,
    recurring_payment_day: rand(1..31).to_i
  )
  rand(1..5).times do
    customer.invoices.create!(
      status: 'pending',
      amount_cents: rand(1_99..99_99),
      due_at: Time.zone.at(rand(1.week.ago..1.week.from_now))
    )
  end
end

Customer.limit(10).update(recurring_payment_day: Time.zone.now.day)
