local Feeding = {}

function Feeding.checkEat(creature, creatures)
    if creature.type == "phage" then return end

    for i = #creatures, 1, -1 do
        local other = creatures[i]
        if other ~= creature
        and not other.dead
        and Feeding.canEat(creature, other)
        and intersects(creature, other) then

            creature.energy = creature.energy + other.energy
            other.dead = true
            return
        end
    end
end

function Feeding.canEat(creature, other)
    for _, ptype in ipairs(Type[creature.type].prey) do
        if other.type == ptype then
            return true
        end
    end
    return false
end

return Feeding