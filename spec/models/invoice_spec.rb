# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Invoice do
  describe 'associations' do
    it { is_expected.to belong_to(:customer) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:status) }
  end
end
