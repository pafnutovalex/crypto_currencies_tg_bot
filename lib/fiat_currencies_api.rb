class FiatCurrenciesApi < CommonApi  
  def initialize()
  	self.api_url = "https://api.fixer.io/"
  end

  def get_rates
  	res = []
  	response = self.access_url_by('latest', 'get', {base: "USD"})
  	"USD/RUB: #{response["rates"]["RUB"]}"
  end
end
