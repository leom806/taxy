require 'rails_helper'

RSpec.describe "receipts/index", type: :view do
  before(:each) do
    assign(:receipts, [
      Receipt.create!(
        tax_amount: 2,
        amount: 3,
        default_currency: 4
      ),
      Receipt.create!(
        tax_amount: 2,
        amount: 3,
        default_currency: 4
      )
    ])
  end

  it "renders a list of receipts" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(4.to_s), count: 2
  end
end
