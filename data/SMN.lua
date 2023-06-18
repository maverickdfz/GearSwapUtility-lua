-- Summoner Gearswap Lua by Pergatory - http://pastebin.com/u/pergatory
-- IdleMode determines the set used after casting. You change it with "/console gs c <IdleMode>"
-- The out-of-the-box modes are:
-- Refresh: Uses the most refresh available.
-- DT: A mix of refresh, PDT, and MDT to help when you can't avoid AOE.
-- PetDT: Sacrifice refresh to reduce avatar's damage taken. WARNING: Selenian Cap drops you below 119, use with caution!
-- DD: When melee mode is on and you're engaged, uses TP gear. Otherwise, avatar melee gear.
-- Favor: Uses Beckoner's Horn and max smn skill to boost the favor effect.
-- Zendik: Favor build with the Zendik Robe added in, for Shiva's Favor in manaburn parties. (Shut up, it sounded like a good idea at the time)

-- You can add your own modes in the IdleModes list, just make sure to add corresponding sets as well.

-- Additional Bindings:
-- F9 - Toggles between a subset of IdleModes (Refresh > DT > PetDT)
-- F10 - Toggles WeaponLock (When enabled, equips Nirvana and Elan+1, then disables those 2 slots from swapping)
--       NOTE: If you don't already have the Nirvana & Elan+1 equipped, YOU WILL LOSE TP

-- Additional Commands:
-- /console gs c AccMode - Toggles high-accuracy sets to be used where appropriate.
-- /console gs c ImpactMode - Toggles between using normal magic BP set for Fenrir's Impact or a custom high-skill set for debuffs.
-- /console gs c ForceIlvl - I have this set up to override a few specific slots where I normally use non-ilvl pieces.
-- /console gs c TH - Treasure Hunter toggle. By default, this is only used for Dia, Dia II, and Diaga.
-- /console gs c LagMode - Used to help BPs land in the right gear in high-lag situations.
--							Sets a timer to swap gear 0.5s after the BP is used rather than waiting for server response.

function file_unload()
	send_command('unbind f9')
	send_command('unbind f11')
	send_command('unbind ^f9')
	send_command('unbind ^f10')
	enable("main","sub","range","ammo","head","neck","ear1","ear2","body","hands","ring1","ring2","back","waist","legs","feet")
end

function get_sets()
	send_command('bind f9 gs c ToggleIdle') -- F9 = Cycle through commonly used idle modes
	send_command('bind f11 gs c ForceIlvl') -- Ctrl+F9 = Toggle ForceIlvl
	send_command('bind ^f9 gs c WeaponLock') -- F10 = Toggle Melee Mode
	send_command('bind ^f10 gs c TH') -- Ctrl+F10 = Treasure Hunter toggle

	-- Set your merits here. This is used in deciding between Enticer's Pants or Apogee Slacks +1.
	-- To change in-game, "/console gs c MeteorStrike3" will change Meteor Strike to 3/5 merits.
	-- The damage difference is very minor unless you're over 2400 TP.
	-- It's ok to just always use Enticer's Pants and ignore this section.
	MeteorStrike = 1
	HeavenlyStrike = 1
	WindBlade = 1
	Geocrush = 1
	Thunderstorm = 5
	GrandFall = 1

	StartLockStyle = '85'
	IdleMode = 'Refresh'
	AccMode = false
	ImpactDebuff = false
	WeaponLock = false
	TreasureHunter = false
	THSpells = S{"Dia","Dia II","Diaga"} -- If you want Treasure Hunter gear to swap for a spell/ability, add it here.
	ForceIlvl = false
	LagMode = false -- Default LagMode. If you have a lot of lag issues, change to "true".
		-- Warning: LagMode can cause problems if you spam BPs during Conduit because it doesn't trust server packets to say whether the BP is readying or not.
	SacTorque = true -- If you have Sacrifice Torque, this will auto-equip it when slept in order to wake up.
	AutoRemedy = false -- Auto Remedy when using an ability while Paralyzed.
	AutoEcho = false -- Auto Echo Drop when using an ability while Silenced.

	-- Add idle modes here if you need more options for your sets
	IdleModes = {'Refresh','DT','DD','PetDT','PetDD','Favor','Zendik','MEva'}

	-- ===================================================================================================================
	--		Sets
	-- ===================================================================================================================
	local setsUtil = include('SMN-sets')
    sets = setsUtil.apply(sets)

	-- sets.DT = {}
	-- -- Base Damage Taken Set - Mainly used when IdleMode is "DT"
	-- sets.DT.Base = {
	-- 	main="Nirvana",
	-- 	sub="Oneiros Grip",
	-- 	ammo="Epitaph",
	-- 	head="Beckoner's Horn +3",
	-- 	neck="Summoner's Collar +2",
	-- 	ear1="Cath Palug Earring",
	-- 	ear2="Beckoner's Earring +1",
	-- 	body="Beckoner's Doublet +3",
	-- 	hands={ name="Merlinic Dastanas", augments={'Pet: Crit.hit rate +2','"Mag.Atk.Bns."+25','"Refresh"+2','Mag. Acc.+10 "Mag.Atk.Bns."+10',}},
	-- 	ring1="Inyanga Ring",
	-- 	ring2="Defending Ring",
	-- 	back={ name="Campestres's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}},
	-- 	waist="Carrier's Sash",
	-- 	legs="Inyanga Shalwar +2",
	-- 	feet="Baayami Sabots +1"
	-- }

	-- -- Treasure Hunter set. Don't put anything in here except TH+ gear.
	-- -- It overwrites slots in other sets when TH toggle is on (Ctrl+F10).
	-- sets.TH = {
	-- 	ammo="Perfect Lucky Egg",
	-- 	head="Volte Cap",
	-- 	waist="Chaac Belt",
	-- 	body="Nyame Mail", -- Because otherwise Cohort Cloak and such mess up the swap
	-- 	hands="Volte Bracers",
	-- 	feet="Volte Boots"
	-- }

	-- -- This gets equipped automatically when you have Sneak/Invis or Quickening such as from Fleet Wind.
	-- sets.Movement = {
	-- 	feet="Herald's Gaiters"
	-- }

	-- sets.precast = {}

	-- -- Fast Cast
	-- sets.precast.FC = {
	-- 	main={ name="Grioavolr", augments={'"Fast Cast"+6','INT+2','"Mag.Atk.Bns."+17',}}, -- +10
	-- 	sub="Clerisy Strap +1", -- +3
	-- 	--ammo="Sapience Orb",
	-- 	head="Amalric Coif +1", -- +11
	-- 	neck="Orunmila's Torque", -- +5
	-- 	ear1="Malignance Earring", -- +4
	-- 	ear2="Loquacious Earring", -- +2
	-- 	hands={ name="Telchine Gloves", augments={'Mag. Evasion+25','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
	-- 	body="Inyanga Jubbah +2", -- +14
	-- 	ring1="Lebeche Ring",
	-- 	ring2="Kishar Ring", -- +4
	-- 	back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: Mag. Acc.+10','"Fast Cast"+10',}},
	-- 	waist="Witful Belt", -- +3
	-- 	legs={ name="Merlinic Shalwar", augments={'"Fast Cast"+6','CHR+6','Mag. Acc.+14','"Mag.Atk.Bns."+14',}},
	-- 	feet="Regal Pumps +1" -- +5~7
	-- }

	-- sets.precast["Dispelga"] = set_combine(sets.precast.FC, {
	-- 	main="Daybreak",
	-- 	sub="Ammurapi Shield"
	-- })

    -- sets.midcast = {}

	-- -- BP Timer Gear
	-- -- Use BP Recast Reduction here, along with Avatar's Favor gear.
	-- -- Avatar's Favor skill tiers are 512 / 575 / 670.
    -- sets.midcast.BP = {
	-- 	main={ name="Espiritus", augments={'Summoning magic skill +15','Pet: Mag. Acc.+30','Pet: Damage taken -4%',}},
	-- 	sub="Vox Grip",
	-- 	ammo="Sancus Sachet +1",
	-- 	head="Beckoner's Horn +3", -- Always use Beckoner's Horn here.
	-- 	neck="Incanter's Torque",
	-- 	ear1="Cath Palug Earring",
	-- 	ear2="Lodurr Earring",
	-- 	body="Baayami Robe +1",
	-- 	hands="Baayami Cuffs +1",
	-- 	ring1={name="Stikini Ring +1", bag="wardrobe2"},
	-- 	ring2="Evoker's Ring",
	-- 	back={ name="Conveyance Cape", augments={'Summoning magic skill +5','Pet: Enmity+12','Blood Pact Dmg.+2',}},
	-- 	waist="Kobo Obi",
	-- 	legs="Baayami Slops +1",
	-- 	feet="Baayami Sabots +1"
	-- }

	-- -- Elemental Siphon sets. Zodiac Ring is affected by day, Chatoyant Staff by weather, and Twilight Cape by both.
    -- sets.midcast.Siphon = {
	-- 	main={ name="Espiritus", augments={'Summoning magic skill +15','Pet: Mag. Acc.+30','Pet: Damage taken -4%',}},
	-- 	sub="Vox Grip",
	-- 	ammo="Esper Stone +1",
	-- 	head="Baayami Hat +1",
	-- 	neck="Incanter's Torque",
	-- 	ear1="Cath Palug Earring",
	-- 	ear2="Lodurr Earring",
	-- 	body="Baayami Robe +1",
	-- 	hands="Baayami Cuffs +1",
	-- 	ring1={name="Stikini Ring +1", bag="wardrobe2"},
	-- 	ring2="Evoker's Ring",
	-- 	back={ name="Conveyance Cape", augments={'Summoning magic skill +5','Pet: Enmity+12','Blood Pact Dmg.+2',}},
	-- 	waist="Kobo Obi",
	-- 	legs="Baayami Slops +1",
	-- 	feet="Beckoner's Pigaches +3"
	-- }

	-- sets.midcast.Siphon.Zodiac = set_combine(sets.midcast.Siphon, { ring1="Zodiac Ring" })

	-- sets.midcast.Siphon.Weather = set_combine(sets.midcast.Siphon, { main="Chatoyant Staff" })

	-- sets.midcast.Siphon.WeatherZodiac = set_combine(sets.midcast.Siphon.Zodiac, { main="Chatoyant Staff" })

	-- -- Summoning Midcast, cap spell interruption if possible (Baayami Robe gives 100, need 2 more)
	-- -- PDT isn't a bad idea either, so don't overwrite a lot from the DT set it inherits from.
	-- sets.midcast.Summoning = set_combine(sets.DT.Base, {
	-- 	body="Baayami Robe +1",
	-- 	waist="Rumination Sash"
	-- })

	-- -- If you ever lock your weapon, keep that in mind when building cure potency set.
	-- sets.midcast.Cure = {
	-- 	main="Nirvana",
	-- 	sub="Clerisy Strap +1",
	-- 	head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
	-- 	neck="Orunmila's Torque",
	-- 	ear1="Meili Earring",
	-- 	ear2="Novia Earring",
	-- 	body="Zendik Robe",
	-- 	hands={ name="Telchine Gloves", augments={'Mag. Evasion+25','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
	-- 	ring1="Lebeche Ring",
	-- 	ring2="Menelaus's Ring",
	-- 	back="Tempered Cape +1",
	-- 	waist="Luminary Sash",
	-- 	legs="Convoker's Spats +3",
	-- 	feet={ name="Vanya Clogs", augments={'MP+50','"Cure" potency +7%','Enmity-6',}}
	-- }

	-- sets.midcast.Cursna = set_combine(sets.precast.FC, {
	-- 	neck="Debilis Medallion",
	-- 	ear1="Meili Earring",
	-- 	ear2="Beatific Earring",
	-- 	ring1="Menelaus's Ring",
	-- 	ring2="Haoma's Ring",
	-- 	back="Tempered Cape +1",
	-- 	waist="Bishop's Sash",
	-- 	feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}
	-- })

	-- -- Just a standard set for spells that have no set
	-- sets.midcast.EnmityRecast = set_combine(sets.precast.FC, {
	-- 	main="Nirvana",
	-- 	ear1="Novia Earring",
	-- 	body={ name="Apo. Dalmatica +1", augments={'Summoning magic skill +20','Enmity-6','Pet: Damage taken -4%',}}
	-- })

	-- -- Strong alternatives: Daybreak and Ammurapi Shield, Cath Crown, Gwati Earring
	-- sets.midcast.Enfeeble = {
	-- 	main="Contemplator +1",
	-- 	sub="Enki Strap",
	-- 	head=empty,
	-- 	neck="Erra Pendant",
	-- 	ear1="Malignance Earring",
	-- 	ear2="Dignitary's Earring",
	-- 	body="Cohort Cloak +1",
	-- 	hands="Inyanga Dastanas +2",
	-- 	ring1={name="Stikini Ring +1", bag="wardrobe2"},
	-- 	ring2={name="Stikini Ring +1", bag="wardrobe4"},
	-- 	back="Aurist's Cape +1",
	-- 	waist="Luminary Sash",
	-- 	legs="Inyanga Shalwar +2",
	-- 	feet="Skaoi Boots"
	-- }
	-- sets.midcast.Enfeeble.INT = set_combine(sets.midcast.Enfeeble, {
	-- 	waist="Acuity Belt +1"
	-- })

	-- sets.midcast.Enhancing = {
	-- 	main={ name="Gada", augments={'Enh. Mag. eff. dur. +6','DEX+1','Mag. Acc.+5','"Mag.Atk.Bns."+18','DMG:+4',}},
	-- 	sub="Ammurapi Shield",
	-- 	head={ name="Telchine Cap", augments={'Mag. Evasion+24','"Conserve MP"+4','Enh. Mag. eff. dur. +10',}},
	-- 	neck="Incanter's Torque",
	-- 	ear1="Mimir Earring",
	-- 	ear2="Andoaa Earring",
	-- 	body={ name="Telchine Chas.", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
	-- 	hands={ name="Telchine Gloves", augments={'Mag. Evasion+25','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
	-- 	ring1={name="Stikini Ring +1", bag="wardrobe2"},
	-- 	ring2={name="Stikini Ring +1", bag="wardrobe4"},
	-- 	back="Merciful Cape",
	-- 	waist="Embla Sash",
	-- 	legs={ name="Telchine Braconi", augments={'Mag. Evasion+25','"Conserve MP"+4','Enh. Mag. eff. dur. +10',}},
	-- 	feet={ name="Telchine Pigaches", augments={'Mag. Evasion+24','"Conserve MP"+3','Enh. Mag. eff. dur. +10',}}
	-- }

	-- sets.midcast.Stoneskin = set_combine(sets.midcast.Enhancing, {
	-- 	neck="Nodens Gorget",
	-- 	ear2="Earthcry Earring",
	-- 	waist="Siegel Sash",
	-- 	--legs="Shedir Seraweels"
	-- })

	-- sets.midcast.Nuke = {
	-- 	main={ name="Grioavolr", augments={'"Fast Cast"+6','INT+2','"Mag.Atk.Bns."+17',}},
	-- 	sub="Niobid Strap",
	-- 	head="Cath Palug Crown",
	-- 	neck="Sanctity Necklace",
	-- 	ear1="Malignance Earring",
	-- 	ear2="Friomisi Earring",
	-- 	body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
	-- 	hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
	-- 	ring1="Freke Ring",
	-- 	ring2="Shiva Ring +1",
	-- 	back={ name="Campestres's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}},
	-- 	waist="Eschan Stone",
	-- 	legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
	-- 	feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}}
	-- }

    -- sets.midcast["Refresh"] = set_combine(sets.midcast.Enhancing, {
	-- 	head="Amalric Coif +1",
	-- 	waist="Gishdubar Sash"
	-- })

    -- sets.midcast["Aquaveil"] = set_combine(sets.midcast.Enhancing, {
	-- 	main="Vadose Rod",
	-- 	head="Amalric Coif +1",
	-- 	waist="Emphatikos Rope",
	-- })

	-- sets.midcast["Dispelga"] = set_combine(sets.midcast.Enfeeble, {
	-- 	main="Daybreak",
	-- 	sub="Ammurapi Shield"
	-- })

	-- sets.midcast["Mana Cede"] = { hands="Beckoner's Bracers +1" }

    -- sets.midcast["Astral Flow"] = { head="Glyphic Horn +3" }

	---- ===================================================================================================================
	----	Weaponskills
	---- ===================================================================================================================

	-- -- Magic accuracy can be nice here to land the defense down effect. Also keep in mind big damage Garland can make it
	-- -- harder for multiple people to get AM3 on trash mobs before popping an NM.
	-- sets.midcast["Garland of Bliss"] = {
	-- 	head="Nyame Helm",
	-- 	neck="Sanctity Necklace",
	-- 	ear1="Malignance Earring",
	-- 	ear2="Dignitary's Earring",
	-- 	body="Nyame Mail",
	-- 	hands="Nyame Gauntlets",
	-- 	ring1={name="Stikini Ring +1", bag="wardrobe2"},
	-- 	ring2={name="Stikini Ring +1", bag="wardrobe4"},
	-- 	back="Aurist's Cape +1",
	-- 	waist="Eschan Stone",
	-- 	legs="Nyame Flanchard",
	-- 	feet="Nyame Sollerets"
	-- }

	-- -- My set focuses on accuracy here to make skillchains with Ifrit
	-- -- Just like Garland, it's not hard to improve on the damage from this set if that's what you're after.
	-- sets.midcast["Shattersoul"] = {
	-- 	head="Beckoner's Horn +3",
	-- 	neck="Fotia Gorget",
	-- 	ear1="Zennaroi Earring",
	-- 	ear2="Telos Earring",
	-- 	body="Tali'ah Manteel +2",
	-- 	hands="Nyame Gauntlets",
	-- 	ring1="Freke Ring",
	-- 	ring2="Metamorph Ring +1",
	-- 	back={ name="Campestres's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	-- 	waist="Fotia Belt",
	-- 	legs="Nyame Flanchard",
	-- 	feet="Convoker's Pigaches +3"
	-- }

	-- sets.midcast["Cataclysm"] = set_combine(sets.midcast.Nuke, {})

	-- sets.midcast["Shell Crusher"] = set_combine(sets.midcast["Garland of Bliss"], {})

	-- sets.midcast["Black Halo"] = set_combine(sets.midcast["Garland of Bliss"], {})

	-- sets.pet_midcast = {}
	-- sets.pet_midcast.Physical = {}

	-- -- Main physical pact set (Volt Strike, Pred Claws, etc.)
	-- -- Prioritize BP Damage & Pet: Double Attack
	-- -- Strong Alternatives:
	-- -- Gridarvor, Apogee Crown, Apogee Pumps, Convoker's Doublet, Apogee Dalmatica, Shulmanu Collar (equal to ~R15 Collar), Gelos Earring, Regal Belt
	-- sets.pet_midcast.Physical.BP = {
	-- 	main="Nirvana",
	-- 	sub="Elan Strap +1",
	-- 	ammo="Epitaph",
	-- 	head={ name="Helios Band", augments={'Pet: Attack+30 Pet: Rng.Atk.+30','Pet: "Dbl. Atk."+8','Blood Pact Dmg.+7',}},
	-- 	neck="Summoner's Collar +2",
	-- 	ear1="Lugalbanda Earring",
	-- 	ear2="Beckoner's Earring +1",
	-- 	body="Glyphic Doublet +3",
	-- 	hands={ name="Merlinic Dastanas", augments={'Pet: Attack+24 Pet: Rng.Atk.+24','Blood Pact Dmg.+9','Pet: STR+10','Pet: Mag. Acc.+7',}},
	-- 	ring1="Cath Palug Ring",
	-- 	ring2="Varar Ring +1",
	-- 	back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: "Regen"+10','Pet: Damage taken -5%',}},
	-- 	waist="Incarnation Sash",
	-- 	legs={ name="Apogee Slacks +1", augments={'Pet: STR+20','Blood Pact Dmg.+14','Pet: "Dbl. Atk."+4',}},
	-- 	feet={ name="Helios Boots", augments={'Pet: Accuracy+28 Pet: Rng. Acc.+28','Pet: "Dbl. Atk."+8','Blood Pact Dmg.+7',}}
	-- }

	-- -- Physical Pact AM3 set, less emphasis on Pet:DA
	-- sets.pet_midcast.Physical.BP.AM3 = set_combine(sets.pet_midcast.Physical.BP, {
	-- 	body="Convoker's Doublet +3",
	-- 	ring1="Varar Ring +1",
	-- 	feet={ name="Apogee Pumps +1", augments={'MP+80','Pet: Attack+35','Blood Pact Dmg.+8',}}
	-- })

	-- -- Physical pacts which benefit more from TP than Pet:DA (like Spinning Dive and other pacts you never use except that one time)
	-- sets.pet_midcast.Physical.BP.TP = set_combine(sets.pet_midcast.Physical.BP, {
	-- 	head={ name="Apogee Crown +1", augments={'MP+80','Pet: Attack+35','Blood Pact Dmg.+8',}},
	-- 	body="Convoker's Doublet +3",
	-- 	ring1="Varar Ring +1",
	-- 	waist="Regal Belt",
	-- 	legs="Enticer's Pants",
	-- 	feet={ name="Apogee Pumps +1", augments={'MP+80','Pet: Attack+35','Blood Pact Dmg.+8',}}
	-- })

	-- -- Used for all physical pacts when AccMode is true
	-- sets.pet_midcast.Physical.BP.Acc = set_combine(sets.pet_midcast.Physical.BP, {
	-- 	head={ name="Apogee Crown +1", augments={'MP+80','Pet: Attack+35','Blood Pact Dmg.+8',}},
	-- 	body="Convoker's Doublet +3",
	-- 	hands={ name="Merlinic Dastanas", augments={'Pet: Accuracy+28 Pet: Rng. Acc.+28','Blood Pact Dmg.+10','Pet: DEX+9','Pet: Mag. Acc.+9','Pet: "Mag.Atk.Bns."+3',}},
	-- 	feet="Beckoner's Pigaches +3"
	-- })

	-- sets.pet_midcast.Magic = {}
	-- sets.pet_midcast.Magic.BP = {}

	-- -- Base magic pact set
	-- -- Prioritize BP Damage & Pet:MAB
	-- -- Strong Alternatives:
	-- -- Espiritus, Apogee Crown, Adad Amulet (equal to ~R12 Collar)
	-- sets.pet_midcast.Magic.BP.Base = {
	-- 	main={ name="Grioavolr", augments={'Blood Pact Dmg.+10','Pet: STR+5','Pet: Mag. Acc.+18','Pet: "Mag.Atk.Bns."+25',}},
	-- 	sub="Elan Strap +1",
	-- 	ammo="Epitaph",
	-- 	head="Cath Palug Crown",
	-- 	neck="Summoner's Collar +2",
	-- 	ear1="Lugalbanda Earring",
	-- 	ear2="Beckoner's Earring +1",
	-- 	body={ name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
	-- 	hands={ name="Merlinic Dastanas", augments={'Pet: Mag. Acc.+25 Pet: "Mag.Atk.Bns."+25','Blood Pact Dmg.+10','Pet: "Mag.Atk.Bns."+7',}},
	-- 	ring1={name="Varar Ring +1", bag="wardrobe2"},
	-- 	ring2={name="Varar Ring +1", bag="wardrobe4"},
	-- 	back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: Mag. Acc.+10','"Fast Cast"+10',}},
	-- 	waist="Regal Belt",
	-- 	feet={ name="Apogee Pumps +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}}
	-- }

	-- -- Some magic pacts benefit more from TP than others.
	-- -- Note: This set will only be used on merit pacts if you have less than 4 merits.
	-- --       Make sure to update your merit values at the top of this Lua.
	-- sets.pet_midcast.Magic.BP.TP = set_combine(sets.pet_midcast.Magic.BP.Base, {
	-- 	legs="Enticer's Pants"
	-- })

	-- -- NoTP set used when you don't need Enticer's
	-- sets.pet_midcast.Magic.BP.NoTP = set_combine(sets.pet_midcast.Magic.BP.Base, {
	-- 	legs={ name="Apogee Slacks +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}}
	-- })

	-- sets.pet_midcast.Magic.BP.TP.Acc = set_combine(sets.pet_midcast.Magic.BP.TP, {
	-- 	head={ name="Merlinic Hood", augments={'Pet: Mag. Acc.+21 Pet: "Mag.Atk.Bns."+21','Blood Pact Dmg.+7','Pet: INT+6','Pet: "Mag.Atk.Bns."+11',}},
	-- 	body="Convoker's Doublet +3",
	-- 	hands={ name="Merlinic Dastanas", augments={'Pet: Mag. Acc.+29','Blood Pact Dmg.+10','Pet: INT+7','Pet: "Mag.Atk.Bns."+10',}}
	-- })

	-- sets.pet_midcast.Magic.BP.NoTP.Acc = set_combine(sets.pet_midcast.Magic.BP.NoTP, {
	-- 	head={ name="Merlinic Hood", augments={'Pet: Mag. Acc.+21 Pet: "Mag.Atk.Bns."+21','Blood Pact Dmg.+7','Pet: INT+6','Pet: "Mag.Atk.Bns."+11',}},
	-- 	body="Convoker's Doublet +3",
	-- 	hands={ name="Merlinic Dastanas", augments={'Pet: Mag. Acc.+29','Blood Pact Dmg.+10','Pet: INT+7','Pet: "Mag.Atk.Bns."+10',}}
	-- })

	-- -- Favor BP Damage above all. Pet:MAB also very strong.
	-- -- Pet: Accuracy, Attack, Magic Accuracy moderately important.
	-- -- Strong Alternatives:
	-- -- Keraunos, Grioavolr, Espiritus, Was, Apogee Crown, Apogee Dalmatica, Adad Amulet
	-- sets.pet_midcast.FlamingCrush = {
	-- 	main="Nirvana",
	-- 	sub="Elan Strap +1",
	-- 	ammo="Epitaph",
	-- 	head="Cath Palug Crown",
	-- 	neck="Summoner's Collar +2",
	-- 	ear1="Lugalbanda Earring",
	-- 	ear2="Beckoner's Earring +1",
	-- 	body="Convoker's Doublet +3",
	-- 	hands={ name="Merlinic Dastanas", augments={'Pet: Mag. Acc.+25 Pet: "Mag.Atk.Bns."+25','Blood Pact Dmg.+10','Pet: "Mag.Atk.Bns."+7',}},
	-- 	ring1={name="Varar Ring +1", bag="wardrobe2"},
	-- 	ring2={name="Varar Ring +1", bag="wardrobe4"},
	-- 	back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: "Regen"+10','Pet: Damage taken -5%',}},
	-- 	waist="Regal Belt",
	-- 	legs={ name="Apogee Slacks +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
	-- 	feet={ name="Apogee Pumps +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}}
	-- }

	-- sets.pet_midcast.FlamingCrush.Acc = set_combine(sets.pet_midcast.FlamingCrush, {
	-- 	body="Convoker's Doublet +3",
	-- 	hands={ name="Merlinic Dastanas", augments={'Pet: Accuracy+28 Pet: Rng. Acc.+28','Blood Pact Dmg.+10','Pet: DEX+9','Pet: Mag. Acc.+9','Pet: "Mag.Atk.Bns."+3',}},
	-- 	--feet="Convoker's Pigaches +3"
	-- })

	-- sets.pet_midcast.MagicAcc = {}

	-- -- Pet: Magic Acc set - Mainly used for debuff pacts like Shock Squall
	-- sets.pet_midcast.MagicAcc.BP = {
	-- 	main="Nirvana",
	-- 	sub="Vox Grip",
	-- 	ammo="Epitaph",
	-- 	head="Beckoner's Horn +3",
	-- 	neck="Summoner's Collar +2",
	-- 	ear1="Enmerkar Earring",
	-- 	ear2="Lugalbanda Earring",
	-- 	body="Convoker's Doublet +3",
	-- 	hands="Lamassu Mitts +1",
	-- 	ring1="Cath Palug Ring",
	-- 	ring2="Evoker's Ring",
	-- 	back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: Mag. Acc.+10','"Fast Cast"+10',}},
	-- 	waist="Regal Belt",
	-- 	legs="Convoker's Spats +3",
	-- 	feet="Bunzi's Sabots"
	-- }

	-- sets.pet_midcast.Debuff = sets.pet_midcast.MagicAcc.BP

	-- sets.pet_midcast.Debuff.Rage = sets.pet_midcast.MagicAcc.BP

	-- -- Pure summoning magic set, mainly used for buffs like Hastega II.
	-- -- Strong Alternatives:
	-- -- Andoaa Earring, Summoning Earring, Lamassu Mitts +1, Caller's Pendant
	-- sets.pet_midcast.SummoningMagic = {
	-- 	main={ name="Espiritus", augments={'Summoning magic skill +15','Pet: Mag. Acc.+30','Pet: Damage taken -4%',}},
	-- 	sub="Vox Grip",
	-- 	ammo="Epitaph",
	-- 	head="Baayami Hat +1",
	-- 	neck="Incanter's Torque",
	-- 	ear1="Cath Palug Earring",
	-- 	ear2="Lodurr Earring",
	-- 	body="Baayami Robe +1",
	-- 	hands="Baayami Cuffs +1",
	-- 	ring1={name="Stikini Ring +1", bag="wardrobe2"},
	-- 	ring2="Evoker's Ring",
	-- 	back={ name="Conveyance Cape", augments={'Summoning magic skill +5','Pet: Enmity+12','Blood Pact Dmg.+2',}},
	-- 	waist="Kobo Obi",
	-- 	legs="Baayami Slops +1",
	-- 	feet="Baayami Sabots +1"
	-- }

	-- sets.pet_midcast.Buff = sets.pet_midcast.SummoningMagic

	-- -- Wind's Blessing set. Pet:MND increases potency.
	-- sets.pet_midcast.Buff.MND = set_combine(sets.pet_midcast.Buff, {
	-- 	main="Nirvana",
	-- 	neck="Summoner's Collar +2",
	-- 	ear2="Beckoner's Earring +1",
	-- 	hands="Lamassu Mitts +1",
	-- 	back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: "Regen"+10','Pet: Damage taken -5%',}},
	-- 	legs="Assiduity Pants +1",
	-- 	feet="Bunzi's Sabots"
	-- })

	-- -- Don't drop Avatar level in this set if you can help it.
	-- -- You can use Avatar:HP+ gear to increase the HP recovered, but most of it will decrease your own max HP.
	-- sets.pet_midcast.Buff.Healing = set_combine(sets.pet_midcast.Buff, {
	-- 	main="Nirvana",
	-- 	back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: "Regen"+10','Pet: Damage taken -5%',}},
	-- 	--body={ name="Apo. Dalmatica +1", augments={'Summoning magic skill +20','Enmity-6','Pet: Damage taken -4%',}},
	-- 	--feet={ name="Apogee Pumps +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}}
	-- })

	-- -- This set is used for certain blood pacts when ImpactDebuff mode is turned ON. (/console gs c ImpactDebuff)
	-- -- These pacts are normally used with magic damage gear, but they're also strong debuffs when enhanced by summoning skill.
	-- -- This set is safe to ignore.
	-- sets.pet_midcast.Impact = set_combine(sets.pet_midcast.SummoningMagic, {
	-- 	main="Nirvana",
	-- 	head="Beckoner's Horn +3",
	-- 	ear1="Enmerkar Earring",
	-- 	ear2="Lugalbanda Earring",
	-- 	hands="Lamassu Mitts +1"
	-- })

	-- -- ===================================================================================================================
	-- -- Aftercast Sets
	-- -- ===================================================================================================================
	-- -- Syntax: sets.aftercast.{IdleMode}.{PetName|Spirit|Avatar}.{PlayerStatus}.{LowMP}.{ForceIlvl}

	-- -- Example: sets.aftercast.DT["Cait Sith"] will be a set used when IdleMode is "DT" and you have Cait Sith summoned.

	-- -- This is your main idle set with no avatar out. Focus on refresh and defensive stats.
	-- sets.aftercast = {
	-- 	main="Mpaca's Staff",
	-- 	sub="Oneiros Grip",
	-- 	ammo="Epitaph",
	-- 	head="Beckoner's Horn +3",
	-- 	neck="Loricate Torque +1",
	-- 	ear1="Cath Palug Earring",
	-- 	ear2="Beckoner's Earring +1",
	-- 	body={ name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
	-- 	hands={ name="Merlinic Dastanas", augments={'Pet: Crit.hit rate +2','"Mag.Atk.Bns."+25','"Refresh"+2','Mag. Acc.+10 "Mag.Atk.Bns."+10',}},
	-- 	ring1={name="Stikini Ring +1", bag="wardrobe2"},
	-- 	ring2="Defending Ring",
	-- 	back={ name="Campestres's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}},
	-- 	waist="Regal Belt",
	-- 	legs="Assiduity Pants +1",
	-- 	feet="Herald's Gaiters"
	-- }

	-- sets.aftercast.ForceIlvl = set_combine(sets.aftercast, {
	-- 	feet="Baayami Sabots +1"
	-- })
	-- sets.aftercast.LowMP = set_combine(sets.aftercast, {
	-- 	waist="Fucho-no-obi"
	-- })
	-- sets.aftercast.LowMP.ForceIlvl = set_combine(sets.aftercast.LowMP, {
	-- 	feet="Baayami Sabots +1"
	-- })

	-- -- Main perpetuation set ~~ Strong Alternatives:
	-- -- Gridarvor, Asteria Mitts, Shomonjijoe, Convoker's Horn, Evans Earring, Isa Belt
	-- sets.aftercast.Avatar = {
	-- 	main="Nirvana",
	-- 	sub="Oneiros Grip",
	-- 	ammo="Epitaph",
	-- 	head="Beckoner's Horn +3",
	-- 	neck="Caller's Pendant",
	-- 	ear1="Cath Palug Earring",
	-- 	ear2="Beckoner's Earring +1",
	-- 	body={ name="Apo. Dalmatica +1", augments={'Summoning magic skill +20','Enmity-6','Pet: Damage taken -4%',}},
	-- 	hands={ name="Merlinic Dastanas", augments={'Pet: Crit.hit rate +2','"Mag.Atk.Bns."+25','"Refresh"+2','Mag. Acc.+10 "Mag.Atk.Bns."+10',}},
	-- 	ring1={name="Stikini Ring +1", bag="wardrobe2"},
	-- 	ring2="Evoker's Ring",
	-- 	back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: "Regen"+10','Pet: Damage taken -5%',}},
	-- 	waist="Lucidity Sash",
	-- 	legs="Assiduity Pants +1",
	-- 	feet="Baayami Sabots +1"
	-- }
	-- -- If you have Fucho and don't need Lucidity Sash for perp down, you can uncomment the belt here to enable using it.
	-- sets.aftercast.Avatar.LowMP = set_combine(sets.aftercast.Avatar, {
	-- 	--waist="Fucho-no-obi"
	-- })

	-- -- Damage Taken set
	-- sets.aftercast.DT = set_combine(sets.DT.Base, {
	-- })

	-- sets.aftercast.DT.Avatar = set_combine(sets.aftercast.DT, {
	-- 	waist="Isa Belt"
	-- })

	-- -- I use this mode for Mewing Lullaby duty in V20+ Gaol. Heaviest defense possible, less attention toward MP management.
	-- sets.aftercast.MEva = set_combine(sets.aftercast.DT, {
	-- 	sub="Khonsu",
	-- 	hands="Nyame Gauntlets",
	-- 	feet="Baayami Sabots +1"
	-- })

	-- sets.aftercast.MEva.Avatar = set_combine(sets.aftercast.MEva, {
	-- 	ear1="Enmerkar Earring",
	-- 	waist="Isa Belt",
	-- 	back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: "Regen"+10','Pet: Damage taken -5%',}},
	-- })

	-- -- These 2 sets are for when you're in DD mode but not actually engaged to something.
	-- sets.aftercast.DD = set_combine(sets.aftercast, {
	-- })

	-- sets.aftercast.DD.Avatar = set_combine(sets.aftercast.Avatar, {
	-- })

	-- -- Main melee set
	-- -- If you want specific things equipped only when an avatar is out, modify "sets.aftercast.DD.Avatar.Engaged" below.
	-- sets.aftercast.DD.Engaged = set_combine(sets.aftercast.DD.Avatar, {
	-- 	--head="Beckoner's Horn +3",
	-- 	head="Nyame Helm",
	-- 	neck="Shulmanu Collar",
	-- 	ear1="Telos Earring",
	-- 	ear2="Cessance Earring",
	-- 	body="Tali'ah Manteel +2",
	-- 	hands="Bunzi's Gloves",
	-- 	ring1={ name="Chirich Ring +1", bag="wardrobe2" },
	-- 	ring2={ name="Chirich Ring +1", bag="wardrobe4" },
	-- 	back={ name="Campestres's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	-- 	waist="Cetl Belt",
	-- 	legs="Nyame Flanchard",
	-- 	feet="Convoker's Pigaches +3"
	-- })

	-- -- Main melee set when engaged with an avatar out. Usually doesn't have many changes from the above set.
	-- sets.aftercast.DD.Avatar.Engaged = set_combine(sets.aftercast.DD.Engaged, {
	-- })

	-- -- You aren't likely to be in PetDT mode without an avatar for long, but I default to the DT set in that scenario.
	-- sets.aftercast.PetDT = set_combine(sets.aftercast.DT, {
	-- })

	-- -- Pet:DT build. Equipped when IdleMode is "PetDT".
	-- -- Strong alternatives:
	-- -- Selenian Cap, Enmerkar Earring, Handler's Earring, Rimeice Earring, Thurandaut Ring, Tali'ah Seraweels
	-- sets.aftercast.PetDT.Avatar = {
	-- 	main="Nirvana",
	-- 	sub="Oneiros Grip",
	-- 	ammo="Epitaph",
	-- 	head={ name="Apogee Crown +1", augments={'Pet: Accuracy+25','"Avatar perpetuation cost"+7','Pet: Damage taken -4%',}},
	-- 	neck="Summoner's Collar +2",
	-- 	ear1="Enmerkar Earring",
	-- 	ear2="Beckoner's Earring +1",
	-- 	body={ name="Apo. Dalmatica +1", augments={'Summoning magic skill +20','Enmity-6','Pet: Damage taken -4%',}},
	-- 	hands={ name="Telchine Gloves", augments={'Pet: DEF+17','Pet: "Regen"+3','Pet: Damage taken -4%',}},
	-- 	ring1="Thurandaut Ring +1",
	-- 	ring2={name="Stikini Ring +1", bag="wardrobe4"},
	-- 	back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: "Regen"+10','Pet: Damage taken -5%',}},
	-- 	waist="Isa Belt",
	-- 	legs="Enticer's Pants",
	-- 	feet={ name="Telchine Pigaches", augments={'Pet: DEF+14','Pet: "Regen"+3','Pet: Damage taken -4%',}}
	-- }

	-- sets.aftercast.Favor = set_combine(sets.aftercast, {
	-- })

	-- -- Used when IdleMode is "Favor" to maximize avatar's favor effect.
	-- -- Skill tiers are 512 / 575 / 670 / 735
	-- sets.aftercast.Favor.Avatar = set_combine(sets.aftercast.Avatar, {
	-- 	head="Beckoner's Horn +3",
	-- 	--ear2="Lodurr Earring",
	-- 	body="Beckoner's Doublet +3",
	-- 	hands="Baayami Cuffs +1",
	-- 	legs="Baayami Slops +1",
	-- 	feet="Baayami Sabots +1"
	-- })

	-- sets.aftercast.PetDD = set_combine(sets.aftercast, {
	-- })

	-- -- Avatar Melee set. You really don't need this set. It's only here because I can't bring myself to throw it away.
	-- sets.aftercast.PetDD.Avatar = set_combine(sets.aftercast.Avatar, {
	-- 	ear2="Rimeice Earring",
	-- 	body="Glyphic Doublet +3",
	-- 	hands={ name="Helios Gloves", augments={'Pet: Accuracy+22 Pet: Rng. Acc.+22','Pet: "Dbl. Atk."+8','Pet: Haste+6',}},
	-- 	waist="Klouskap Sash",
	-- 	feet={ name="Helios Boots", augments={'Pet: Accuracy+21 Pet: Rng. Acc.+21','Pet: "Dbl. Atk."+8','Pet: Haste+6',}}
	-- })

	-- sets.aftercast.Zendik = set_combine(sets.aftercast, {
	-- 	body="Zendik Robe"
	-- })
	-- sets.aftercast.Zendik.ForceIlvl = set_combine(sets.aftercast.Zendik, {
	-- 	feet="Baayami Sabots +1"
	-- })
	-- sets.aftercast.Zendik.LowMP = set_combine(sets.aftercast.Zendik, {
	-- 	waist="Fucho-no-obi"
	-- })
	-- sets.aftercast.Zendik.LowMP.ForceIlvl = set_combine(sets.aftercast.Zendik.LowMP, {
	-- 	feet="Baayami Sabots +1"
	-- })

	-- sets.aftercast.Zendik.Avatar = set_combine(sets.aftercast.Favor.Avatar, {
	-- 	body="Zendik Robe"
	-- })

	-- -- Idle set used when you have a spirit summoned. Glyphic Spats will make them cast more frequently.
	-- sets.aftercast.Spirit = {
	-- 	main="Nirvana",
	-- 	sub="Vox Grip",
	-- 	ammo="Epitaph",
	-- 	head="Beckoner's Horn +3",
	-- 	neck="Incanter's Torque",
	-- 	ear1="Cath Palug Earring",
	-- 	ear2="Evans Earring",
	-- 	body="Baayami Robe +1",
	-- 	hands="Baayami Cuffs +1",
	-- 	ring1={name="Stikini Ring +1", bag="wardrobe2"},
	-- 	ring2="Evoker's Ring",
	-- 	back={ name="Conveyance Cape", augments={'Summoning magic skill +5','Pet: Enmity+12','Blood Pact Dmg.+2',}},
	-- 	waist="Lucidity Sash",
	-- 	legs="Glyphic Spats +3",
	-- 	feet="Baayami Sabots +1"
	-- }
	-- sets.aftercast.Favor.Spirit = set_combine(sets.aftercast.Spirit, {
	-- })
	-- sets.aftercast.Zendik.Spirit = set_combine(sets.aftercast.Favor.Spirit, {
	-- })

	-- ===================================================================================================================
	--		End of Sets
	-- ===================================================================================================================

	Buff_BPs_Duration = S{'Shining Ruby','Aerial Armor','Frost Armor','Rolling Thunder','Crimson Howl','Lightning Armor','Ecliptic Growl','Glittering Ruby','Earthen Ward','Hastega','Noctoshield','Ecliptic Howl','Dream Shroud','Earthen Armor','Fleet Wind','Inferno Howl','Heavenward Howl','Hastega II','Soothing Current','Crystal Blessing','Katabatic Blades'}
	Buff_BPs_Healing = S{'Healing Ruby','Healing Ruby II','Whispering Wind','Spring Water'}
	Buff_BPs_MND = S{"Wind's Blessing"}
	Debuff_BPs = S{'Mewing Lullaby','Eerie Eye','Lunar Cry','Lunar Roar','Nightmare','Pavor Nocturnus','Ultimate Terror','Somnolence','Slowga','Tidal Roar','Diamond Storm','Sleepga','Shock Squall','Bitter Elegy','Lunatic Voice'}
	Debuff_Rage_BPs = S{'Moonlit Charge','Tail Whip'}

	Magic_BPs_NoTP = S{'Holy Mist','Nether Blast','Aerial Blast','Searing Light','Diamond Dust','Earthen Fury','Zantetsuken','Tidal Wave','Judgment Bolt','Inferno','Howling Moon','Ruinous Omen','Night Terror','Thunderspark','Tornado II','Sonic Buffet'}
	Magic_BPs_TP = S{'Impact','Conflag Strike','Level ? Holy','Lunar Bay'}
	Merit_BPs = S{'Meteor Strike','Geocrush','Grand Fall','Wind Blade','Heavenly Strike','Thunderstorm'}
	Physical_BPs_TP = S{'Rock Buster','Mountain Buster','Crescent Fang','Spinning Dive','Roundhouse'}
	
	ZodiacElements = S{'Fire','Earth','Water','Wind','Ice','Lightning'}

	--TownIdle = S{"windurst woods","windurst waters","windurst walls","port windurst","bastok markets","bastok mines","port bastok","southern san d'oria","northern san d'oria","port san d'oria","upper jeuno","lower jeuno","port jeuno","ru'lude gardens","norg","kazham","tavnazian safehold","rabao","selbina","mhaura","aht urhgan whitegate","al zahbi","nashmau","western adoulin","eastern adoulin"}
	--Salvage = S{"Bhaflau Remnants","Zhayolm Remnants","Arrapago Remnants","Silver Sea Remnants"}

	-- Select initial macro set and set lockstyle
	-- This section likely requires changes or removal if you aren't Pergatory
	-- NOTE: This doesn't change your macro set for you during play, your macros have to do that. This is just for when the Lua is loaded.
	if pet.isvalid then
		if pet.name=='Fenrir' then
			send_command('xivhotbar next_environment fenrir;input /lockstyleset '..StartLockStyle)
		elseif pet.name=='Ifrit' then
			send_command('xivhotbar next_environment ifrit;input /lockstyleset '..StartLockStyle)
		elseif pet.name=='Titan' then
			send_command('xivhotbar next_environment titan;input /lockstyleset '..StartLockStyle)
		elseif pet.name=='Leviathan' then
			send_command('xivhotbar next_environment leviathan;input /lockstyleset '..StartLockStyle)
		elseif pet.name=='Garuda' then
			send_command('xivhotbar next_environment garuda;input /lockstyleset '..StartLockStyle)
		elseif pet.name=='Shiva' then
			send_command('xivhotbar next_environment shiva;input /lockstyleset '..StartLockStyle)
		elseif pet.name=='Ramuh' then
			send_command('xivhotbar next_environment ramuh;input /lockstyleset '..StartLockStyle)
		elseif pet.name=='Diabolos' then
			send_command('xivhotbar next_environment diabolos;input /lockstyleset '..StartLockStyle)
		elseif pet.name=='Cait Sith' then
			send_command('xivhotbar next_environment cait_sith;input /lockstyleset '..StartLockStyle)
		elseif pet.name=='Siren' then
			send_command('xivhotbar next_environment siren;input /lockstyleset '..StartLockStyle)
		end
	else
		send_command('xivhotbar next_environment field;input /lockstyleset '..StartLockStyle)
	end
	-- End macro set / lockstyle section
end

-- ===================================================================================================================
--		Gearswap rules below this point - Modify at your own peril
-- ===================================================================================================================

function pretarget(spell,action)
	if not buffactive['Muddle'] then
		-- Auto Remedy --
		if AutoRemedy and (spell.action_type == 'Magic' or spell.type == 'JobAbility') then
			if buffactive['Paralysis'] or (buffactive['Silence'] and not AutoEcho) then
				cancel_spell()
				send_command('input /item "Remedy" <me>')
			end
		end
		-- Auto Echo Drop --
		if AutoEcho and spell.action_type == 'Magic' and buffactive['Silence'] then
			cancel_spell()
			send_command('input /item "Echo Drops" <me>')
		end
	end
end

function precast(spell)
    if (pet.isvalid and pet_midaction() and not spell.type=="SummonerPact") or spell.type=="Item" then
		-- Do not swap if pet is mid-action. I added the type=SummonerPact check because sometimes when the avatar
		-- dies mid-BP, pet.isvalid and pet_midaction() continue to return true for a brief time.
		return
	end
	-- Spell fast cast
	if sets.precast[spell.english] then
        equip(sets.precast[spell.english])
    elseif spell.action_type=="Magic" then
		if spell.name=="Stoneskin" then
			equip(sets.precast.FC,{waist="Siegel Sash"})
		else
			equip(sets.precast.FC)
		end
    end
end

function midcast(spell)
    if (pet.isvalid and pet_midaction()) or spell.type=="Item" then
        return
    end
	-- BP Timer gear needs to swap here
	if (spell.type=="BloodPactWard" or spell.type=="BloodPactRage") then
		if not buffactive["Astral Conduit"] then
			equip(sets.midcast.BP)
		end
		-- If lag compensation mode is on, set up a timer to equip the BP gear.
		if LagMode then
			send_command('wait 0.5;gs c EquipBP '..spell.name)
		end
	-- Spell Midcast & Potency Stuff
    elseif sets.midcast[spell.english] then
        equip(sets.midcast[spell.english])
	elseif spell.name=="Elemental Siphon" then
		if pet.element==world.day_element and ZodiacElements:contains(pet.element) then
			if pet.element==world.weather_element then
				equip(sets.midcast.Siphon.WeatherZodiac)
			else
				equip(sets.midcast.Siphon.Zodiac)
			end
		else
			if pet.element==world.weather_element then
				equip(sets.midcast.Siphon.Weather)
			else
				equip(sets.midcast.Siphon)
			end
		end
	elseif spell.type=="SummonerPact" then
		equip(sets.midcast.Summoning)
	elseif string.find(spell.name,"Cure") or string.find(spell.name,"Curaga") then
		equip(sets.midcast.Cure)
	elseif string.find(spell.name,"Protect") or string.find(spell.name,"Shell") then
		equip(sets.midcast.Enhancing,{ring2="Sheltered Ring"})
	elseif spell.skill=="Enfeebling Magic" then
		equip(sets.midcast.Enfeeble)
	elseif spell.skill=="Enhancing Magic" then
		equip(sets.midcast.Enhancing)
	elseif spell.skill=="Elemental Magic" then
		equip(sets.midcast.Nuke)
	elseif spell.action_type=="Magic" then
		equip(sets.midcast.EnmityRecast)
    else
        idle()
    end
	-- Treasure Hunter
	if TreasureHunter and THSpells:contains(spell.name) then
		equip(sets.TH)
	end
	-- Auto-cancel existing buffs
	if spell.name=="Stoneskin" and buffactive["Stoneskin"] then
		windower.send_command('cancel 37;')
	elseif spell.name=="Sneak" and buffactive["Sneak"] and spell.target.type=="SELF" then
		windower.send_command('cancel 71;')
	elseif spell.name=="Utsusemi: Ichi" and buffactive["Copy Image"] then
		windower.send_command('wait 1;cancel 66;')
	end
end

function aftercast(spell)
    if pet_midaction() or spell.type=="Item" then
        return
    end
	if not string.find(spell.type,"BloodPact") then
        idle()
    end
end

function pet_change(pet,gain)
	if (not (gain and pet_midaction())) then
		idle()
	end
end

function status_change(new,old)
	if not midaction() and not pet_midaction() then
        idle()
	end
end

function buff_change(name,gain)
    if name=="quickening" and not pet_midaction() then
        idle()
    end
	if SacTorque and name=="sleep" and gain and pet.isvalid then
		equip({neck="Sacrifice Torque"})
		disable("neck")
		if buffactive["Stoneskin"] then
			windower.send_command('cancel 37;')
		end
	end
	if SacTorque and name=="sleep" and not gain then
		enable("neck")
	end
end

function pet_midcast(spell)
	if not LagMode then
		equipBPGear(spell.name)
	end
end

function pet_aftercast(spell)
    idle()
end

function equipBPGear(spell)
    if spell=="Perfect Defense" then
        equip(sets.pet_midcast.SummoningMagic)
	elseif Debuff_BPs:contains(spell) then
		equip(sets.pet_midcast.MagicAcc.BP)
	elseif Buff_BPs_Healing:contains(spell) then
		equip(sets.pet_midcast.Buff.Healing)
	elseif Buff_BPs_Duration:contains(spell) then
		equip(sets.pet_midcast.Buff)
	elseif Buff_BPs_MND:contains(spell) then
		equip(sets.pet_midcast.Buff.MND)
	elseif spell=="Flaming Crush" then
		if AccMode then
			equip(sets.pet_midcast.FlamingCrush.Acc)
		else
			equip(sets.pet_midcast.FlamingCrush)
		end
	elseif ImpactDebuff and (spell=="Impact" or spell=="Conflag Strike") then
		equip(sets.pet_midcast.Impact)
	elseif Magic_BPs_NoTP:contains(spell) then
		if AccMode then
			equip(sets.pet_midcast.Magic.BP.NoTP.Acc)
		else
			equip(sets.pet_midcast.Magic.BP.NoTP)
		end
	elseif Magic_BPs_TP:contains(spell) or string.find(spell," II") or string.find(spell," IV") then
		if AccMode then
			equip(sets.pet_midcast.Magic.BP.TP.Acc)
		else
			equip(sets.pet_midcast.Magic.BP.TP)
		end
	elseif Merit_BPs:contains(spell) then
		if AccMode then
			equip(sets.pet_midcast.Magic.BP.TP.Acc)
		elseif spell=="Meteor Strike" and MeteorStrike>4 then
			equip(sets.pet_midcast.Magic.BP.NoTP)
		elseif spell=="Geocrush" and Geocrush>4 then
			equip(sets.pet_midcast.Magic.BP.NoTP)
		elseif spell=="Grand Fall" and GrandFall>4 then
			equip(sets.pet_midcast.Magic.BP.NoTP)
		elseif spell=="Wind Blade" and WindBlade>4 then
			equip(sets.pet_midcast.Magic.BP.NoTP)
		elseif spell=="Heavenly Strike" and HeavenlyStrike>4 then
			equip(sets.pet_midcast.Magic.BP.NoTP)
		elseif spell=="Thunderstorm" and Thunderstorm>4 then
			equip(sets.pet_midcast.Magic.BP.NoTP)
		else
			equip(sets.pet_midcast.Magic.BP.TP)
		end
	elseif Debuff_Rage_BPs:contains(spell) then
		equip(sets.pet_midcast.Debuff.Rage)
	else
		if AccMode then
			equip(sets.pet_midcast.Physical.BP.Acc)
		elseif Physical_BPs_TP:contains(spell) then
			equip(sets.pet_midcast.Physical.BP.TP)
		elseif buffactive["Aftermath: Lv.3"] then
			equip(sets.pet_midcast.Physical.BP.AM3)
		else
			equip(sets.pet_midcast.Physical.BP)
		end
	end
	-- Custom Timers
	if spell=="Mewing Lullaby" and string.find(world.area,"Walk of Echoes %[P") then
		send_command('timers create "Mewing Resist: can go @ 30s" 60 down') -- In Gaol, underperforms if used every 20s. 60s is full potency.
		-- Tip: I found it was best to go after 30 seconds. It doesn't fully drain them but you can't afford to wait the full 60.
		-- Use the time between this to use BP:Rages for additional damage! They feed no TP, as long as your avatar doesn't attack.
	end
end

-- This command is called whenever you input "gs c <command>"
function self_command(command)
	is_valid = command:lower()=="idle"
	
	for _, v in ipairs(IdleModes) do
		if command:lower()==v:lower() then
			IdleMode = v
			send_command('console_echo "Idle Mode: ['..IdleMode..']"')
			idle()
			return
		end
	end
	if string.sub(command,1,7)=="EquipBP" then
		equipBPGear(string.sub(command,9,string.len(command)))
		return
	elseif command:lower()=="accmode" then
		AccMode = AccMode==false
		is_valid = true
		send_command('console_echo "AccMode: '..tostring(AccMode)..'"')
	elseif command:lower()=="impactmode" then
		ImpactDebuff = ImpactDebuff==false
		is_valid = true
		send_command('console_echo "Impact Debuff: '..tostring(ImpactDebuff)..'"')
    elseif command:lower()=="forceilvl" then
        ForceIlvl = ForceIlvl==false
        is_valid = true
        send_command('console_echo "Force iLVL: '..tostring(ForceIlvl)..'"')
	elseif command:lower()=="lagmode" then
		LagMode = LagMode==false
		is_valid = true
		send_command('console_echo "Lag Compensation Mode: '..tostring(LagMode)..'"')
	elseif command:lower()=="th" then
		TreasureHunter = TreasureHunter==false
		is_valid = true
		send_command('console_echo "Treasure Hunter Mode: '..tostring(TreasureHunter)..'"')
	elseif command:lower()=="weaponlock" then
		if WeaponLock then
			enable("main","sub")
			WeaponLock = false
		else
			equip({main="Nirvana",sub="Elan Strap +1"})
			disable("main","sub")
			WeaponLock = true
		end
		is_valid = true
		send_command('console_echo "Weapon Lock: '..tostring(WeaponLock)..'"')
	elseif command=="ToggleIdle" then
		is_valid = true
		-- If you want to change the sets cycled with F9, this is where you do it
		if IdleMode=="Refresh" then
			IdleMode = "DT"
		elseif IdleMode=="DT" then
			IdleMode = "PetDT"
		elseif IdleMode=="PetDT" then
			IdleMode = "DD"
		else
			IdleMode = "Refresh"
		end
		send_command('console_echo "Idle Mode: ['..IdleMode..']"')
	elseif command:lower()=="lowhp" then
		-- Use for "Cure 500 HP" objectives in Omen
		equip({head="Apogee Crown +1",body={ name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},legs="Apogee Slacks +1",feet="Apogee Pumps +1",back="Campestres's Cape"})
		return
	elseif string.sub(command:lower(),1,12)=="meteorstrike" then
		MeteorStrike = string.sub(command,13,13)
		send_command('console_echo "Meteor Strike: '..MeteorStrike..'/5"')
		is_valid = true
	elseif string.sub(command:lower(),1,8)=="geocrush" then
		Geocrush = string.sub(command,9,9)
		send_command('console_echo "Geocrush: '..Geocrush..'/5"')
		is_valid = true
	elseif string.sub(command:lower(),1,9)=="grandfall" then
		GrandFall = string.sub(command,10,10)
		send_command('console_echo "Grand Fall: '..GrandFall..'/5"')
		is_valid = true
	elseif string.sub(command:lower(),1,9)=="windblade" then
		WindBlade = +string.sub(command,10,10)
		send_command('console_echo "Wind Blade: '..WindBlade..'/5"')
		is_valid = true
	elseif string.sub(command:lower(),1,14)=="heavenlystrike" then
		HeavenlyStrike = string.sub(command,15,15)
		send_command('console_echo "Heavenly Strike: '..HeavenlyStrike..'/5"')
		is_valid = true
	elseif string.sub(command:lower(),1,12)=="thunderstorm" then
		Thunderstorm = string.sub(command,13,13)
		send_command('console_echo "Thunderstorm: '..Thunderstorm..'/5"')
		is_valid = true
	end

	if is_valid then
		if not midaction() and not pet_midaction() then
			idle()
		end
	else
		sanitized = command:gsub("\"", "")
		send_command('console_echo "Invalid self_command: '..sanitized..'"') -- Note: If you use Gearinfo, comment out this line
	end
end

-- This function is for returning to aftercast gear after an action/event.
function idle()
	--if TownIdle:contains(world.area:lower()) then
	--	return
	--end
	local equipSet = sets.aftercast or {}
	if equipSet[IdleMode] then
		equipSet = equipSet[IdleMode]
	end
	if pet.isvalid then
		if equipSet[pet.name] then
			equipSet = equipSet[pet.name]
		elseif string.find(pet.name,'Spirit') and equipSet["Spirit"] then
			equipSet = equipSet["Spirit"]
		elseif equipSet["Avatar"] then
			equipSet = equipSet["Avatar"]
		end
	end
	if equipSet[player.status] then
		equipSet = equipSet[player.status]
	end
	if player.mpp < 50 and equipSet["LowMP"] then
		equipSet = equipSet["LowMP"]
	end
	if ForceIlvl and equipSet["ForceIlvl"] then
		equipSet = equipSet["ForceIlvl"]
	end
	equip(equipSet)

	if (buffactive['Quickening'] or buffactive['Sneak'] or buffactive['Invisible']) and IdleMode~='DT' and not ForceIlvl then
		equip(sets.Movement)
	end
	-- Balrahn's Ring
	--if Salvage:contains(world.area) then
	--	equip({ring2="Balrahn's Ring"})
	--end
	-- Maquette Ring
	--if world.area=='Maquette Abdhaljs-Legion' and not IdleMode=='DT' then
	--	equip({ring2="Maquette Ring"})
	--end
end