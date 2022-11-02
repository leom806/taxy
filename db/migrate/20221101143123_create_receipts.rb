class CreateReceipts < ActiveRecord::Migration[7.0]
  def change
    create_table :receipts do |t|
      t.integer :tax_amount, null: false
      t.integer :amount, null: false
      t.integer :default_currency, default: 5, null: false
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
