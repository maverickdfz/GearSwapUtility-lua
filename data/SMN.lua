function get_sets()
	-- Load and initialize the include file.
    mote_include_version = 2
	include('Mote-Include.lua')
    include('organizer-lib')
    
    local setsUtil = include('SMN-sets')
    sets = setsUtil.apply(sets)

    magicalRagePacts = S{'Inferno','Earthen Fury','Tidal Wave','Aerial Blast','Diamond Dust','Judgment Bolt','Searing Light','Howling Moon','Ruinous Omen','Clarsach Call','Impact','Fire II','Stone II','Water II','Aero II','Blizzard II','Thunder II','Fire IV','Stone IV','Water IV','Aero IV','Blizzard IV','Thunder IV','Thunderspark','Burning Strike','Meteorite','Nether Blast','Flaming Crush','Meteor Strike','Conflag Strike','Heavenly Strike','Wind Blade','Geocrush','Grand Fall','Thunderstorm','Holy Mist','Lunar Bay','Night Terror','Level ? Holy','Tornado II','Sonic Buffet'}

    Buff_BPs_Duration = S{'Shining Ruby','Aerial Armor','Frost Armor','Rolling Thunder','Crimson Howl','Lightning Armor','Ecliptic Growl','Glittering Ruby','Earthen Ward','Hastega','Noctoshield','Ecliptic Howl','Dream Shroud','Earthen Armor','Fleet Wind','Inferno Howl','Heavenward Howl','Hastega II','Soothing Current','Crystal Blessing','Katabatic Blades'}
	Buff_BPs_Healing = S{'Healing Ruby','Healing Ruby II','Whispering Wind','Spring Water'}
	Buff_BPs_MND = S{"Wind's Blessing"}
	Debuff_BPs = S{'Mewing Lullaby','Eerie Eye','Lunar Cry','Lunar Roar','Nightmare','Pavor Nocturnus','Ultimate Terror','Somnolence','Slowga','Tidal Roar','Diamond Storm','Sleepga','Shock Squall','Bitter Elegy','Lunatic Voice'}
	Debuff_Rage_BPs = S{'Moonlit Charge','Tail Whip'}

	Magic_BPs_NoTP = S{'Holy Mist','Nether Blast','Aerial Blast','Searing Light','Diamond Dust','Earthen Fury','Zantetsuken','Tidal Wave','Judgment Bolt','Inferno','Howling Moon','Ruinous Omen','Night Terror','Thunderspark','Tornado II','Sonic Buffet'}
	Magic_BPs_TP = S{'Impact','Conflag Strike','Level ? Holy','Lunar Bay'}
	Merit_BPs = S{'Meteor Strike','Geocrush','Grand Fall','Wind Blade','Heavenly Strike','Thunderstorm'}
	Physical_BPs_TP = S{'Rock Buster','Mountain Buster','Crescent Fang','Spinning Dive','Roundhouse'}
end

function init_gear_sets()
end

-- Setup vars that are user-independent.
function job_setup()
    include('Mote-TreasureHunter')
    state.TreasureMode:set('None')

    state.Buff.Apogee = buffactive.apogee or false
    state.Buff['Astral Flow'] = buffactive['Astral Flow'] or false
    state.Buff['Astral Conduit'] = buffactive['Astral Conduit'] or false
end

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal', 'Mid', 'Acc')
    state.HybridMode:options('Normal', 'PDT')
    state.WeaponskillMode:options('Normal', 'Mid', 'Acc')
    state.IdleMode:options('Normal', 'Sphere')
    state.RestingMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')
    state.MagicalDefenseMode:options('MDT')
    
    -- Additional local binds
    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind ^[ input /lockstyle on')
    send_command('bind ![ input /lockstyle off')
    send_command('bind != gs c toggle CapacityMode')
end

function job_pet_change(petparam, gain)
end

function job_pet_status_change(newStatus, oldStatus, eventArgs)
end

function job_precast(spell, action, spellMap, eventArgs)
    if (pet.isvalid and pet_midaction()) or spell.type=="Item" then
		eventArgs.handled = true
    end
    if spell.target.type == 'SELF' then
        local equipmentSet = get_precast_set(spell, spellMap)
        local set = 'Self'
        if equipmentSet[set] then
            equip(equipmentSet[set])
            display_breadcrumbs(spell, spellMap, action)
            eventArgs.handled = true
        end
    end
    if spell.type:startswith('BloodPact') and buffactive["Astral Conduit"] then
        local equipmentSet = get_midcast_set(spell, spellMap)
        equip(equipmentSet[set])
        eventArgs.handled = true
    elseif spell.type == 'BloodPactRage' then
        if magicalRagePacts:contains(spell.english) then
            local equipmentSet = get_precast_set(spell, spellMap)
            local set = 'Magical'
            if equipmentSet[set] then
                equip(equipmentSet[set])
                display_breadcrumbs(spell, spellMap, action)
                eventArgs.handled = true
            end
        else
            local equipmentSet = get_precast_set(spell, spellMap)
            local set = 'Physical'
            if equipmentSet[set] then
                equip(equipmentSet[set])
                display_breadcrumbs(spell, spellMap, action)
                eventArgs.handled = true
            end
        end
    end
end

function job_midcast(spell, action, spellMap, eventArgs)
    if (pet.isvalid and pet_midaction()) or spell.type=="Item" then
        eventArgs.handled = true
    end
    if spell.target.type == 'SELF' then
        local equipmentSet = get_midcast_set(spell, spellMap)
        local set = 'Self'
        if equipmentSet[set] then
            equip(equipmentSet[set])
            display_breadcrumbs(spell, spellMap, action)
            eventArgs.handled = true
        end
    end
    if spell.type == 'BloodPactRage' then
        if magicalRagePacts:contains(spell.english) then
            local equipmentSet = get_midcast_set(spell, spellMap)
            local set = 'Magical'
            if equipmentSet[set] then
                equip(equipmentSet[set])
                display_breadcrumbs(spell, spellMap, action)
                eventArgs.handled = true
            end
        else
            local equipmentSet = get_midcast_set(spell, spellMap)
            local set = 'Physical'
            if equipmentSet[set] then
                equip(equipmentSet[set])
                display_breadcrumbs(spell, spellMap, action)
                eventArgs.handled = true
            end
        end
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

function job_aftercast(spell, action, spellMap, eventArgs)
    if pet_midaction() or spell.type=="Item" then
        eventArgs.handled = true
    end
end

function job_pet_aftercast(spell, action, spellMap, eventArgs)
end

function job_status_change(newStatus, oldStatus, eventArgs)
end

function job_buff_change(buff, gain)
end

function job_pet_midcast(spell, action, spellMap, eventArgs)
end

function job_pet_aftercast(spell, action, spellMap, eventArgs)
end