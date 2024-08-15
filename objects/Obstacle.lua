local love = require "love"

local Obstacle = {}
Obstacle.__index = Obstacle

local windowWidth = love.graphics.getWidth()
local windowHeight = love.graphics.getHeight()

function Obstacle.new()
    local self = setmetatable({}, Obstacle)
    
    self.imageWidth = self.images[1]:getWidth()
    self.imageHeight = self.images[1]:getHeight()
    self.imageScale = 1.5
    self.scaledImageWidth = self.imageWidth * self.imageScale
    self.scaledImageHeight = self.imageHeight * self.imageScale
    self.x = math.random(20, windowWidth - 50) - self.scaledImageWidth / 2
    self.y = math.random(windowHeight - 30, windowHeight + 400) + self.scaledImageHeight / 2

    self.images = Obstacle.images

    self.imageIndex = math.random(1,2)

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

function Obstacle:getBoundingBox()
    return self.x + 20, self.y + 20, self.scaledImageWidth - 40, self.scaledImageHeight - 40
end

function Obstacle:checkTouched(santa)
    local santaX, santaY, santaWidth, santaHeight = santa:getBoundingBox()
    local myX, myY, myW, myH = self:getBoundingBox()
    return myX < santaX + santaWidth and myY < santaY + santaHeight and santaX < myX + myW and santaY < myY + myH
end


function Obstacle:draw()
    local image = self.images[self.imageIndex]
    love.graphics.draw(image, self.x, self.y, 0, self.imageScale, self.imageScale)
end


Obstacle.images = {
    love.graphics.newImage("Images/tree.png"),
    love.graphics.newImage("Images/snowman.png")
}
return Obstacle