local love = require "love"
local Santa = require "objects.Santa"
local Obstacle = require "objects.Obstacle"

local Game = {}
Game.__index = Game

function Game.new()
    local self = setmetatable({}, Game)

    self.difficulty = 10
    self.state = {
        menu = true,
        paused = false,
        running = false,
        ended = false
    }
    self.points = 0
    self.levels = {}
    self.santa = Santa.new()
    self.obstacles = {}

    return self
end

function Game:changeGameState(state)
    self.state["menu"] = state == "menu"
    self.state["paused"] = state == "paused"
    self.state["running"] = state == "running"
    self.state["ended"] = state == "ended"
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

function Game:update(dt)
    self.santa:update(dt)
    if self.state.running then
        self.points = self.points + dt
    end
end

return Game