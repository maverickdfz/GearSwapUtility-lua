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
feet = "Fajin Boots"
}
sets.TreasureHunter = {
head = "Wh. Rarab Cap +1",
hands = "Plun. Armlets +3",
waist = "Chaac Belt",
feet = "Skulk. Poulaines +1"
}
sets.engaged = {
ammo = "Ginsen",
head = "Mummu Bonnet +1",
neck = "Sanctity Necklace",
ear1 = "Sherida Earring",
ear2 = "Cessance Earring",
body = "Pillager's Vest +2",
hands = "Adhemar Wrist. +1",
ring1 = "Epona's Ring",
ring2 = "Gere Ring",
back = "Toutatis's Cape",
waist = "Hurch'lan Sash",
legs = "Mummu Kecks +1",
feet = "Mummu Gamash. +1"
}
sets.precast = {}
sets.precast.JA = {}
sets.precast.WS = {
ammo = "Yetshila +1",
head = "Pill. Bonnet +2",
neck = "Fotia Gorget",
hands = "Meg. Gloves +2",
ring2 = "Karieyh Ring",
back = "Toutatis's Cape",
waist = "Fotia Belt",
legs = "Plun. Culottes +3"
}
sets.engaged.DT = {
ammo = "Staunch Tathlum +1",
head = "Mummu Bonnet +1",
neck = "Loricate Torque +1",
ear1 = "Sherida Earring",
ear2 = "Cessance Earring",
body = "Mummu Jacket +1",
hands = "Adhemar Wrist. +1",
ring1 = "Epona's Ring",
ring2 = "Gere Ring",
back = "Toutatis's Cape",
waist = "Hurch'lan Sash",
legs = "Mummu Kecks +1",
feet = "Mummu Gamash. +1"
}
sets.precast.WS['Rudra\'s Storm'] = {
ammo = "Yetshila +1",
head = "Pill. Bonnet +2",
neck = "Fotia Gorget",
hands = "Meg. Gloves +2",
ring2 = "Karieyh Ring",
back = "Toutatis's Cape",
waist = "Fotia Belt",
legs = "Plun. Culottes +3"
}
sets.idle.DT = {
ammo = "Staunch Tathlum +1",
neck = "Loricate Torque +1",
legs = "Mummu Kecks +1"
}
return sets
end

return setsUtil
