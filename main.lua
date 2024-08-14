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
    Santa.images = {
        straight = {
            love.graphics.newImage("Images/santa1.png"),
            love.graphics.newImage("Images/santa2.png")
        },
        left = {
            love.graphics.newImage("Images/santa-left1.png"),
            love.graphics.newImage("Images/santa-left2.png")
        },
        right = {
            love.graphics.newImage("Images/santa-right1.png"),
            love.graphics.newImage("Images/santa-right2.png")
        }
    }
    Obstacle.images = {
        love.graphics.newImage("Images/tree.png"),
        love.graphics.newImage("Images/snowman.png")
    }
    for i = 1, 10 do
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