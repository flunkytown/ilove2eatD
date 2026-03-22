math.randomseed(os.time())
math.random()

function love.load()

    --load required stuff
    require "Cfunc.Movement"
    require "Cfunc.Repro"
    require "creature"
    require "Type"

    --what do i bring to the table when i am the table
    --i am the table and i have a lot of energy and i can reproduce and i can move around and i can eat other creatures and i can infect other creatures and i can be infected and i can die and i can spawn new creatures when i die and i can be a phage and i can be a cell and i can be an eekling and i can be an original gangster and i can be a third class man
    --that second comment ^ was made by copilot idk what the fuck its doing i just hit tab lol

    creatures = {}

    --make some creatures 2 start

    MAX_CREATURES = 300

    for i = 1, 80 do
        table.insert(creatures, creature("EEK", math.random(10, 500), math.random(10, 500)))
    end

    for i = 1, 40 do
        table.insert(creatures, creature("cell", math.random(10, 500), math.random(10, 500)))
    end

    for i = 1, 20 do
        table.insert(creatures, creature("phage", math.random(10, 500), math.random(10, 500)))
    end
    
    for i = 1,3 do
        table.insert(creatures, creature("ORiginalGANGSTER", math.random(10, 500), math.random(10, 500)))
    end
                                                                                                                        --le old fashioned way
end

function flooritpunk(n) 
    return math.floor(n + 0.5)
end


function love.update(dt)
    for _, c in ipairs(creatures) do
        c:update(dt, creatures)
    end

    for i = #creatures, 1, -1 do
        if creatures[i].dead then
            table.remove(creatures, i)
        end
    end
end

function love.draw()

    --draw creatures11111!!!!!!!!!

    for _, c in ipairs(creatures) do
        love.graphics.setColor(c.colour)
        love.graphics.circle("fill", c.x, c.y, c.rad)
    end

    --third class man
    --pick up extemely venomous scorpions for me
    --i will give you 3 dollars

    local cellCount = 0
    local phageCount = 0
    local eekCount = 0

    for _, c in ipairs(creatures) do
        if c.type == "cell" then
            cellCount = cellCount + 1
        end
    end
    for _, p in ipairs(creatures) do
        if p.type == "phage" then
            phageCount = phageCount + 1
        end
    end
    for _, e in ipairs(creatures) do
        if e.type == "EEK" then
            eekCount = eekCount + 1
        end
    end

    love.graphics.setColor(1,1,1)

    --love.graphics.print("Cells: " .. cellCount, 10, 10)
    --love.graphics.print("Phages: " .. phageCount, 10, 30)
    --love.graphics.print("eeklings: " .. eekCount, 10, 50)

    for _, c in ipairs(creatures) do
        energay = c.energy
        Xpositiongay = c.x
        Ypositiongayorwhateveridontevenknowanymoreman = c.y
        love.graphics.print("Energy:" .. flooritpunk(energay), Xpositiongay - c.rad - 5, Ypositiongayorwhateveridontevenknowanymoreman + c.rad)
    end

    --what is a camelcase also i should fix my capitalisation to be more unified but that sounds like a bastard to do

end