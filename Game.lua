local love = require "love"
local Santa = require "objects.Santa"
local Obstacle = require "objects.Obstacle"

local Game = {}
Game.__index = Game

function Game.new()
    local self = setmetatable({}, Game)
    
    self.santa = Santa.new()
    self.difficulty = 10
    self.state = {
        menu = true,
        paused = false,
        running = false,
        ended = false
    }
    self.points = 0
    self.levels = {}
    self.highScore = self:loadHighScore()
    
    return self
end

function Game:startNewGame()
    self:changeGameState("running")
    self.obstacles = {}
    self.santa = Santa.new()
    self.santa:setSwapInterval(1)

    for i = 1, self.difficulty do
        table.insert(self.obstacles, Obstacle.new())
    end

    self.points = 0
end

function Game:changeGameState(state)
    self.state["menu"] = state == "menu"
    self.state["paused"] = state == "paused"
    self.state["running"] = state == "running"
    self.state["ended"] = state == "ended"
end

function Game:update(dt)
    if self.state.running then
        self.points = self.points + dt
    end
end

function Game:saveHighScore()
    local filePath = "save/highscore.txt"
    local dir = filePath:match("(.*/)")
    if dir and not love.filesystem.getInfo(dir) then
        love.filesystem.createDirectory(dir)
    end
    
    local file = love.filesystem.newFile(filePath, "w")
    if not file then
        print("Error: Unable to create or open file for writing")
        return
    end
    
    file:write(tostring(self.highScore))
    file:close()
end


function Game:loadHighScore()
    local filePath = "save/highscore.txt"
    local dir = filePath:match("(.*/)")

    if dir and not love.filesystem.getInfo(dir) then
        love.filesystem.createDirectory(dir)
        print("Directory created:", dir)
    end
    local fileInfo = love.filesystem.getInfo(filePath)
    if not fileInfo then
        print("File not found:", filePath)
        return 0
    end
    local file, err = love.filesystem.newFile(filePath, "r")
    if not file then
        print("Error opening file:", err)
        return 0
    end
    
    local content = file:read()
    file:close()
    
    local highScore = tonumber(content)
    return highScore or 0
end

function Game:togglePause()
    if self.state.paused then
        self:changeGameState("running")
    else
        self:changeGameState("paused")
    end
end

return Game