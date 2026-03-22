local Infect = {}

Repro = require "Cfunc.Repro"

function lerp(a, b, t) return a + (b - a) * t end

function Infect.tryInfect(host, creatures)
    for _, other in ipairs(creatures) do
        if Feeding.canEat(host, other)
        and not other.infected
        and not other.dead
        and intersects(host, other) then
            other.infected = {
                timer = 0,
                startColour = { other.colour[1], other.colour[2], other.colour[3] },
                targetColour = { host.colour[1], host.colour[2], host.colour[3] }
            }
            other.infectLerpTime = 0

            host.energy = host.energy + 5
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

    if host.infected.timer >= 2 then
    host.dead = true

        local spawnType = Type[host.type].spawns
        if spawnType then
            for i = 1, math.random(2,4) do
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

return Infect