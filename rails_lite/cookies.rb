require 'json'
class Session
	attr_accessor :cookie
	def initialize(req)
		cookies = req.cookies
		existing_cookie = cookies.select{|cookie| cookie.name == "_rails_lite_app"}
		if existing_cookie.empty?
			@cookie = {}
		else
			@cookie = JSON.parse(existing_cookie[0].value)
		end
	end

	def [](key)
		@cookie[key.downcase]
	end

	def []=(key, value)
		@cookie[key.downcase] = value
	end

	def store_session(response)
		new_cookie = WEBrick::Cookie.new('_rails_lite_app', @cookie.to_json)
		response.cookies << new_cookie
	end

end