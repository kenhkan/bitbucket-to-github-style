app = do require 'express'

PORT = process.env.PORT or 5000
HOST = process.env.HOST or 'https://bitbucket.org'

app.all '*', (req, res) ->
  # Convert path to array
  segments = req.url.split '/'
  # Insert `raw` into the URL to make GitHub-style compatible, but only if it
  # has a longer path than the usual `account/repository`
  segments.pop() if segments[segments.length - 1] is ''
  segments.splice(3, 0, 'raw') if segments.length > 3
  # Reconstruct the URL
  url = HOST + segments.join '/'

  # Send a request to Bitbucket
  res.redirect 301, url

app.listen PORT
console.log "Listening on port #{PORT}"
