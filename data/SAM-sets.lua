local setsUtil = {}

setsUtil.apply = function(sets)
sets.idle = {
neck = "Loricate Torque +1",
ear2 = "Infused Earring",
ring2 = "Karieyh Ring",
feet = "Danzo Sune-Ate"
}
sets.precast = {}
sets.precast.JA = {}
sets.precast.JA.Hasso = {
hands = "Wakido Kote +2"
}
sets.precast.JA.Meditate = {
back = "Smertrios's Mantle"
}
sets.precast.WS = {
ammo = "Knobkierrie",
head = "Valorous Mask",
neck = "Fotia Gorget",
ear1 = "Ishvara Earring",
ear2 = "Digni. Earring",
body = "Sakonji Domaru +3",
hands = "Valorous Mitts",
ring1 = "Apate Ring",
ring2 = "Karieyh Ring",
back = "Smertrios's Mantle",
waist = "Fotia Belt",
legs = "Wakido Haidate +3",
feet = "Valorous Greaves"
}
sets.midcast = {}
sets.engaged = {
ammo = "Ginsen",
head = "Flam. Zucchetto +2",
neck = "Ganesha's Mala",
ear1 = "Cessance Earring",
ear2 = "Digni. Earring",
body = "Ken. Samue +1",
hands = "Wakido Kote +2",
ring1 = "Niqmaddu Ring",
ring2 = "Flamma Ring",
back = "Sokolski Mantle",
waist = "Ioskeha Belt +1",
legs = "Ken. Hakama +1",
feet = "Flam. Gambieras +2"
}
sets.TreasureHunter = {
head = "Wh. Rarab Cap +1"
}
return sets
end

return setsUtil
