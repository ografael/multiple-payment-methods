# frozen_string_literal: true

class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices do |t|
      t.references :customer, foreign_key: true
      t.monetize :amount
      t.string :status
      t.datetime :due_at

      t.timestamps
    end
  end
end
