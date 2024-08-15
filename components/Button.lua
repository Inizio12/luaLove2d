local love = require "love"

local Button = {}
Button.__index = Button

function Button.new(label, x, y, width, height, action)
    local self = setmetatable({}, Button)

    self.label = label or ""
    self.x = x or 0
    self.y = y or 0
    self.width = width or 100
    self.height = height or 50
    self.action = action or function() end

    return self
end

function Button:isClicked(x, y)
    return x >= self.x and x <= (self.x + self.width) and y >= self.y and self.y <= (self.y + self.height)
end

function Button:draw()
    love.graphics.setColor(0.2, 0.6, 0.8)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf(self.label, self.x, self.y + (self.height / 2) - 10, self.width, "center")
end

function Button:update(x, y, mousePressed)
    if mousePressed and self:isClicked(x, y) then
        self.action()
    end
end

return Button