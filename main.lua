local love = require "love"
local Santa = require "Santa"
local Obstacle = require "Obstacle"

local santa
local obstacles = {}

function love.load()
    math.randomseed(os.time())
    love.mouse.setVisible(false)
    love.graphics.setBackgroundColor(225 / 255, 245 / 255, 244 / 255)

    santa = Santa.new()
    for i = 1, 5 do
        table.insert(obstacles, Obstacle.new())
    end
end

function love.update(dt)
    santa:update(dt)
    for _, obstacle in ipairs(obstacles) do
        obstacle:update(dt)
    end
end

function love.draw()
    santa:draw()
    for _, obstacle in ipairs(obstacles) do
        obstacle:draw()
    end
end