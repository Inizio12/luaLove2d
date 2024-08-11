local love = require "love"

function love.conf(app)
    app.window.width = 800
    app.window.height = 600
    app.window.title = "Ski Santa"
    app.window.resizable = false
    app.window.fullscreen = false
    app.window.borderless = true
end
