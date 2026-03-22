Type = {

    cell = {
        rad = 25,
        speed = 100,
        energy = 40,
        colour = {0, 1, 0},
        metabolism = 30,
        reprothreshold = 150,
        reprocost = 50,
        prey = {"EEK"},
        canInfect = true,
        spawns = "phage"
    },
    phage = {
        rad = 10,
        speed = 150,
        energy = 30,
        colour = {1, 0, 0},
        metabolism = 7.5,
        reprothreshold = 160,
        reprocost = 60,
        prey = {"cell"},
        canInfect = true,
        spawns = "EEK"
    },
    EEK = {
        rad = 5,
        speed = 200,
        energy = 20,
        colour = {0.5, 0, 0.5},
        metabolism = 8,
        reprothreshold = 170,
        reprocost = 70,
        prey = {"phage"},
        canInfect = true,
        spawns = "cell"
    },
    ORiginalGANGSTER = {
        rad = 10,
        speed = 300,
        energy = 10,
        colour = {0.5, 0.5, 0.5},
        metabolism = 2,
        reprothreshold = 200,
        reprocost = 100,
        prey = {"cell", "phage", "EEK"},
        canInfect = true,
        spawns = nil
    }
}

return Type