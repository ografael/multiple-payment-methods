# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Payments::Type do
  let(:payment_types) do
    %w[bank_slip credit_card]
  end

  describe '.payments_types' do
    it 'has the current payment types' do
      expect(described_class.all).to eq(payment_types)
    end
  end

  describe '#pay' do
    it 'throws ArgumentError if invoice is nil' do
      expect { described_class.new.pay(nil) }.to raise_error(ArgumentError)
    end

    it 'throws ArgumentError if invoice is blank' do
      expect { described_class.new.pay('') }.to raise_error(ArgumentError)
    end

    it 'must implement this method' do
      expect { described_class.new.pay('invalid') }.to raise_error(NotImplementedError)
    end
  end
end
