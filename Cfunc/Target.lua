local Target = {}


function Target.updTarget(host, creatures, dt)
    host.ChaseCooldown = (host.ChaseCooldown or 0) - dt
    if host.ChaseCooldown > 0 then return end

    if host.energy < 0.8 * Type[host.type].energy then
        host.target = host:nearestPrey(creatures)
        host.ChaseCooldown = 0.5
    else
        host.target = nil
    end

end


return Target