module.exports = (app) =>

	imageController = app.get("controllers").ImageController

	app.get "/test", imageController.test
