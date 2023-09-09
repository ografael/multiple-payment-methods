# frozen_string_literal: true

module Payments
  class Type
    def pay(invoice)
      raise ArgumentError, 'Invalid invoice' if invoice.blank?

      raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end

    def self.all
      folder_path = 'app/services/payments/types'
      file_names = Rails.root.join(folder_path).entries.select do |entry|
        File.file?("#{folder_path}/#{entry}")
      end
      file_names.map { |file| File.basename(file, '.*') }.sort
    end
  end
end
