###
Load in config.coffee from ../config and then overwrite with the contents of config-<env>.coffee
###
module.exports = (app) =>

	env = process.env.APP_ENV || "dev"
	global.env = env
	config = require "../config/config-#{env}"

	app.set "config", config