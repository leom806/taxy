class ReceiptItem < ApplicationRecord
  belongs_to :receipt

  scope :count_by_receipt, -> { group(:receipt_id).order(:receipt_id).count }

  validates :amount, :tax_amount, :quantity, :description, presence: true
end
