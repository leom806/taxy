module ReceiptsHelper
  def monetize(amount, currency = ::Currency.default)
    ::Money.from_cents(amount, currency.to_s.upcase).format
  end
end
