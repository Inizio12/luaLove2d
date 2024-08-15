local love = require "love"

local Text = {}
Text.__index = Text

function Text.new(content, x, y, font, color)
    local self = setmetatable({}, Text)

    self.content = content or ""
    self.x = x or 0
    self.y = y or 0
    self.font = font or love.graphics.newFont(24)
    self.color = color or {0, 0, 0}

    return self
end

function Text:setContent(content)
    self.content = content
end

function Text:setPosition(x, y)
    self.x = x
    self.y = y
end

function Text:setFont(font)
    self.font = font
end

function Text:setColor(color)
    self.color = color
end

function Text:draw()
    local prevColor = {love.graphics.getColor()}
    local prevFont = love.graphics.getFont()
    love.graphics.setFont(self.font)
    love.graphics.setColor(self.color)
    love.graphics.print(self.content, self.x, self.y)
    love.graphics.setColor(prevColor)
    love.graphics.setFont(prevFont)
end

return Text