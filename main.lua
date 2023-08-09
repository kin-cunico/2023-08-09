_G.push = require "push"

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 520
VIRTUAL_HEIGHT = 288

local background = love.graphics.newImage("assets/background.png")
-- 6432x3000
local backgroundScroll = 0
local BACKGROUND_SCROLL_SPEED = 30
local BACKGROUND_LOOPING_POINT = 413

local planet = love.graphics.newImage("assets/ground.png")
local planetScroll = 0
local PLANET_SCROLL_SPEED = 60




local mainCharacter = love.graphics.newImage("assets/PNG_Parts&Spriter_Animation/Ship2/Ship2.png")


function love.load()
    -- avoid blurring of text and images
    love.graphics.setDefaultFilter("nearest", "nearest")

    love.window.setTitle("Space Avoider")

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })
end
    -- dynamically rescaling the canvas internally to fit our virtual resolution
function love.resize(w, h)
    push:resize(w, h)
end

    -- keyboard handling events
function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end

    if key == "enter" or key == "return" then
        push:switchFullscreen()
    end
end

-- update function
function love.update(dt)
    -- itself + speed * dt (delta time) % looping point (width of image)
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT

    -- planetscroll is faster than backgroundscroll for parallax effect but with virtual width
    planetScroll = (planetScroll + PLANET_SCROLL_SPEED * dt) % VIRTUAL_WIDTH

end



    -- drawing function with push applied
function love.draw()
    push:start()
    -- images can be draw
    -- draw takes an image, x and y coordinates
    love.graphics.draw(background, -backgroundScroll, 0)
    love.graphics.draw(planet, -planetScroll, VIRTUAL_HEIGHT - 16)
    love.graphics.scale(0.5)
    love.graphics.draw(mainCharacter, 400, 200)

    push:finish()
end