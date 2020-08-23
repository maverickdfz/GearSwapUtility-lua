local setsUtil = {}

setsUtil.apply = function(sets)
sets.idle = {
main = "Nirvana",
ammo = "Sancus Sachet +1",
head = "Beckoner's Horn +1",
ear2 = "C. Palug Earring",
body = "Apo. Dalmatica +1",
hands = "Asteria Mitts +1",
ring1 = "Stikini Ring +1",
ring2 = "Stikini Ring +1",
waist = "Fucho-no-Obi",
legs = "Assid. Pants +1",
feet = "Herald's Gaiters"
}
sets.precast = {}
sets.precast.JA = {}
sets.midcast = {}
sets.midcast.Pet = {}
sets.idle.Pet = {
main = "Nirvana",
head = "Beckoner's Horn +1",
ear2 = "C. Palug Earring",
body = "Apo. Dalmatica +1",
hands = "Asteria Mitts +1",
ring1 = "Stikini Ring +1",
ring2 = "Stikini Ring +1",
back = "Campestres's Cape",
waist = "Fucho-no-Obi",
legs = "Assid. Pants +1"
}
sets.idle.Pet.Engaged = {
ammo = "Sancus Sachet +1",
neck = "Shulmanu Collar",
ear1 = "Enmerkar Earring",
ear2 = "C. Palug Earring",
hands = "Asteria Mitts +1",
ring1 = "Varar Ring +1",
ring2 = "Varar Ring +1",
back = { name = "Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: "Regen"+10','Pet: "Regen"+5',}},
waist = "Klouskap Sash +1",
legs = "Assid. Pants +1"
}
sets.precast.JA['Astral Flow'] = {}
sets.precast.JA['Elemental Siphon'] = {
main = "Keraunos",
sub = "Vox Grip",
head = "Beckoner's Horn +1",
neck = "Melic Torque",
ear1 = "Andoaa Earring",
ear2 = "C. Palug Earring",
ring1 = "Evoker's Ring",
ring2 = "Stikini Ring +1",
back = "Conveyance Cape",
waist = "Lucidity Sash"
}
sets.precast.BloodPactWard = {
sub = "Vox Grip",
ammo = "Sancus Sachet +1",
head = "Beckoner's Horn +1",
neck = "Incanter's Torque",
ear1 = "Andoaa Earring",
ear2 = "Evans Earring",
body = "Con. Doublet +3",
hands = "Lamassu Mitts +1",
ring1 = "Evoker's Ring",
ring2 = "Stikini Ring +1",
back = "Conveyance Cape",
waist = "Lucidity Sash"
}
sets.precast.BloodPactRage = {
sub = "Vox Grip",
ammo = "Sancus Sachet +1",
head = "Beckoner's Horn +1",
neck = "Melic Torque",
ear1 = "Andoaa Earring",
ear2 = "C. Palug Earring",
body = "Con. Doublet +3",
hands = "Lamassu Mitts +1",
ring1 = "Evoker's Ring",
ring2 = "Stikini Ring +1",
back = "Conveyance Cape",
waist = "Lucidity Sash"
}
sets.midcast.BloodPactWard = {
sub = "Vox Grip",
head = "Beckoner's Horn +1",
neck = "Melic Torque",
ear1 = "Andoaa Earring",
ear2 = "C. Palug Earring",
hands = "Lamassu Mitts +1",
ring1 = "Evoker's Ring",
ring2 = "Stikini Ring +1",
back = "Conveyance Cape",
waist = "Lucidity Sash"
}
sets.midcast.BloodPactRage = {
main = "Nirvana",
sub = "Elan Strap +1",
ammo = "Sancus Sachet +1",
head = "C. Palug Crown",
neck = "Shulmanu Collar",
ear1 = "Gelos Earring",
ear2 = "Enmerkar Earring",
body = "Con. Doublet +3",
hands = { name = "Merlinic Dastanas", augments={'Pet: Accuracy+24 Pet: Rng. Acc.+24','Blood Pact Dmg.+9','Pet: Mag. Acc.+5','Pet: "Mag.Atk.Bns."+8',}},
ring1 = "Varar Ring +1",
ring2 = "Varar Ring +1",
back = { name = "Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: "Regen"+10','Pet: "Regen"+5',}},
waist = "Incarnation Sash",
legs = "Apogee Slacks +1",
feet = "Apogee Pumps +1"
}
sets.engaged = {}
sets.precast.FC = {
ammo = "Sapience Orb",
head = "C. Palug Crown",
neck = "Baetyl Pendant",
ear1 = "Loquac. Earring",
ring1 = "Kishar Ring",
waist = "Embla Sash"
}
sets.midcast['Enhancing Magic'] = {
waist = "Embla Sash"
}
sets.midcast.BloodPactRage.Magical = {
main = "Grioavolr",
sub = "Elan Strap +1",
ammo = "Sancus Sachet +1",
head = "C. Palug Crown",
neck = "Adad Amulet",
ear1 = "Gelos Earring",
ear2 = "Lugalbanda Earring",
body = "Apo. Dalmatica +1",
hands = { name = "Merlinic Dastanas", augments={'Pet: Mag. Acc.+25','Blood Pact Dmg.+10','Pet: STR+5','Pet: "Mag.Atk.Bns."+13',}},
ring1 = "C. Palug Ring",
ring2 = "Varar Ring +1",
back = { name = "Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Pet: Mag. Acc.+10',}},
waist = "Incarnation Sash",
legs = "Enticer's Pants",
feet = "Convo. Pigaches +3"
}
sets.midcast.BloodPactRage.Physical = {
main = "Nirvana",
sub = "Elan Strap +1",
ammo = "Sancus Sachet +1",
head = "C. Palug Crown",
neck = "Shulmanu Collar",
ear1 = "Gelos Earring",
ear2 = "Lugalbanda Earring",
body = "Con. Doublet +3",
hands = { name = "Merlinic Dastanas", augments={'Pet: Accuracy+24 Pet: Rng. Acc.+24','Blood Pact Dmg.+9','Pet: Mag. Acc.+5','Pet: "Mag.Atk.Bns."+8',}},
ring1 = "Varar Ring +1",
ring2 = "Varar Ring +1",
back = { name = "Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: "Regen"+10','Pet: "Regen"+5',}},
waist = "Incarnation Sash",
legs = "Apogee Slacks +1",
feet = "Apogee Pumps +1"
}
sets.midcast.BloodPactRage.Physical.Accuracy = {
neck = "Shulmanu Collar",
ear1 = "Enmerkar Earring",
ear2 = "Lugalbanda Earring",
body = "Con. Doublet +3"
}
sets.midcast.BloodPactRage.Magical.Accuracy = {
neck = "Adad Amulet",
ear1 = "Enmerkar Earring",
ear2 = "Lugalbanda Earring",
body = "Con. Doublet +3"
}
sets.midcast.Refresh = {
back = "Grapevine Cape",
waist = "Embla Sash",
feet = "Inspirited Boots"
}
sets.midcast.BloodPactRage['Flaming Crush'] = {
main = "Nirvana",
sub = "Elan Strap +1",
ammo = "Sancus Sachet +1",
head = "C. Palug Crown",
neck = "Adad Amulet",
ear1 = "Gelos Earring",
ear2 = "Lugalbanda Earring",
body = "Apo. Dalmatica +1",
hands = { name = "Merlinic Dastanas", augments={'Pet: Mag. Acc.+25','Blood Pact Dmg.+10','Pet: STR+5','Pet: "Mag.Atk.Bns."+13',}},
ring1 = "Varar Ring +1",
ring2 = "Varar Ring +1",
back = { name = "Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Pet: Mag. Acc.+10',}},
waist = "Incarnation Sash",
legs = "Apogee Slacks +1",
feet = "Apogee Pumps +1"
}
return sets
end

return setsUtil
