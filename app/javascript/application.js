// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "chartkick"
import "Chart.bundle"

const loadCurrencies = (callback) => {
  fetch('/currency_rates')
    .then(res => res.json())
    .then(res => callback(res.data, res.meta))
}

const handleCurrency = (selected) => {
  loadCurrencies((currencies, symbols) => {
    document.querySelectorAll('p.price').forEach((element => {
      const basePrice = +element.getAttribute('data-base-price') / 100.00
      const convertedPrice = basePrice * currencies[selected]
      const roundedPrice = (Math.ceil(convertedPrice * 20) / 20).toFixed(2)
      const newSymbol = symbols[selected]

      element.innerHTML = `${newSymbol} ${roundedPrice}`
    }))
  })
}


const main = () => {
  const currencySelector = document.getElementById('currency-selector')

  if (currencySelector) {
    currencySelector.addEventListener('change', (event) => {
      const selectedCurrency = event.target.value
      handleCurrency(selectedCurrency)
    })
  }
}

addEventListener('DOMContentLoaded', main)
