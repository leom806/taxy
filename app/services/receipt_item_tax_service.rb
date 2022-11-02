class ReceiptItemTaxService < ApplicationService
  private

  attr_reader :description, :amount, :item_category

  def initialize(description:, amount:)
    @description = description.downcase
    @amount = amount
    @item_category = ::ItemClassifierService.execute(description: description)
    @tax_amount = 0.0
  end

  def execute
    return 0.0 if description.blank?

    apply_basic_tax
    apply_import_duty_tax
    round_up_to(0.05)

    @tax_amount
  end

  def apply_basic_tax
    @tax_amount += @amount * 0.10 unless item_exempt?
  end

  def apply_import_duty_tax
    @tax_amount += @amount * 0.05 if item_imported?
  end

  def round_up_to(round)
    case round
    when 0.05
      (@tax_amount * 20).ceil / 20
    end
  end

  def item_exempt?
    %w[food book medical].any? { |category| item_category.include?(category) }
  end

  def item_imported?
    description.include?("imported")
  end
end
