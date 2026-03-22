local Repro = {}


function Repro.tryReproduce(host, Class)
    if host.energy >= host.reproThreshold then
        host.energy = host.energy - host.reproCost
        return Class(
            host.type,
            host.x + math.random(-10,10),
            host.y + math.random(-10,10)
        )
    end
end

return Repro