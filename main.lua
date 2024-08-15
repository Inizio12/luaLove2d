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
    game:startNewGame()
end, font)

local retryButton = Button.new("Replay Game", (windowWidth - buttonWidth) / 2, buttonYStart, buttonWidth, buttonHeight, function()
    game:startNewGame()
end, font)

local quitButton = Button.new("Quit Game", (windowWidth - buttonWidth) / 2, buttonYStart + buttonHeight + 10, buttonWidth, buttonHeight, function()
    love.event.quit()
end, font)

local scoreText = Text.new("Score: 0", 10, 10, font, {0, 0, 1})
local highScoreText = Text.new("High Score: " .. game.highScore, 10, 40, font, {0, 0, 1})
local endGameScoreText = Text.new("", (windowWidth - buttonWidth) / 2, buttonYStart - 60, font, {0, 0, 1})

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
    if game.state.running then
        game:update(dt)
        game.santa:update(dt)
        game.santa:moveSanta(dt)
        for _, obstacle in ipairs(game.obstacles) do
            obstacle:update(dt)
        end
        for i = 1, #game.obstacles do
            if game.obstacles[i]:checkTouched(game.santa) then
                game.santa:setState("dead")
                game:changeGameState("ended")
                if game.points > game.highScore then
                    game.highScore = math.floor(game.points)
                    highScoreText:setContent("High Score: " .. game.highScore)
                    game:saveHighScore()
                    endGameScoreText:setContent("HIGH SCORE!: " .. math.floor(game.points))
                else
                    endGameScoreText:setContent("YOUR SCORE: " .. math.floor(game.points))
                end
            end
            if (math.floor(game.points) % 20 == 0 and #game.obstacles < 30) then
                table.insert(game.obstacles, Obstacle.new())
                game.santa:setSwapInterval()
                for j = 1, #game.obstacles do
                    game.obstacles[j]:setObstacleSpeed()
                end
                game.points = game.points + 1
            end
        end
        scoreText:setContent("Score: " .. math.floor(game.points))
    end
end

function love.draw()
    game.santa:draw()
    if game.state.paused then
        local pausedText = Text.new("PAUSED", love.graphics.getWidth() / 2 - 50, love.graphics.getHeight() / 2 - 20, font, {1, 0, 0})
        pausedText:draw()
    end
    if not game.state.menu then
        for _, obstacle in ipairs(game.obstacles) do
            obstacle:draw()
        end
        scoreText:draw()
        highScoreText:draw()
    end
    if game.state.menu then
        startButton:draw()
        quitButton:draw()
    elseif game.state.ended then
        retryButton:draw()
        quitButton:draw()
        endGameScoreText:draw()
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

function love.keypressed(key)
    if not game.state.menu and not game.state.ended then
        if key == "escape" then
            game:togglePause()
        end
    end
end