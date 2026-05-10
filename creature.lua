--creature stuff this is the brain of every creature
Object = require "classic"
typedata = require "type"

function generateDNA()
    local str = ""
    for _, group in pairs(Keys) do
        str = str .. group[love.math.random(1,#group)]
    end 
    return str
end

Creature = Object:extend()

function Creature:awesomestringdivder(input)
    for segment in input:gmatch("%u%l*") do

        local traitDATA = DNA[segment] 

        if traitDATA then
            for statName, value in pairs(traitDATA) do
                self[statName] = value
            end
        end
    end
end

function Creature:wander(dt)

    local dx = self.x - self.targetX
    local dy = self.y - self.targetY

    local dist = math.sqrt(dx * dx + dy * dy)

    if dist <= 5 then
        self.targetX = love.math.random(0, love.graphics.getWidth())
        self.targetY = love.math.random(0, love.graphics.getHeight())
    else
        self:moveTowards(self.targetX, self.targetY, self.speed * dt)
    end

end

function Creature:moveTowards(tx, ty, speed)

    local dx = tx - self.x
    local dy = ty - self.y

    local distance = math.sqrt(dx * dx + dy * dy)

    if distance >= 5 then
        local nx = dx / distance
        local ny = dy / distance
        self.x = self.x + nx * speed
        self.y = self.y + ny * speed
    end

    self.energy = self.energy - (speed * 0.01) - self.metabolism * 0.05

end

function Creature:findClosestPrey(creatures, dt)

    local closest = nil
    local closestDistance = math.huge

    for _, other in pairs(creatures) do

        if other ~= self
        and self:canEat(other)
        then

            local dx = other.x - self.x
            local dy = other.y - self.y

            local dist = math.sqrt(dx * dx + dy * dy)

            if dist < closestDistance then
                closestDistance = dist
                closest = other
            end
        end
    end

    if closest then

        self.targetX = closest.x
        self.targetY = closest.y

        self:moveTowards(
            closest.x,
            closest.y,
            self.speed * dt
        )

        if closestDistance < 10 then

            self.energy = math.min(
            self.energy + closest.energy,
            self.maxEnergy * 1.5
        )
            closest.dead = true
        end

    else

        self:wander(dt)
    end
end

function Creature:findClosestPredator(creatures)

    local closest = nil
    local closestDistance = math.huge

    for _, other in pairs(creatures) do

        if other ~= self
        and other:canEat(self)
        and self:canEat(other) == false
        then

            local dx = other.x - self.x
            local dy = other.y - self.y

            local dist = math.sqrt(dx * dx + dy * dy)

            if dist < closestDistance then
                closestDistance = dist
                closest = other
            end
        end
    end

    return closest, closestDistance
end

function Creature:fleeFrom(predator, dt)

    local dx = self.x - predator.x
    local dy = self.y - predator.y

    local distance = math.sqrt(dx * dx + dy * dy)

    if distance > 0 then

        local nx = dx / distance
        local ny = dy / distance

        self.x = self.x + nx * self.speed * dt
        self.y = self.y + ny * self.speed * dt

        self.energy = self.energy - self.metabolism
    end
end

function Creature:canEat(target)

    if self.type == "herbivore" then
        return target.flesh == "plant"

    elseif self.type == "carnivore" then
        return target.flesh == "meat"

    elseif self.type == "omnivore" then
        return true
    end

    return false
end

function mutateDNA(dna)

    local segments = {}

    for segment in dna:gmatch("%u%l*") do
        table.insert(segments, segment)
    end

    local mutationCount = love.math.random(1, 4)

    for i = 1, mutationCount do

        local categoryKeys = {}

        for k in pairs(Keys) do
            table.insert(categoryKeys, k)
        end

        local randomCategory =
            categoryKeys[
                love.math.random(#categoryKeys)
            ]

        local options = Keys[randomCategory]

        local randomGene =
            options[
                love.math.random(#options)
            ]

        local replaceIndex =
            love.math.random(#segments)

        segments[replaceIndex] = randomGene
    end

    return table.concat(segments)
end

function Creature:reproduce(creatures)

    local childDNA =
        mutateDNA(self.myDNA)

    local child = Creature(
        self.x + love.math.random(-20,20),
        self.y + love.math.random(-20,20),
        childDNA
    )

    table.insert(creatures, child)

    self.energy = self.energy * 0.7
end

function Creature:new(x, y, dna)
    self.x = x or 100
    self.y = y or 100
    self.colour = {1,1,1}
    self.size = 1
    self.metabolism = 1
    self.speed = 1
    self.maxEnergy = 100
    
    self.targetX = love.math.random(0, love.graphics.getWidth())
    self.targetY = love.math.random(0, love.graphics.getHeight())

    self.myDNA = dna or generateDNA()
    self:awesomestringdivder(self.myDNA)

    if self.type == "photovore" then
        self.flesh = "plant"
    else
        self.flesh = "meat"
    end

    self.energy = self.maxEnergy or 100

end

function Creature:update(dt, creatures)

    if self.energy <= 0 then
        self.dead = true
        return
    end
    if self.energy >= self.maxEnergy * 1.1 then
        self:reproduce(creatures)
    end

    local predator, predatorDistance =
        self:findClosestPredator(creatures)

    if predator and predatorDistance < 120 then

        self:fleeFrom(predator, dt)

    elseif self.energy <= self.maxEnergy / 2 then

        self:findClosestPrey(creatures, dt)

    else

        self:wander(dt)

    end
    if self.type == "photovore" then
    self.energy = self.energy + 0.1

        if self.energy >= self.maxEnergy * 1.5 then
            self:reproduce(creatures)
        end

        return
    end
end