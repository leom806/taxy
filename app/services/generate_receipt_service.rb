class GenerateReceiptService < ApplicationService
  private

  attr_reader :items

  def initialize(items:)
    @items = items
    @receipt = ::Receipt.new
  end

  def execute
    prepare_items
    calculate_total
    calculate_taxes

    @receipt.save!
    @receipt
  end

  def prepare_items
    attributes = items.values.map { |item| build_item_attributes(item) }
    @receipt.receipt_items_attributes = attributes
  end

  def build_item_attributes(item)
    quantity = [item[:quantity].to_i, 1].max
    amount = (item[:amount].to_f * 100).to_i
    description = item[:description]
    tax_amount = ::ReceiptItemTaxService.execute(description: description, amount: amount)

    {
      quantity: quantity,
      amount: amount,
      description: description,
      tax_amount: tax_amount
    }
  end

  def calculate_total
    @receipt.amount =
      @receipt.receipt_items.map { |item| item.amount * item.quantity }.sum
  end

  def calculate_taxes
    @receipt.tax_amount =
      @receipt.receipt_items.map { |item| item.tax_amount * item.quantity }.sum
  end
end
