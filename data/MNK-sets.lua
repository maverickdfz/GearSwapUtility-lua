local setsUtil = {}

setsUtil.apply = function(sets)
sets.idle = {
ammo = "Amar Cluster",
head = "Imp. Wing Hairpin",
neck = "Sanctity Necklace",
ear2 = "Infused Earring",
body = "Emet Harness +1",
hands = "Mummu Wrists +1",
ring2 = "Karieyh Ring",
back = "Canny Cape",
legs = "Mummu Kecks +1",
feet = "Crier's Gaiters"
}
sets.TreasureHunter = {
ammo = "Per. Lucky Egg",
head = "Wh. Rarab Cap +1",
waist = "Chaac Belt"
}
sets.engaged = {
ammo = "Ginsen",
head = "Adhemar Bonnet +1",
neck = "Sanctity Necklace",
ear1 = "Sherida Earring",
ear2 = "Cessance Earring",
hands = "Adhemar Wrist. +1",
ring1 = "Epona's Ring",
ring2 = "Gere Ring",
back = "Sokolski Mantle",
waist = "Hurch'lan Sash",
legs = "Samnuha Tights",
feet = "Mummu Gamash. +1"
}
sets.precast = {}
sets.precast.JA = {}
sets.precast.WS = {
ammo = "Knobkierrie",
neck = "Fotia Gorget",
ear1 = "Sherida Earring",
ear2 = "Odr Earring",
ring2 = "Karieyh Ring",
waist = "Fotia Belt"
}
sets.engaged.DT = {
ammo = "Staunch Tathlum +1",
head = "Mummu Bonnet +1",
neck = "Loricate Torque +1",
ear1 = "Sherida Earring",
ear2 = "Cessance Earring",
body = "Malignance Tabard",
hands = "Malignance Gloves",
ring1 = "Defending Ring",
ring2 = "Fortified Ring",
back = "Solemnity Cape",
waist = "Hurch'lan Sash",
legs = "Mummu Kecks +1",
feet = "Malignance Boots"
}
sets.idle.DT = {
ammo = "Staunch Tathlum +1",
neck = "Loricate Torque +1",
body = "Malignance Tabard",
hands = "Malignance Gloves",
ring1 = "Defending Ring",
ring2 = "Fortified Ring",
back = "Solemnity Cape",
legs = "Mummu Kecks +1",
feet = "Malignance Boots"
}
return sets
end

return setsUtil
