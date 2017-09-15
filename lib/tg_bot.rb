class TgBot < CommonApi
  require 'lib/coinmarketcap_api'
  require 'lib/fiat_currencies_api'

  attr_accessor :token
  
  UPDATE_TIME = 5

  def initialize(token)
  	self.token = token
  	self.api_url = "https://api.telegram.org/bot#{token}/"
    @used_update_ids = []
  end

  def get_updates(timeout=30, offset=nil)
  	response = self.access_url_by('getUpdates', 'get', {'timeout' => timeout, 'offset' => offset})
  	response['result']
  end

  def send_message(chat_id, text)
  	self.access_url_by('sendMessage', 'get', {'chat_id' => chat_id, 'text' => text})
  end

  def run
    loop do
      offset = @used_update_ids.last.to_i + 1
      updates = get_updates(offset: offset)
      updates.each do |update|
        unless @used_update_ids.include?(update['update_id'])
          @used_update_ids << update['update_id']
          chat_id = update['message']['chat']['id']
          send_message(chat_id, prices.map{|pr| pr.get_rates()}.join("\n"))
        end
      end

      sleep(UPDATE_TIME)
    end
  end

  private
    def prices
      crypto_prices = CoinMarketCapApi.new()
      fiat_prices = FiatCurrenciesApi.new()
      prices = [crypto_prices, fiat_prices]
    end
end
