--[[
    GD50 2018
    Pong Remake

    -- Paddle Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Represents a paddle that can move up and down. Used in the main
    program to deflect the ball back toward the opponent.
]]

Paddle = Class{}

--[[
    The `init` function on our class is called just once, when the object
    is first created. Used to set up all variables in the class and get it
    ready for use.

    Our Paddle should take an X and a Y, for positioning, as well as a width
    and height for its dimensions.

    Note that `self` is a reference to *this* object, whichever object is
    instantiated at the time this function is called. Different objects can
    have their own x, y, width, and height values, thus serving as containers
    for data. In this sense, they're very similar to structs in C.
]]
function Paddle:init(x, y, width, height, velocity, is_ai)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.dy = 0
    self.velocity = velocity
    self.is_ai = is_ai
end

function Paddle:update(dt)
    if self.is_ai then
        if self.y > ball.y then
            self.y = self.y - math.min(math.abs(self.y - ball.y), self.velocity * dt)
        elseif self.y < ball.y then
            self.y = self.y + math.min(math.abs(self.y - ball.y), self.velocity * dt)
        end
    else
        if love.keyboard.isDown('w') then
            self.dy = -1
        elseif love.keyboard.isDown('s') then
            self.dy = 1
        else
            self.dy = 0
        end
        self.y = self.y + self.dy * self.velocity * dt
    end

    self.y = math.max(0, math.min(VIRTUAL_HEIGHT - self.height, self.y))
end

--[[
    To be called by our main function in `love.draw`, ideally. Uses
    LÖVE2D's `rectangle` function, which takes in a draw mode as the first
    argument as well as the position and dimensions for the rectangle. To
    change the color, one must call `love.graphics.setColor`. As of the
    newest version of LÖVE2D, you can even draw rounded rectangles!
]]
function Paddle:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
