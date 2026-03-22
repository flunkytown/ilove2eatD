local Movement = {}

function Movement.accelerateToward(host, tx, ty, dt)
    local dx = tx - host.x
    local dy = ty - host.y
    local dist = math.sqrt(dx*dx + dy*dy)
    if dist == 0 then return end

    dx, dy = dx / dist, dy / dist

    host.vx = host.vx + dx * host.acceleration * dt
    host.vy = host.vy + dy * host.acceleration * dt
end

function Movement.chase(host, target, dt)
    Movement.accelerateToward(host, target.x, target.y, dt)
end

function Movement.flee(host, predator, dt)
    local dx = creature.x - predator.x
    local dy = creature.y - predator.y

    local dist = math.sqrt(dx*dx + dy*dy)
    if dist == 0 then return end

    dx, dy = dx / dist, dy / dist

    local angle = math.atan2(dy, dx)
    angle = angle + (math.random() - 0.5) * 0.8 

    local tx = creature.x + math.cos(angle) * 50
    local ty = creature.y + math.sin(angle) * 50

    Movement.accelerateToward(tx, ty, dt, creature)
end

function Movement.wander(host, dt)
    host.wanderAngle = host.wanderAngle + (math.random() - 0.5) * 1.2
    local tx = host.x + math.cos(host.wanderAngle)
    local ty = host.y + math.sin(host.wanderAngle)
    Movement.accelerateToward(host, tx, ty, dt)
end

function Movement.applyVelocity(host, dt)
    local speed = math.sqrt(host.vx^2 + host.vy^2)
    if speed > host.maxSpeed then
        host.vx = host.vx / speed * host.maxSpeed
        host.vy = host.vy / speed * host.maxSpeed
    end

    host.x = host.x + host.vx * dt
    host.y = host.y + host.vy * dt
end

function Movement.keepInBounds(host, width, height)
    local margin = 30      
    local force = host.acceleration * 1.2

    if host.x < margin then
        host.vx = host.vx + force
    elseif host.x > width - margin then
        host.vx = host.vx - force
    end

    if host.y < margin then
        host.vy = host.vy + force
    elseif host.y > height - margin then
        host.vy = host.vy - force
    end
end

function Movement.updMovement(host, creatures, dt)
    local predator = creature:nearestPredator(creatures)

    if predator then
        Movement.flee(host, predator, dt)
    elseif host.target then
        Movement.chase(host, host.target, dt)
    else
        Movement.wander(host, dt)
    end

    Movement.applyVelocity(host, dt)
    Movement.keepInBounds(host, love.graphics.getWidth(), love.graphics.getHeight())

end


return Movement


--duUDE i generated like all of this script with ai #neveragain iunno what the fuck is going on lmao