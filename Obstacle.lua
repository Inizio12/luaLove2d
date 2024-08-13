local love = require "love"

local Obstacle = {}
Obstacle.__index = Obstacle

local windowWidth = love.graphics.getWidth()
local windowHeight = love.graphics.getHeight()

function Obstacle.new()
    local self = setmetatable({}, Obstacle)
    
    self.x = math.random(20, windowWidth - 50)
    self.y = math.random(windowHeight - 30, windowHeight + 400)

    self.images = {
        love.graphics.newImage("Images/tree.png"),
        love.graphics.newImage("Images/snowman.png")
    }

    self.imageIndex = math.random(1,2)
    self.imageWidth = self.images[1]:getWidth()
    self.imageHeight = self.images[1]:getHeight()

    self.speed = 100

    return self
end

function Obstacle:update(dt)
    if (self.y > 20) then 
        self.y = self.y - self.speed * dt
    else
        self.x = math.random(20, windowWidth - 50)
        self.y = windowHeight + math.random(10, 300)
    end
end

function Obstacle:setObstacleSpeed(speed)
    self.speed = speed or 100
end

function Obstacle:draw()
    local image = self.images[self.imageIndex]
    love.graphics.draw(image, self.x - self.imageWidth / 2, self.y - self.imageHeight / 2, 0, 1.5, 1.5)
end

return Obstacle