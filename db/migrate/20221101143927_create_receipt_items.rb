class CreateReceiptItems < ActiveRecord::Migration[7.0]
  def change
    create_table :receipt_items do |t|
      t.belongs_to :receipt, null: false
      t.integer :amount, null: false
      t.integer :tax_amount, null: false, default: 0
      t.integer :quantity, null: false, default: 1
      t.text :description, null: false

      t.timestamps
    end
  end
end
