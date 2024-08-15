local love = require "love"

local Santa = {}
Santa.__index = Santa

function Santa.new()
    local self = setmetatable({}, Santa)
    
    self.imageScale = 2
    self.imageWidth = self.images.straight[1]:getWidth()
    self.imageHeight = self.images.straight[1]:getHeight()
    self.scaledImageWidth = self.imageWidth * 2
    self.scaledImageHeight = self.imageHeight * 2
    self.x = love.graphics.getWidth() / 2 - self.scaledImageWidth / 2
    self.y = love.graphics.getHeight() / 4 - self.scaledImageHeight / 8
    self.images = Santa.images
        

    self.state = "straight"
    self.imageIndex = 1
    self.timeAccumulator = 0
    self.swapInterval = 1
    self.speed = 200

    return self
end

function Santa:setSwapInterval()
    if (self.swapInterval > 0.1) then
        self.swapInterval = self.swapInterval - 0.2
    end
end

function Santa:setState(state)
    if self.images[state] then
        self.state = state
    end
end

function Santa:getBoundingBox()
    return self.x + 20, self.y + 20, self.scaledImageWidth - 40, self.scaledImageHeight - 40
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
    if self.state == "dead" then
        self.image = self.images[self.state][1]
    end
    if self.timeAccumulator >= self.swapInterval then
        self.timeAccumulator = self.timeAccumulator - self.swapInterval
        self.imageIndex = (self.imageIndex % 2) + 1
    end

end

function Santa:draw()
    local image = self.images[self.state][self.imageIndex] or self.images[self.state][1]
    love.graphics.draw(image, self.x, self.y, 0, self.imageScale, self.imageScale)
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
    },
    dead = {
        love.graphics.newImage("Images/santa-fall.png")
    }
}

return Santa