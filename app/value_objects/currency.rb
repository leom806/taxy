class Currency
  EXCEPTIONS = [:all]

  def self.default_formatted
    default.to_s.upcase
  end

  def self.default
    :eur
  end

  def self.all
    currencies.select { |currency, value| !currency.in? EXCEPTIONS }
  end

  def self.all_formatted
    all.keys.map(&:to_s).map(&:upcase)
  end

  def self.to_h
    all
  end

  def self.symbols
    all
      .keys
      .map { |currency| [currency, Money::Currency.new(currency.to_s.upcase).symbol] }
      .to_h
  end

  private

  def self.currencies
    i = 0
    Money::Currency
      .table
      .map do |currency|
        i += 5
        [currency[0], i]
      end
      .to_h
  end
end
