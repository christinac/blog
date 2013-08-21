require 'rubygems'
require 'sinatra'
require 'lib/post'

class CCBlog < Sinatra::Base
	before do
		@posts = Post.load_recent
	end
	
	get '/' do
		erb :home, :locals => {:posts => @posts}
	end

	get '/:id' do
		id = params[:id]
		post = Post.load_file(id)
		erb :post, :locals => {:post => post}
	end

  get '/page/:num' do
    offset = (params[:num].to_i - 1) * 6
    posts = Post.load_recent(nil, offset)
    erb :home, :locals => {:posts => posts}
  end

	helpers do
	  def nest_template(path)
    	content = File.read(File.expand_path(path))
	    t = ERB.new(content)
	    t.result(binding)
	  end
	end
end