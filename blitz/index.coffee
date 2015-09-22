###
This is Blitz. It's something I wrote to simplify the start up of an
MVC Express application.

- Modloader runs through the modules directory and loads in any models and any controllers
It creates singleton versions of these and stashes them inside the express application itself.
You never need to create an instance of a controller or model at run time, blitz handles it.

This is a deliberate design choice for a couple of reasons
- It means you are _forced_ to never store user specific state in controllers or models
(since you might be running in a load balanced environment, this is not a bad thing..)
- It did reduce the memory footprint of the site I wrote it for, since you've only got a single
instance of each controller and model, rather than multiple instances. Was a small improvement, granted.
###

modloader = require "./modloader"
configloader = require "./configloader"
#ormloader = require "./ormloader"

###
Modloader and Moduleloader packaged a bit neater..
###
module.exports =
	###
	Load up everything in the modules directory
	###
	loadModules : (expressApp) =>
		modloader(expressApp)

	loadConfig : (expressApp) =>
		configloader(expressApp)

	###
	Load up the ORM stuff and connecting to the database
	###
	# loadORM : (expressApp) =>
	# 	ormloader(expressApp)
