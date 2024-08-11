local love = require "love"
local Santa = require "Santa"

local santa

function love.load()
    love.mouse.setVisible(false)
    love.graphics.setBackgroundColor(225 / 255, 245 / 255, 244 / 255)

    santa = Santa.new()
end

function love.update(dt)
    santa:update(dt)
end

function love.draw()
    santa:draw()
end