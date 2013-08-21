require 'rubygems'
require 'sinatra'
require 'lib/post'

class CCBlog < Sinatra::Base
	before do
		@posts = Post.load_files
	end
	
	get '/' do
		erb :home, :locals => {:posts => @posts}
	end

	get '/:id' do
		id = params[:id]
		post = Post.load_file(id)
		erb :post, :locals => {:post => post}
	end

	helpers do
	  def nest_template(path)
    	content = File.read(File.expand_path(path))
	    t = ERB.new(content)
	    t.result(binding)
	  end
	end
end