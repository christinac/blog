require 'rubygems'
require 'sinatra'

$:.unshift File.dirname(__FILE__)

require 'lib/post'

class CCBlog < Sinatra::Base
  PostsPerPage = 6

	before do
		@posts = Post.load_recent
    @max_pages = (Post.all.count / PostsPerPage).ceil 
	end
	
	get '/' do
		erb :home, :locals => {:posts => @posts, :page => 1, :max_pages => @max_pages}
	end

	get '/post/:id' do
		id = params[:id]
		post = Post.load_file(id)
		erb :post, :locals => {:post => post}
	end

  get '/page/:num' do
    offset = (params[:num].to_i - 1) * PostsPerPage
    posts = Post.load_recent(PostsPerPage, offset)
    erb :home, :locals => {:posts => posts, :page => params[:num].to_i, :max_pages => @max_pages}
  end

	helpers do
	  def nest_template(path)
    	content = File.read(File.expand_path(path))
	    t = ERB.new(content)
	    t.result(binding)
	  end
	end
end