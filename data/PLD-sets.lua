local setsUtil = {}

setsUtil.apply = function(sets)
sets.idle = {
ammo = "Staunch Tathlum +1",
head = "Souv. Schaller +1",
neck = "Kgt. Beads +2",
ear1 = "Thureous Earring",
ear2 = "Odnowa Earring +1",
body = "Rev. Surcoat +3",
hands = "Cab. Gauntlets +3",
ring1 = "Defending Ring",
ring2 = "Moonlight Ring",
back = { name = "Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','Enmity+10','Spell interruption rate down-10%',}},
waist = "Flume Belt +1",
legs = "Souv. Diechlings +1",
feet = "Rev. Leggings +3"
}
sets.precast = {}
sets.midcast = {}
sets.precast.WS = {}
sets.precast.JA = {}
sets.precast.JA['Shield Bash'] = {}
sets.precast.JA.Cover = {}
sets.precast.WS['Chant du Cygne'] = {}
sets.precast.WS.Atonement = {}
sets.precast.WS['Savage Blade'] = {}
sets.precast.FC = {
ammo = "Impatiens",
head = { name = "Odyssean Helm", augments={'"Mag.Atk.Bns."+8','"Fast Cast"+6',}},
neck = "Voltsurge Torque",
ear1 = "Nourish. Earring +1",
ear2 = "Odnowa Earring +1",
body = "Rev. Surcoat +3",
hands = { name = "Odyssean Gauntlets", augments={'"Fast Cast"+6','AGI+2','"Mag.Atk.Bns."+7',}},
ring1 = "Kishar Ring",
ring2 = "Moonlight Ring",
back = { name = "Rudianos's Mantle", augments={'"Fast Cast"+10',}},
waist = "Flume Belt +1",
legs = { name = "Odyssean Cuisses", augments={'"Fast Cast"+5','VIT+3','"Mag.Atk.Bns."+13',}},
feet = { name = "Odyssean Greaves", augments={'"Mag.Atk.Bns."+15','"Fast Cast"+5','VIT+1',}}
}
sets.engaged = {}
sets.engaged.Enmity = {
ammo = "Sapience Orb",
head = "Loess Barbuta +1",
neck = "Kgt. Beads +2",
ear1 = "Trux Earring",
ear2 = "Odnowa Earring +1",
body = "Souveran Cuirass",
hands = "Cab. Gauntlets +3",
ring1 = "Apeile Ring",
ring2 = "Apeile Ring +1",
back = { name = "Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','Enmity+10','Spell interruption rate down-10%',}},
waist = "Creed Baudrier",
legs = "Souv. Diechlings +1",
feet = "Cab. Leggings +3"
}
return sets
end

return setsUtil
