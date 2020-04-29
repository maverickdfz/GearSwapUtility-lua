local setsUtil = {}

setsUtil.apply = function(sets)
sets.idle = {
main = "Nirvana",
ammo = "Sancus Sachet +1",
head = "Beckoner's Horn +1",
body = "Shomonjijoe +1",
ring1 = "Stikini Ring +1"
}
sets.idle.Pet = {
main = "Nirvana",
head = "Beckoner's Horn +1",
body = "Shomonjijoe +1",
ring1 = "Stikini Ring +1",
back = "Campestres's Cape"
}
sets.idle.Pet.Engaged = {
ammo = "Sancus Sachet +1",
neck = "Shulmanu Collar",
ear1 = "Enmerkar Earring",
ring1 = "Varar Ring +1",
ring2 = "Varar Ring +1",
waist = "Klouskap Sash +1"
}
sets.precast.JA['Elemental Siphon'] = {
sub = "Vox Grip",
head = "Beckoner's Horn +1",
neck = "Incanter's Torque",
ear1 = "Andoaa Earring",
ring1 = "Evoker's Ring",
ring2 = "Stikini Ring +1",
back = "Conveyance Cape",
waist = "Lucidity Sash"
}
sets.precast.BloodPactWard = {
ammo = "Sancus Sachet +1",
head = "Beckoner's Horn +1",
ear1 = "Evans Earring",
body = "Con. Doublet +3"
}
sets.precast.BloodPactRage = {
ammo = "Sancus Sachet +1",
head = "Beckoner's Horn +1",
ear1 = "Evans Earring",
body = "Con. Doublet +3"
}
sets.midcast.BloodPactWard = {
sub = "Vox Grip",
head = "Beckoner's Horn +1",
neck = "Incanter's Torque",
ear1 = "Andoaa Earring",
ring1 = "Evoker's Ring",
ring2 = "Stikini Ring +1",
back = "Conveyance Cape",
waist = "Lucidity Sash"
}
sets.midcast.BloodPactRage = {
main = "Nirvana",
sub = "Elan Strap +1",
ammo = "Sancus Sachet +1",
head = "Apogee Crown +1",
neck = "Shulmanu Collar",
ear1 = "Gelos Earring",
ear2 = "Enmerkar Earring",
body = "Con. Doublet +3",
hands = "Merlinic Dastanas",
ring1 = "Varar Ring +1",
ring2 = "Varar Ring +1",
back = "Campestres's Cape",
waist = "Klouskap Sash +1",
legs = "Apogee Slacks +1",
feet = "Apogee Pumps +1"
}
sets.precast.FC = {
neck = "Baetyl Pendant",
ear1 = "Loquac. Earring",
ring1 = "Kishar Ring",
waist = "Klouskap Sash +1"
}
return sets
end

return setsUtil
