module.exports = (app) =>

	imageController = app.get("controllers").ImageController

	app.get "/:x/:y/:image", imageController.resize
