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
end