class Router
	http_methods = ["get", "post", "put", "delete"]
	attr_accessor :routes
	def initialize
		@routes = []
	end

	def add_route(route)
		@routes << route
	end

	# def run(req)
	# 	binding.pry
	# end

	http_methods.each do |method|
		define_method(method) do |pattern, controller_class, action_name|
			route = Route.new(pattern, __method__, controller_class, action_name)
			add_route(route)
		end
	end

	def match(req)
		@routes.select{|route| route.matches?(req)}[0]
	end

	def run(req,res)
		#req.path
		id = /\/\d/.match("statuses/1/")[0].gsub("/", "").to_i
		query = req.query #req.query
		match(req).run(req,res) if match(req)
	end

	def draw(&blk)
		instance_eval &blk
	end

	# def get(pattern, controller_class, action_name)
	# 	Route.new(pattern, "get", controller_class, action_name)
	# end

	# def post(pattern, controller_class, action_name)

	# end

	# def put(pattern, controller_class, action_name)

	# end


end