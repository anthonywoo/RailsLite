class Route

	def initialize(url_pattern, http_method, controller_class, action_name)
		@url_pattern = url_pattern
		@http_method = http_method
		@controller_class = controller_class
		@action_name = action_name

	end
	#users\/\d
	def matches?(req)
		@url_pattern =~ req.path && req.request_method.downcase.to_sym == @http_method
	end

	def run(req, res)
		@controller_class.new(req, res).invoke_action(@action_name)
	end

end