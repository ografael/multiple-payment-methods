# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Payments::Types::BankSlip do
  it { expect(described_class).to be < Payments::Type }
end
