###
I like sequelize - it works pretty good as an orm
###
path = require "path"
Seq = require "sequelize"

module.exports = (app) =>

	###
	Connect to the database using the information stashed in config
	###
	logging = app.get("logger").log

	username = app.get("config").database.username
	password = app.get("config").database.password
	host = app.get("config").database.host
	port = app.get("config").database.port
	database = app.get("config").database.db

	connectionString = "postgres://#{username}:#{password}@#{host}:#{port}/#{database}"

	app.get("logger").log "Connecting to database : #{connectionString}"

	seq = new Seq connectionString, {
		dialect : "postgres"
		logging : logging
		define : {
			underscored : true,
			timestamps : false
		}
		omitNull : true
		pool: { maxConnections: 2, maxIdleTime: 30 }
	}
	
	app.set "db", seq

	###
	Load things from ORM directories
	###
	orms = {}
	ormConfig = require "../config/orm-config"
	ormConfig.getORM().forEach (m) =>
		importPath = path.join __dirname, "..", "modules", m.module, "orm", "#{m.model}"
		app.get("logger").log "Loading : #{importPath}"
		orms[m.model] = seq.import importPath
	ormConfig.setRelationships(orms)

	app.set "orm", orms