class GetRatesFromApi
  include Interactor

  def call
    api_path = "https://api.currencyfreaks.com/latest?apikey=#{ENV['CURRENCY_FREAKS_API_KEY']}&symbols=UAH,JPY,LTC,ETH,EUR"
    response = Faraday.get(api_path)
    json = JSON.parse(response.body)
    json['rates'].each do |currency, value|
      RateRepository.create(currency, value)
    end
  rescue StandardError 
    context.fail!(message: "there are not response from api")
  end
end
