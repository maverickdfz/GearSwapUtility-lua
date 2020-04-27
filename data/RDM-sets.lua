local setsUtil = {}

setsUtil.apply = function(sets)
sets.idle = {
ammo = "Homiliary",
head = "Vitiation Chapeau",
ear2 = "Infused Earring",
body = "Jhakri Robe +2",
hands = "Serpentes Cuffs",
back = "Kumbira Cape",
feet = "Serpentes Sabots"
}
sets.idle.DT = {
main = "Terra's Staff",
ammo = "Homiliary",
head = "Vitiation Chapeau",
neck = "Twilight Torque",
ear2 = "Infused Earring",
body = "Jhakri Robe +2",
hands = "Serpentes Cuffs",
back = "Kumbira Cape",
feet = "Serpentes Sabots"
}
sets.midcast.Cure = {
main = "Arka IV",
head = "Vanya Hood",
body = "Gendewitha Bliaut",
hands = "Telchine Gloves",
ring2 = "Sirona's Ring",
waist = "Bishop's Sash",
feet = "Vanya Clogs"
}
sets.resting = {
main = "Chatoyant Staff",
neck = "Eidolon Pendant",
ear2 = "Antivenom Earring",
body = "Errant Hpl.",
ring1 = "Star Ring",
ring2 = "Star Ring",
back = "Felicitas Cape",
waist = "Austerity Belt",
legs = "Nisse Slacks"
}
sets.precast.FC = {
main = "Grioavolr",
head = "Wlk. Chapeau +1",
ear2 = "Loquac. Earring"
}
sets.precast.FC.Cure = {
main = "Grioavolr",
head = "Wlk. Chapeau +1",
ear2 = "Loquac. Earring"
}
sets.engaged = {
main = "Nibiru Blade",
body = "Emet Harness"
}
sets.precast.FC['Enfeebling Magic'] = {
main = "Grioavolr",
head = "Estq. Chappel +2",
ear2 = "Loquac. Earring"
}
sets.midcast['Enfeebling Magic'] = {
main = "Grioavolr",
sub = "Macero Grip",
ammo = "Kalboron Stone",
head = "Vitiation Chapeau",
ear1 = "Snotra Earring",
body = "Estq. Sayon +2",
hands = "Estq. Ganthrt. +2",
back = "Sucellos's Cape"
}
sets.midcast['Enhancing Magic'] = {
body = "Vitiation Tabard",
hands = "Vitiation Gloves",
back = "Sucellos's Cape",
feet = "Estq. Houseaux +2"
}
sets.midcast.Refresh = {
body = "Vitiation Tabard",
hands = "Vitiation Gloves",
back = "Sucellos's Cape",
waist = "Gishdubar Sash",
legs = "Estqr. Fuseau +2",
feet = "Estq. Houseaux +2"
}
sets.precast.FC['Enhancing Magic'] = {
main = "Grioavolr",
head = "Wlk. Chapeau +1",
ear2 = "Loquac. Earring",
waist = "Siegel Sash"
}
sets.midcast.Stoneskin = {
neck = "Stone Gorget",
ear2 = "Earthcry Earring",
body = "Vitiation Tabard",
hands = "Vitiation Gloves",
back = "Sucellos's Cape",
waist = "Siegel Sash",
feet = "Estq. Houseaux +2"
}
sets['Treasure Hunter'] = {
head = "Wh. Rarab Cap +1"
}
return sets
end

return setsUtil
