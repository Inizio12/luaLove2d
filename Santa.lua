local love = require "love"

local Santa = {}
Santa.__index = Santa

function Santa.new()
    local self = setmetatable({}, Santa)

    self.x = love.graphics.getWidth() / 2
    self.y = love.graphics.getHeight() / 4
    self.images = {
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
    self.imageWidth = self.images.straight[1]:getWidth()
    self.imageHeight = self.images.straight[1]:getHeight()

    self.state = "straight"
    self.imageIndex = 1

    self.timeAccumulator = 0
    self.swapInterval = 2

    function Santa:setSwapInterval(self, interval)
        self.swapInterval = interval or 2
    end

    return self
end

function Santa:update(dt)
    self.timeAccumulator = self.timeAccumulator + dt
    if self.timeAccumulator >= self.swapInterval then
        self.timeAccumulator = self.timeAccumulator - self.swapInterval
        self.imageIndex = (self.imageIndex % 2) + 1
    end
end

function Santa:draw()
    local image = self.images[self.state][self.imageIndex]
    love.graphics.draw(image, self.x - self.imageWidth / 2, self.y - self.imageHeight / 2, 0, 1.5, 1.5)
end

return Santa