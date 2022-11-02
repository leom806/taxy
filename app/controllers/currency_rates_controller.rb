class CurrencyRatesController < ApplicationController
  def index
    meta = ::Currency.symbols.transform_keys(&:upcase)
    data = ::GetConversionRatesService.execute

    render json: { success: true, meta: meta, data: data }
  end
end
