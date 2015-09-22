express = require 'express'
blitz = require './blitz'

app = express()
port = process.env.PORT or 8080

###
Dummy logging app..
###
logger =
	log : (severity, message) => console.log "#{severity} #{message or ''}"
	severity :
		INFO : 'INFO'
		WARN : 'WARN'
		CRITICAL : 'CRITICAL'

app.set "logger", logger

###
Load the configuration in from the config directory
(Currently blank)
###
blitz.loadConfig app

###
Load in the modules directory
###
blitz.loadModules app

app.listen port, () =>
	console.log "LISTENING"
