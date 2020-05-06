local setsUtil = {}

setsUtil.apply = function(sets)
sets.idle = {
main = "Akademos",
ammo = "Homiliary",
head = "Befouled Crown",
ear2 = "Infused Earring",
body = "Jhakri Robe +2",
ring1 = "Stikini Ring +1",
waist = "Fucho-no-Obi",
legs = "Assid. Pants +1"
}
sets.midcast = {}
sets.idle.DT = {
main = "Terra's Staff",
ammo = "Homiliary",
neck = "Loricate Torque +1",
ear2 = "Infused Earring",
body = "Mallquis Saio +1",
back = "Solemnity Cape"
}
sets.midcast.Cure = {
main = "Chatoyant Staff",
head = "Vanya Hood",
back = "Solemnity Cape",
legs = "Chironic Hose",
feet = "Vanya Clogs"
}
sets.resting = {
main = "Chatoyant Staff"
}
sets.precast = {}
sets.precast.FC = {
main = "Grioavolr",
ammo = "Sapience Orb",
head = "Merlinic Hood",
neck = "Baetyl Pendant",
ear2 = "Loquac. Earring",
body = "Helios Jacket",
hands = "Helios Gloves",
ring1 = "Kishar Ring",
waist = "Embla Sash",
legs = "Amalric Slops",
feet = "Merlinic Crackows"
}
sets.precast.FC.Cure = {
main = "Grioavolr",
ear2 = "Loquac. Earring"
}
sets.engaged = {}
sets.precast.FC['Enfeebling Magic'] = {
main = "Grioavolr",
ammo = "Sapience Orb",
head = "Merlinic Hood",
neck = "Baetyl Pendant",
ear2 = "Loquac. Earring",
body = "Helios Jacket",
hands = "Helios Gloves",
ring1 = "Kishar Ring",
waist = "Embla Sash",
legs = "Amalric Slops",
feet = "Merlinic Crackows"
}
sets.midcast['Enfeebling Magic'] = {
main = "Grioavolr",
sub = "Niobid Strap",
ammo = "Pemphredo Tathlum",
head = "Mall. Chapeau +2",
neck = "Sanctity Necklace",
ear1 = "Barkaro. Earring",
ear2 = "Digni. Earring",
body = "Jhakri Robe +2",
hands = "Jhakri Cuffs +2",
ring1 = "Stikini Ring +1",
ring2 = "Kishar Ring",
back = "Lugh's Cape",
waist = "Luminary Sash",
legs = "Chironic Hose",
feet = "Jhakri Pigaches +2"
}
sets.midcast['Enhancing Magic'] = {}
sets.midcast.Refresh = {}
sets.precast.FC['Enhancing Magic'] = {
main = "Grioavolr",
ammo = "Sapience Orb",
head = "Merlinic Hood",
neck = "Baetyl Pendant",
ear2 = "Loquac. Earring",
ring1 = "Kishar Ring",
waist = "Embla Sash",
feet = "Merlinic Crackows"
}
sets.midcast.Stoneskin = {}
sets['Treasure Hunter'] = {
head = "Wh. Rarab Cap +1"
}
sets.midcast['Elemental Magic'] = {
main = "Akademos",
sub = "Niobid Strap",
ammo = "Pemphredo Tathlum",
head = "Jhakri Coronal +1",
neck = "Baetyl Pendant",
ear1 = "Barkaro. Earring",
ear2 = "Friomisi Earring",
body = "Jhakri Robe +2",
hands = "Jhakri Cuffs +2",
ring1 = "Strendu Ring",
ring2 = "Freke Ring",
back = "Izdubar Mantle",
waist = "Eschan Stone",
legs = "Mallquis Trews +2",
feet = "Jhakri Pigaches +2"
}
sets.precast.FC['Elemental Magic'] = {
main = "Grioavolr",
ammo = "Sapience Orb",
head = "Merlinic Hood",
neck = "Baetyl Pendant",
ear2 = "Loquac. Earring",
body = "Mallquis Saio +1",
hands = "Mallquis Cuffs +1",
ring1 = "Kishar Ring",
back = { name = "Lugh's Cape", augments={'Fast Cast+10'}},
waist = "Embla Sash",
legs = "Amalric Slops",
feet = "Merlinic Crackows"
}
sets.idle.Sublimation = {
main = "Siriti",
neck = "Sanctity Necklace",
ear1 = "Savant's Earring",
ear2 = "Infused Earring",
ring1 = "Stikini Ring +1"
}
sets.precast.WS = {}
sets.precast.WS.Myrkr = {
sub = "Niobid Strap",
neck = "Sanctity Necklace",
ear1 = "Loquac. Earring",
waist = "Luminary Sash"
}
sets.precast.JA = {}
sets.precast.JA.Parsimony = {
legs = "Arbatel Pants +1"
}
sets.precast.JA.Penury = {
legs = "Arbatel Pants +1"
}
sets.precast.JA['Tabula Rasa'] = {
legs = "Peda. Pants +3"
}
sets.precast.JA.Perpetuance = {
hands = "Arbatel Bracers +1"
}
sets.precast.JA.Rapture = {
head = "Arbatel Bonnet +1"
}
sets.precast.JA.Ebullience = {
head = "Arbatel Bonnet +1"
}
sets.precast.JA.Sublimation = {
main = "Siriti",
head = "Acad. Mortar. +3",
body = "Peda. Gown +3"
}
sets.precast.FC.Klimaform = {
feet = "Arbatel Loafers +1"
}
sets.midcast.Protect = {}
sets.midcast.Protect.Self = {
ring1 = "Sheltered Ring"
}
sets.midcast.Shell = {}
sets.midcast.Shell.Self = {
ring1 = "Sheltered Ring"
}
sets.midcast.Stoneskin.Self = {
waist = "Siegel Sash"
}
sets.midcast.Storm = {
feet = "Peda. Loafers +3"
}
sets.midcast.Regen = {
head = "Arbatel Bonnet +1",
neck = "Incanter's Torque",
hands = "Arbatel Bracers +1",
waist = "Hachirin-no-Obi"
}
sets.midcast.Refresh.Self = {
back = "Grapevine Cape",
waist = "Gishdubar Sash"
}
sets.midcast['Elemental Magic'].Helix = {
ring1 = "Locus Ring",
ring2 = "Mujin Band"
}
return sets
end

return setsUtil
