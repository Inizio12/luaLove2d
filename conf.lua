local love = require "love"

function love.conf(app)
    app.window.width = 1280
    app.window.height = 720
    app.window.title = "Ski Santa"
    app.window.resizable = false
    app.window.fullscreen = false
    app.window.borderless = true
end
