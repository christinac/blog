import datetime
import json
import sys

if len(sys.argv) < 2:
	raise Exception("Need to pass two arguments: the draft location and the post's title")

filename = sys.argv[1]
f = open(filename, 'r')

body = f.read()
f.close()

post = {
	'title': sys.argv[2],
	'date': datetime.datetime.today().strftime('%B %e, %Y'),
	'body': body,
	'hide': True
}

outfilename = 'data/' + post['title'].replace(" ", "-").lower() + '.json'

with open(outfilename, 'w') as outfile:
	json.dump(post, outfile)