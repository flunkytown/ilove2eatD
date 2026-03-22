local Infect = {}

Repro = require "Cfunc.Repro"

local MAX_CREATURES = 300

function lerp(a, b, t) return a + (b - a) * t end

function Infect.tryInfect(host, creatures)

    local chance = 0.3
    if host.type == "ORiginalGANGSTER" then
        chance = 0.15
    end

    for _, other in ipairs(creatures) do
        if Feeding.canEat(host, other)
        and not other.infected
        and not other.dead
        and intersects(host, other) 
        and math.random() < chance then
            other.infected = {
                timer = 0,
                infectorType = host.type,
                startColour = { other.colour[1], other.colour[2], other.colour[3] },
                targetColour = { host.colour[1], host.colour[2], host.colour[3] }
            }
            host.energy = host.energy + 15
            host.fullTimer = 1.5
            other.infectLerpTime = 0

            
            break
        end
    end
end


function Infect.updInfection(host, dt, creatures, class)
    host.infected.timer = host.infected.timer + dt
    host.infectLerpTime = host.infectLerpTime + dt

    local t = math.min(host.infectLerpTime / 2, 1)
    local start = host.infected.startColour
    local target = host.infected.targetColour




    host.colour[1] = lerp(start[1], target[1], t)
    host.colour[2] = lerp(start[2], target[2], t)
    host.colour[3] = lerp(start[3], target[3], t)

    if host.infected.timer >= 2.5 then
    host.dead = true

        local infector = host.infected.infectorType
        local spawnType = Type[infector].spawns

        if spawnType then

            local density = #creatures / MAX_CREATURES

            if math.random() > density then
                local amount = math.random(1,2)

                for i = 1, amount do
                    if #creatures >= MAX_CREATURES then break end

                    local child = class(
                        spawnType,
                        host.x + math.random(-10,10),
                        host.y + math.random(-10,10)
                    )
                    table.insert(creatures, child)
                end
            end
        end
    end
end

return Infect