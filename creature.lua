Object = require "classic"
Movement = require "Cfunc.Movement"
Infect = require "Cfunc.Infect"
Repro = require "Cfunc.Repro"
Target = require "Cfunc.Target"
Feeding = require "Cfunc.Feeding"
require "Type"


creature = Object:extend()

function creature:new(type, x, y)
    local t = Type[type]
    assert(t, "Unknown creature type: " .. tostring(type))

    self.type = type
    self.x = x
    self.y = y
    self.wanderAngle = math.random() * math.pi * 2
    self.reproCooldown = 0
    self.currentTime = 0
    self.duration = 0

    self.metabolism = t.metabolism
    self.rad = t.rad
    self.speed = t.speed
    self.colour = { t.colour[1], t.colour[2], t.colour[3] }
    self.energy = t.energy

    self.reproThreshold = t.reprothreshold
    self.reproCost = t.reprocost
    self.vx = 0
    self.vy = 0
    self.maxSpeed = t.speed
    self.acceleration = 200  -- pixels per second 🥕 2
    

end

creature.checkEat = Feeding.checkEat
creature.canEat = Feeding.canEat

function creature:update(dt, creatures)
    self:updEnergy(dt)
    if self.dead then return end

    Target.updTarget(self, creatures, dt)
    Movement.updMovement(self, creatures, dt)

    if Type[self.type].canInfect then
        Infect.tryInfect(self, creatures)
    else
        Feeding.checkEat(self, creatures)
    end

    if self.infected then
        Infect.updInfection(self, dt, creatures,creature)
    end

end

function intersects(a, b)
    local dx = a.x - b.x
    local dy = a.y - b.y
    local r = a.rad + b.rad
    return dx*dx + dy*dy <= r*r
end

function creature:updEnergy(dt)
    if self.infected then return end

    self.energy = self.energy - self.metabolism * dt
    if self.energy <= 0 then
        self.dead = true
    end
end


--twavis its kiww aw be kiwwed!!
-- no maw hewoes it  kiww aw be kiwwed something something noting ewse to do

function creature:nearestPrey(creatures)
    local nearest, bestDist = nil, math.huge

    for _, other in ipairs(creatures) do
        if other ~= self and self:canEat(other) then
            local dx = other.x - self.x
            local dy = other.y - self.y
            local d = dx*dx + dy*dy
            if d < bestDist then
                bestDist = d
                nearest = other
            end
        end
    end

    return nearest
end

function creature:nearestPredator(creatures)
    local nearest, bestDist = nil, math.huge

    for _, other in ipairs(creatures) do
        if other ~= self and other:canEat(self) then
            local dx = other.x - self.x
            local dy = other.y - self.y
            local d = dx*dx + dy*dy
            if d < bestDist then
                bestDist = d
                nearest = other
            end
        end
    end

    return nearest
end

--stop hanging djs bro 
--its real bad
--uh
--good joke?
--destroyman fight theme reference
--haha