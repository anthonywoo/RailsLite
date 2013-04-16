class Params

	def self.parse(req, params)
		id = /\/\d/.match("statuses/1/")[0].gsub("/", "").to_i
		query = req.query #req.query
		@params = {}
		@params.merge!(query)
		@params["id"] = id
		@params.merge!(params)
	end

end