require 'webrick'
require 'pry'
require 'active_support/core_ext'
require_relative 'controller_base.rb'
require_relative 'cookies.rb'

class MyController < ControllerBase

	def go
		if req.path == "/redirect"
			redirect_to("http://www.google.com")
		elsif req.path == "/request"

			# after you have sessions going, uncomment:
		  session["count"] ||= 0
		  session["count"] += 1
	    #render_content("#{session["count"]}", "text/html")
			#content = req.query_string.split("=")[1] #redo with query?
			#render_content(content,"text/html")
			@test  = "asd"
			render :show
		end
	end

	def render(file)
		path = "./views/#{self.class.to_s.underscore}/#{file}.html.erb"
		file_template = File.read(path)
		render_content(ERB.new(file_template).result(binding), 'text/html')
	end

end


server = WEBrick::HTTPServer.new :Port => 8080

server.mount_proc("/") do |req, res|
	#res.content_type = "text/text"
	#res.body = req.path
	MyController.new(req, res).go
end

trap('INT') { server.shutdown }
server.start


