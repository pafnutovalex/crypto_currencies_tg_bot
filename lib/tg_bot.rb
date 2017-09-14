class TgBot < CommonApi
  attr_accessor :token

  def initialize(token)
  	self.token = token
  	self.api_url = "https://api.telegram.org/bot#{token}/"
  end

  def get_updates(timeout=30, offset=nil)
  	response = self.access_url_by('getUpdates', 'get', {'timeout' => timeout, 'offset' => offset})
  	response['result']
  end

  def send_message(chat_id, text)
  	self.access_url_by('sendMessage', 'get', {'chat_id' => chat_id, 'text' => text})
  end

  def get_last_update
  	get_result = self.get_updates()
  	if get_result.size > 0
  		get_result[-1]
  	else
  		get_result[get_result.size]
  	end
  end
end
