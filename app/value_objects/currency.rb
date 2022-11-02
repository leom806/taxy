class Currency
  @@currencies = { eur: 5, usd: 10, inr: 15 }.freeze

  def self.default
    :eur
  end

  def self.all
    @@currencies
  end

  def self.to_h
    @@currencies
  end
end
