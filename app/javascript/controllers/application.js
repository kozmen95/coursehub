// Entry point for the build
import "@hotwired/turbo-rails"
import "./controllers"

// start Stimulus
const application = Application.start()
const context = require.context("controllers", true, /\.js$/)
application.load(definitionsFromContext(context))
