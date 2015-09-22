class ImageController

	constructor : (app) ->

	test : (req, res) =>
		res.status(200).send("HELLO WORLD")

module.exports = ImageController
