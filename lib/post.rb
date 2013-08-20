require 'json'

class Post
	def self.load_files(directory = 'data/')
		posts = []
		Dir.glob(directory + '*.json').each do |file|
			post = JSON.load(File.read(file))
			id = File.basename(file, '.json')

			posts << self.new(:id => id, :body => post['body'], :title => post['title'], :date => post['date'])
		end

		posts
	end

	def self.load_file(id, directory = 'data/')
		file = directory + id.to_s + '.json'
		post = JSON.load(File.read(file))

		self.new(:id => id, :body => post['body'], :title => post['title'], :date => post['date'])
	end

	attr_reader :id, :date, :title, :body

	def initialize(options)
		@id = options[:id]
		@body = options[:body]
		@title = options[:title]
		@date = options[:date]
	end
end