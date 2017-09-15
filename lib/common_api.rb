class CommonApi
  require 'net/http'
  require 'open-uri'
  require 'json'
  
  attr_accessor :api_url

	protected
	  def full_url(path, params={})
	    self.api_url + path + "?#{to_query(params)}"
	  end

	  def access_url_by(path, method_name, params={})
	    uri = URI.parse(URI.encode(full_url(path, params)))
	    http = Net::HTTP.new(uri.host, uri.port)
	    http.use_ssl = true
	    http = http.start
	    http.read_timeout = 30
	    tries ||= 5
	    begin
	    	print("!!!!!!!!!!!!!=#{uri.to_s}")
	      response = http.send(method_name, uri.to_s)
	      if response.code == '200'
	        JSON.parse(response.body)
	      else
	        raise "Error is occured"
	      end
	    rescue Exception => e
	      retry unless (tries -= 1).zero?
	    end
	  end

	  def to_query(params = {})
			params.collect{|k,v| "#{k}=#{v}"}.compact.sort*'&'
	  end  
end
