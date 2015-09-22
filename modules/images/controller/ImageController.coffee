fs = require 'fs'
path = require 'path'
lwip = require 'lwip'

class ImageController

	constructor : (app) ->
		@._app = app

	resize : (req, res) =>
		#load the image into lwip (if it exists)
		image_root = @._app.get("config").image_root
		console.log "Loading from #{image_root}"

		if not req.params.image? or not req.params.x? or not req.params.y?
			res.status(400).end()
			return

		image_filename = path.join image_root, req.params.image
		console.log "Image : #{image_filename}"

		lwip.open image_filename, (err, image) =>
			if err?
				if err.code? and err.code is 'ENOENT'
					return res.status(404).end()
				return res.status(500).end()
			else
				image.resize parseInt(req.params.x, 10), parseInt(req.params.y,10), 'lanczos', (err, resizedImage) =>
					resizedImage.toBuffer 'png', { compression : 'fast' }, (err, buffer) =>
						res.status(200).send(buffer)


module.exports = ImageController
