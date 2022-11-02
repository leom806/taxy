require 'rails_helper'

RSpec.describe "receipts/edit", type: :view do
  let(:receipt) {
    Receipt.create!(
      tax_amount: 1,
      amount: 1,
      default_currency: 1
    )
  }

  before(:each) do
    assign(:receipt, receipt)
  end

  it "renders the edit receipt form" do
    render

    assert_select "form[action=?][method=?]", receipt_path(receipt), "post" do

      assert_select "input[name=?]", "receipt[tax_amount]"

      assert_select "input[name=?]", "receipt[amount]"

      assert_select "input[name=?]", "receipt[default_currency]"
    end
  end
end
