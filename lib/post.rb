require 'json'
require 'time'

class Post
	def self.all(directory = 'data/')
		if @all
			@all
		else
			posts = []
			Dir.glob(directory + '*.json').each do |file|
				post = JSON.load(File.read(file))
				id = File.basename(file, '.json')

				posts << self.new(:id => id, :body => post['body'], :title => post['title'], :date => post['date'], :hide => post['hide'])
			end
			@all = posts
		end
	end

	def self.load_recent(n=6, offset=0)
		shown_posts = self.all.reject{|p| p.hide}
		posts = shown_posts.sort_by(&:date).reverse[offset..-1]
		posts ? posts[0..(n-1)] : []
	end

	def self.load_file(id, directory = 'data/')
		file = directory + id.to_s + '.json'
		post = JSON.load(File.read(file))

		self.new(:id => id, :body => post['body'], :title => post['title'], :date => post['date'], :hide => post['hide'])
	end

	attr_reader :id, :date, :title, :body, :hide

	def initialize(options)
		@id = options[:id]
		@body = options[:body]
		@title = options[:title]
		@date = Time.strptime(options[:date], '%B %e, %Y')
		@hide = options[:hide] || false
	end
end