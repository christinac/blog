require 'json'

raise ArgumentError, "Need to pass two arguments: the draft location and the post's title" unless ARGV.length == 2

body = File.read(ARGV[0])

post = {
	'title' => ARGV[1],
	'date' => Time.now.strftime('%B %e, %Y'),
	'body' => body,
	'hide' => true
}

outfilename = "data/#{post['title'].downcase.gsub(' ', '-')}.json"

File.open(outfilename, 'w') { |file| file.write(post.to_json) }