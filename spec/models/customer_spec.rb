# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Customer do
  describe 'associations' do
    it { is_expected.to have_many(:invoices) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:payment_type) }
  end

  describe '#payment_types' do
    it 'has at least one payment_type' do
      expect(described_class.new.payment_types).not_to be_empty
    end
  end
end
