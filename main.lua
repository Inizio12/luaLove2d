local love = require "love"
local Santa = require "objects.Santa"
local Obstacle = require "objects.Obstacle"
local Game = require "Game"
local Text = require "components.Text"
local Button = require "components.Button"

local game = Game.new()
local font = love.graphics.newFont(24)

local windowWidth, windowHeight = 800, 600
local buttonWidth, buttonHeight = 200, 50
local buttonYStart = windowHeight / 2 - buttonHeight / 2

local startButton = Button.new("Start Game", (windowWidth - buttonWidth) / 2, buttonYStart, buttonWidth, buttonHeight, function()
    game:startNewGame() -- Transition to the running state
end)

local retryButton = Button.new("Retry", (windowWidth - buttonWidth) / 2, buttonYStart, buttonWidth, buttonHeight, function()
    game:startNewGame() -- Restart the game
end)

local quitButton = Button.new("Quit Game", (windowWidth - buttonWidth) / 2, buttonYStart + buttonHeight + 10, buttonWidth, buttonHeight, function()
    love.event.quit()
end)

local scoreText = Text.new("Score: 0", 10, 10, font, {0, 0, 1})

function love.load()
    math.randomseed(os.time())
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
        },
        dead = {
            love.graphics.newImage("Images/santa-fall.png")
        }
    }
    Obstacle.images = {
        love.graphics.newImage("Images/tree.png"),
        love.graphics.newImage("Images/snowman.png")
    }
end

function love.update(dt)
    game:update(dt)
    if game.state["running"] then
        game.santa:moveSanta(dt)
        for _, obstacle in ipairs(game.obstacles) do
            obstacle:update(dt)
        end
        for i = 1, #game.obstacles do
            if game.obstacles[i]:checkTouched(game.santa) then
                game.santa:setState("dead")
                game:changeGameState("ended")
            end
        end
        scoreText:setContent("Score: " .. math.floor(game.points))
    end
end

function love.draw()
    game.santa:draw()
    if not game.state.menu then
        for _, obstacle in ipairs(game.obstacles) do
            obstacle:draw()
        end
        scoreText:draw()
    end

    if game.state.menu then
        startButton:draw()
        quitButton:draw()
    elseif game.state.ended then
        retryButton:draw()
        quitButton:draw()
    elseif game.state.paused then
        local pausedText = Text.new("PAUSED", love.graphics.getWidth() / 2 - 50, love.graphics.getHeight() / 2 - 20, font, {1, 0, 0})
        pausedText:draw()
    end
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        if game.state.menu then
            startButton:update(x, y, true)
            quitButton:update(x, y, true)
        elseif game.state.ended then
            retryButton:update(x, y, true)
            quitButton:update(x, y, true)
        end
    end
end