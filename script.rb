$LOAD_PATH << '.'
require 'lib/common_api'
require 'lib/tg_bot'
require 'lib/coinmarketcap_api'
require 'lib/fiat_currencies_api'

def work(bot, *prices)
  bot.get_updates()
  last_update = bot.get_last_update()
  last_chat_id = last_update['message']['chat']['id']
  bot.send_message(last_chat_id, prices.map{|pr| pr.get_rates()}.join("\n"))
end

# HH_CONFIG['telegram_bot_token']
bot = TgBot.new('446191600:AAHTo0ExMfSEK8WPa5ho0izuUsSutroB044')
crypto_prices = CoinMarketCapApi.new()
fiat_prices = FiatCurrenciesApi.new()

work(bot, crypto_prices, fiat_prices)

