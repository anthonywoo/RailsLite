class ControllerBase
	attr_accessor :req, :res, :session, :params
	def initialize(req, res, params)
		@req = req
		@res = res
		@response_built = false
		session
		
	end

	def render_content(content, body_type)
		@res.content_type = body_type
		@res.body = content
		@response_built = true
		session.store_session(@res)
	end

	def redirect_to(url)
		@res.status = 302
		@res["location"] = url
		@response_built = true
		session.store_session(@res)
	end

	def session
		@session ||= Session.new(@req)
	end

	def [](key)
		session[key.downcase]
	end

	def []=(key, value)
		session[key.downcase] = value
	end

	def invoke_action(action_name)
		self.send(action_name)
		render_template(action_name) unless @response_built
	end

	def render_template(file)
		path = "./views/#{self.class.to_s.underscore}/#{file}.html.erb"
		file_template = File.read(path)
		render_content(ERB.new(file_template).result(binding), 'text/html')
	end
end

