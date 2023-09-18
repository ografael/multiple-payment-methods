# frozen_string_literal: true

MoneyRails.configure do |config|
  # config.default_currency = 'BRL'
  config.rounding_mode = BigDecimal::ROUND_HALF_UP
end

Money.locale_backend = :i18n
