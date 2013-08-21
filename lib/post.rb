require 'json'

class Post
	def self.load_files(directory = 'data/')
		posts = []
		Dir.glob(directory + '*.json').each do |file|
			post = JSON.load(File.read(file))
			id = File.basename(file, '.json')

			posts << self.new(:id => id, :body => post['body'], :title => post['title'], :date => post['date'], :hide => post['hide'])
		end

		posts
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
		@date = options[:date]
		@hide = options[:hide] || false
	end
end