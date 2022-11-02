require 'rails_helper'

RSpec.describe "receipts/show", type: :view do
  before(:each) do
    assign(:receipt, Receipt.create!(
      tax_amount: 2,
      amount: 3,
      default_currency: 4
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
  end
end
