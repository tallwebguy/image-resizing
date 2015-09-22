path = require 'path'

config =
	image_root : process.env.IMAGE_ROOT or path.join __dirname, '..', 'input_images'

module.exports = config
