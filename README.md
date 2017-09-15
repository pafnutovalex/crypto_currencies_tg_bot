# crypto_currencies_tg_bot
Crypto Currencies Exchange Rates - Telegram Bot
# HEROKU settings
heroku config:set TGBOTAPITOKEN={token}
heroku ps:scale web=0
heroku ps:scale worker=1
