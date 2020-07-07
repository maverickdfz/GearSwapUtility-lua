local setsUtil = {}

setsUtil.apply = function(sets)
sets.idle = {
main = "Nirvana",
ammo = "Sancus Sachet +1",
head = "Beckoner's Horn +1",
body = "Shomonjijoe +1",
ring1 = "Stikini Ring +1",
legs = "Assid. Pants +1"
}
sets.precast = {}
sets.precast.JA = {}
sets.midcast = {}
sets.midcast.Pet = {}
sets.idle.Pet = {
main = "Nirvana",
head = "Beckoner's Horn +1",
body = "Shomonjijoe +1",
ring1 = "Stikini Ring +1",
back = "Campestres's Cape",
legs = "Assid. Pants +1"
}
sets.idle.Pet.Engaged = {
ammo = "Sancus Sachet +1",
neck = "Shulmanu Collar",
ear1 = "Enmerkar Earring",
ring1 = "Varar Ring +1",
ring2 = "Varar Ring +1",
back = { name = "Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: "Regen"+10','Pet: "Regen"+5',}},
waist = "Klouskap Sash +1"
}
sets.precast.JA['Astral Flow'] = {}
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
sub = "Vox Grip",
ammo = "Sancus Sachet +1",
head = "Beckoner's Horn +1",
ear1 = "Andoaa Earring",
ear2 = "Evans Earring",
body = "Con. Doublet +3",
ring1 = "Evoker's Ring",
ring2 = "Stikini Ring +1",
back = "Conveyance Cape",
waist = "Lucidity Sash"
}
sets.precast.BloodPactRage = {
sub = "Vox Grip",
ammo = "Sancus Sachet +1",
head = "Beckoner's Horn +1",
ear1 = "Andoaa Earring",
ear2 = "Evans Earring",
body = "Con. Doublet +3",
ring1 = "Evoker's Ring",
ring2 = "Stikini Ring +1",
back = "Conveyance Cape",
waist = "Lucidity Sash"
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
hands = { name = "Merlinic Dastanas", augments={'Pet: Accuracy+24 Pet: Rng. Acc.+24','Blood Pact Dmg.+9','Pet: Mag. Acc.+5','Pet: "Mag.Atk.Bns."+8',}},
ring1 = "Varar Ring +1",
ring2 = "Varar Ring +1",
back = { name = "Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: "Regen"+10','Pet: "Regen"+5',}},
waist = "Klouskap Sash +1",
legs = "Apogee Slacks +1",
feet = "Apogee Pumps +1"
}
sets.engaged = {}
sets.precast.FC = {
neck = "Baetyl Pendant",
ear1 = "Loquac. Earring",
ring1 = "Kishar Ring",
waist = "Embla Sash"
}
sets.midcast['Enhancing Magic'] = {
waist = "Embla Sash"
}
return sets
end

return setsUtil
