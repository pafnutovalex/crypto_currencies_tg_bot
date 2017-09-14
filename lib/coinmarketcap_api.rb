class CoinMarketCapApi < CommonApi
  def initialize()
  	self.api_url = "https://min-api.cryptocompare.com/data/"
  end

  def get_rates
  	res = []
  	response = self.access_url_by('top/volumes', 'get', {tsym: "USD", limit: 9})
  	tickers = response["Data"].map{|t| t["SYMBOL"]}
  	tickers.each_with_index do |ticker, index|
  		response = self.access_url_by('price', 'get', {fsym: ticker, tsyms: "USD"})
  		res << "#{index+1}. #{ticker}: $#{response["USD"]}"
  	end
  	res.join("\n")
  end
end
