class GetConversionRatesService < ::ApplicationService
  private

  FROM = ::Currency.default_formatted
  TO = ::Currency.all_formatted.join(",")

  CONVERTER_BASE_URL =
    "https://api.apilayer.com/fixer/latest?base=#{FROM}&symbols=#{TO}&apikey=#{ENV["FIXERIO_API_KEY"]}"

  def initialize
  end

  def execute
    get_latest_rates
  end

  def get_latest_rates
    http_call["rates"]
  end

  def http_call
    url = CONVERTER_BASE_URL

    JSON.parse HTTParty.get(url).body
  end
end
