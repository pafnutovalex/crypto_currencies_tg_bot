$LOAD_PATH << '.'
require 'lib/common_api'
require 'lib/tg_bot'

bot = TgBot.new(ENV['TGBOTAPITOKEN'])

bot.run
