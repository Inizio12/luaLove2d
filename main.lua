local love = require "love"
local Santa = require "Santa"
local Obstacle = require "Obstacle"

local santa = Santa.new()
local obstacles = {}

local game = {
    difficulty = 10,
    state = {
        menu = true,
        paused = false,
        running = false,
        ended = false
    },
    points = 0,
    levels = {}
}

local fonts = {
    medium = {
        font = love.graphics.newFont(16),
        size = 16
    },
    large = {
        font = love.graphics.newFont(24),
        size = 24
    },
    massive = {
        font = love.graphics.newFont(60),
        size = 60
    }
}

local function changeGameState(state)
    game.state["menu"] = state == "menu"
    game.state["paused"] = state == "paused"
    game.state["running"] = state == "running"
    game.state["ended"] = state == "ended"
end

local function startNewGame()
    changeGameState("running")
    obstacles = {}
    santa = Santa.new()
    santa:setSwapInterval(1)

    for i = 1, game.difficulty do
        table.insert(obstacles, Obstacle.new())
    end

    game.points = 0

end

function love.load()
    math.randomseed(os.time())
    love.mouse.setVisible(false)
    love.graphics.setBackgroundColor(225 / 255, 245 / 255, 244 / 255)

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

    startNewGame()
end

function love.update(dt)
    if game.state["running"] then
        santa:update(dt)
        for _, obstacle in ipairs(obstacles) do
            obstacle:update(dt)
        end
        for i = 1, #obstacles do
            if obstacles[i]:checkTouched(santa) then
               changeGameState("ended")
            end
        end
    end
end

function love.draw()
    if true then
        santa:draw()
        for _, obstacle in ipairs(obstacles) do
            obstacle:draw()
        end
    end
end