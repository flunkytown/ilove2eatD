--the information about the creatures such as their size, metabolism, et cetera is here and is to be used by creature.lua
--spitballing idea,, the creature's type is determined via a small string of "DNA" that reflects the behaviour & traits
--e.g "LHeDApHm" is a Large Herbivore that is Docile, but aggressive when provoked. It has a High Metabolism.
--in each string any following lowercase letter is related in some way to the preceding uppercase letter. E.g "He" = Herbivore, while "Hm" = High Metabolism. The uppercase letters are the main traits, while the lowercase letters are modifiers that further specify the trait &/or further seperate to reduce confusion.
DNA = {
    ---PHYSICAL ATTRIBUTES---
    --important--
    L = {size = 2},
    M = {size = 1},
    S = {size = 0.5},
    Fa = {maxEnergy = 100}, 
    Ma = {maxEnergy = 50},
    Sk = {maxEnergy = 25}, 
    Hm = {metabolism = 2}, -- me when im FAMISHED!!!! pARCHED even!!! #waterdrinkerzunite
    Mm = {metabolism = 1},
    Lm = {metabolism = 0.5},
    Hs = {speed = 200},
    Ms = {speed = 100},
    Ls = {speed = 50},
    Id = {speed = 0}, --PLANT MAN!!!
    ---BEHAVIORAL ATTRIBUTES---
    --eat--
    He = {type = "herbivore",
        colour = {0,1,0}},
    Ca = {type = "carnivore",
        colour = {1,0,0}},
    Om = {type = "omnivore",
        colour = {0,1,1}},
    Ph = {type = "photovore",
        colour = {1,1,1}}, 
    --social-- UNUSED :(
    --Do = {behaviour = "docile"}, -- nice little chud
    --Ag = {behaviour = "aggressive"}, -- attacks everythang.
    --Ap = {behaviour = "aggressive-provoked"}, --Will be docile but when a predator is near it will start to attack
    --Co = {behaviour = "cowardly"}, -- runs away from everything
    --Hr = {behaviour = "herd"}, -- will stay with other non predator/prey creatures that are Do, Ap, Cp, or Hr
    --special slash miscellaneous i dont know--
    Pf = {flesh = "plant"}, --planty flesh and
    Mf = {flesh = "meat"}, --meaty flesh.
    --other ideas:: tough skin, poisonous, camo, glow, flying, burrowing, parasitic, venomous, cannibalistic, maybe aquatic if i add water.
}

Keys = {
    size = {"L", "M", "S"},
    hunger = {"Fa", "Ma", "Sk"},
    metabolism = {"Hm", "Mm", "Lm"},
    diet = {"He", "Ca", "Om", "Ph"},
    flesh = {"Pf", "Mf"},
    speed = {"Hs", "Ms", "Ls","Id"},
    --behaviour = {"Do", "Ag", "Ap", "Co", "Hr"}
} --keys is for random generator


--maybe these could be the main traits but then theres like "Co" for colour and "Sh" for shape (everyone is a damned trongle!!!)
--maybe also give them herd things. "Hr" 4 herd or "So" 4 solitary