local setsUtil = {}

setsUtil.apply = function(sets)
sets.idle = {
ammo = "Amar Cluster",
head = "Aya. Zucchetto +1",
neck = "Loricate Torque +1",
ear2 = "Infused Earring",
body = "Jhakri Robe +2",
hands = "Aya. Manopolas +2",
ring1 = "Ayanmo Ring",
ring2 = "Stikini Ring +1",
back = "Solemnity Cape",
waist = "Fucho-no-Obi",
legs = "Carmine Cuisses +1",
feet = "Aya. Gambieras +1"
}
sets.precast = {}
sets.midcast = {
ammo = "Pemphredo Tathlum",
head = "Jhakri Coronal +1",
neck = "Sanctity Necklace",
ear1 = "Digni. Earring",
ear2 = "Friomisi Earring",
body = "Jhakri Robe +2",
hands = "Jhakri Cuffs +2",
ring1 = "Strendu Ring",
ring2 = "Stikini Ring +1",
back = "Izdubar Mantle",
waist = "Eschan Stone",
legs = "Jhakri Slops +1",
feet = "Jhakri Pigaches +1"
}
sets.engaged = {
ammo = "Ginsen",
head = "Adhemar Bonnet +1",
ear1 = "Digni. Earring",
ear2 = "Cessance Earring",
hands = "Adhemar Wrist. +1",
waist = "Hurch'lan Sash",
legs = "Aya. Cosciales +2"
}
sets.precast.FC = {
ammo = "Sapience Orb",
neck = "Baetyl Pendant",
ear1 = "Loquac. Earring",
body = "Jhakri Robe +2",
hands = "Jhakri Cuffs +2",
ring1 = "Kishar Ring",
waist = "Hurch'lan Sash",
legs = "Aya. Cosciales +2",
feet = "Jhakri Pigaches +2"
}
sets.precast.WS = {
neck = "Fotia Gorget",
hands = "Jhakri Cuffs +2",
waist = "Fotia Belt"
}
sets.idle.DT = {
head = "Aya. Zucchetto +1",
neck = "Loricate Torque +1",
ear2 = "Infused Earring",
body = "Ayanmo Corazza +1",
hands = "Aya. Manopolas +2",
ring1 = "Ayanmo Ring",
back = "Solemnity Cape",
legs = "Aya. Cosciales +2",
feet = "Aya. Gambieras +1"
}
return sets
end

return setsUtil
