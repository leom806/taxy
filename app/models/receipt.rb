class Receipt < ApplicationRecord
  include Deletable

  has_many :receipt_items

  accepts_nested_attributes_for :receipt_items,
                                reject_if: proc { |item| item[:description].blank? }

  validates :amount, :tax_amount, presence: true

  enum default_currency: ::Currency.all
end
