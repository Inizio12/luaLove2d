local love = require "love"

local Santa = {}
Santa.__index = Santa

function Santa.new()
    local self = setmetatable({}, Santa)

    self.x = love.graphics.getWidth() / 2
    self.y = love.graphics.getHeight() / 4
    self.images = Santa.images
        
    self.imageWidth = self.images.straight[1]:getWidth()
    self.imageHeight = self.images.straight[1]:getHeight()

    self.state = "straight"
    self.imageIndex = 1

    self.timeAccumulator = 0
    self.swapInterval = 0.5
    self.speed = 200

    function Santa:setSwapInterval(interval)
        self.swapInterval = interval or 2
    end

    return self
end

function Santa:setState(state)
    if self.images[state] then
        self.state = state
    end
end

function Santa:moveSanta(dt)
    if love.keyboard.isDown("left") and self.x > 20 then
        self.state = "left"
        self.x = self.x - self.speed * dt
    elseif love.keyboard.isDown("right") and self.x < love.graphics.getWidth() - 50 then
        self.state = "right"
        self.x = self.x + self.speed * dt
    else 
        self.state = "straight"
    end
end

function Santa:update(dt)
    self.timeAccumulator = self.timeAccumulator + dt
    if self.timeAccumulator >= self.swapInterval then
        self.timeAccumulator = self.timeAccumulator - self.swapInterval
        self.imageIndex = (self.imageIndex % 2) + 1
    end

    self:moveSanta(dt)
end

function Santa:draw()
    local image = self.images[self.state][self.imageIndex]
    love.graphics.draw(image, self.x - self.imageWidth / 2, self.y - self.imageHeight / 2, 0, 2, 2)
end


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

return Santa