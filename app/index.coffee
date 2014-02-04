app = do require 'express'
request = require 'request'

PORT = process.env.PORT or 5000
HOST = process.env.HOST or 'https://bitbucket.org'

app.get '*', (req, res) ->
  # Convert path to array
  segments = req.url.split '/'
  # Insert `raw` into the URL to make GitHub-style compatible, but only if it
  # has a longer path than the usual `account/repository`
  segments.pop() if segments[segments.length - 1] is ''
  segments.splice(3, 0, 'raw') if segments.length > 3
  # Reconstruct the URL
  url = HOST + segments.join '/'

  # Stream request to Bitbucket
  bitbucket = request.get(url)
  req.pipe bitbucket
  bitbucket.pipe res

app.listen PORT
console.log "Listening on port #{PORT}"
