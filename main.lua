--heh... this is where the magic happens

function love.load()
    Object = require "classic"
    require "creature"

    
    love.window.setMode(1920, 1080, {display = 2})
    love.window.setFullscreen(true)

    creatures = {}

    --herbivores
    for i = 1, 72 do
        table.insert(creatures, Creature(love.math.random(0, love.graphics.getWidth()), love.math.random(0, love.graphics.getHeight()), "LFaLmHsHeMf"))
    end
    --carnivores
    for i = 1, 72 do
        table.insert(creatures, Creature(love.math.random(0, love.graphics.getWidth()), love.math.random(0, love.graphics.getHeight()), "SSkMmLsCaMf"))
    end
    --omnivores
    for i = 1, 18 do
        table.insert(creatures, Creature(love.math.random(0, love.graphics.getWidth()), love.math.random(0, love.graphics.getHeight()), "MMaHmMsOmMf"))
    end
    --plants
    for i = 1, 72 do
        table.insert(creatures, Creature(love.math.random(0, love.graphics.getWidth()), love.math.random(0, love.graphics.getHeight()), "LFaLmIdNoPhPf"))
    end
    --weirdos
    for i = 1, 3 do
        table.insert(creatures, Creature(love.math.random(0, love.graphics.getWidth()), love.math.random(0, love.graphics.getHeight())))
    end
    
    --imagez
    caphoto = love.graphics.newImage("CaPhotovore.png")
    noncaphoto = love.graphics.newImage("NonCaPhotovore.png")
end

function love.update(dt)

    for i = #creatures, 1, -1 do
        local creature = creatures[i]

        creature:update(dt, creatures)

        if creature.dead then
            table.remove(creatures, i)
        end
        if i >= 300 then
            table.remove(creatures, i)
        end
    end

    if love.math.random() < 0.1 then

    table.insert(
        creatures,

        Creature(
            love.math.random(
                0,
                love.graphics.getWidth()
            ),

            love.math.random(
                0,
                love.graphics.getHeight()
            ),

            "LFaLmIdNoPhPf"
        )
    )
end

end

function love.draw()
    --draw the guy
    love.graphics.setColor(1,1,1)
    for i = 1, #creatures do
        local creature = creatures[i]
        love.graphics.setColor(creature.colour) 
        if creature.speed == 0 then
            if creature.type == "carnivore" then
                love.graphics.draw(caphoto, creature.x, creature.y, creature.size)
            else
                love.graphics.draw(noncaphoto, creature.x, creature.y, creature.size)
            end
        else
            love.graphics.circle("fill", creature.x, creature.y, 10 * creature.size)
        end
        --love.graphics.print("DNA: " .. creature.myDNA, creature.x, creature.y + 60)
        --love.graphics.print("energy: " .. creature.energy, creature.x, creature.y + 30)
        --love.graphics.line(creature.x, creature.y, creature.targetX, creature.targetY)
    end
end
