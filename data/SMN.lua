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

local PrecastMode = 'Normal'

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
    --state.PrecastMode:options('Normal', 'Astral Conduit')
    
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

function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ',' .. "\n"
       end
       return s .. '} '
    else
       return tostring(o)
    end
 end

function job_precast(spell, action, spellMap, eventArgs)
    --print(action)
    if (pet.isvalid and pet_midaction()) or spell.type=="Item" then
		eventArgs.handled = true
    end
    --print(dump(spell))
    --print(action)
    --print(spellMap)
    if spell.type:startswith('BloodPact') then
        --print('Blood Pact')
        if buffactive['Astral Conduit'] then
            print('Astral Conduit')
            if magicalRagePacts:contains(spell.english) then
                --print('Blood Pact Rage Magical')
                if sets.midcast.BloodPactRage.Magical then
                    if sets.midcast.BloodPactRage.Magical[spell.name] then
                        equip(sets.midcast.BloodPactRage.Magical[spell.name])
                        eventArgs.handled = true
                    elseif sets.midcast.BloodPactRage.Magical[pet.name] then
                        --print('Blood Pact Rage Magical Pet')
                        equip(sets.midcast.BloodPactRage.Magical[pet.name])
                        eventArgs.handled = true
                    else
                        --print('Blood Pact Rage Magical Not Pet')
                        equip(sets.midcast.BloodPactRage.Magical)
                        eventArgs.handled = true
                    end
                end
            else
                --print('Blood Pact Rage Physical')
                if sets.midcast.BloodPactRage.Physical then
                    if sets.midcast.BloodPactRage.Physical[spell.name] then
                        --print('Blood Pact Rage Physical Pet')
                        equip(sets.midcast.BloodPactRage.Physical[spell.name])
                        eventArgs.handled = true
                    elseif sets.midcast.BloodPactRage.Physical[pet.name] then
                        --print('Blood Pact Rage Physical Pet')
                        equip(sets.midcast.BloodPactRage.Physical[pet.name])
                        eventArgs.handled = true
                    else
                        --print('Blood Pact Rage Physical Not Pet')
                        equip(sets.midcast.BloodPactRage.Physical)
                        eventArgs.handled = true
                    end
                end
            end
            if not eventArgs.handled then
                --print('Blood Pact Rage')
                if sets.midcast.BloodPactRage[spell.name] then
                    equip(sets.midcast.BloodPactRage[spell.name])
                    eventArgs.handled = true
                elseif sets.midcast.BloodPactRage[pet.name] then
                    equip(sets.midcast.BloodPactRage[pet.name])
                    eventArgs.handled = true
                else
                    equip(sets.midcast.BloodPactRage)
                    eventArgs.handled = true
                end
            end
        elseif spell.type == 'BloodPactRage' then
            --print('Blood Pact Rage')
            if magicalRagePacts:contains(spell.english) then
                --print('Blood Pact Rage Magical')
                if sets.precast.BloodPactRage.Magical then
                    if sets.precast.BloodPactRage.Magical[spell.name] then
                        --print('Blood Pact Rage Magical Pet')
                        equip(sets.precast.BloodPactRage.Magical[spell.name])
                        eventArgs.handled = true
                    elseif sets.precast.BloodPactRage.Magical[pet.name] then
                        --print('Blood Pact Rage Magical Pet')
                        equip(sets.precast.BloodPactRage.Magical[pet.name])
                        eventArgs.handled = true
                    else
                        --print('Blood Pact Rage Magical Not Pet')
                        equip(sets.precast.BloodPactRage.Magical)
                        eventArgs.handled = true
                    end
                end
            else
                --print('Blood Pact Rage Physical')
                if sets.precast.BloodPactRage.Physical then
                    if sets.precast.BloodPactRage.Physical[spell.name] then
                        --print('Blood Pact Rage Physical Pet')
                        equip(sets.precast.BloodPactRage.Physical[spell.name])
                        eventArgs.handled = true
                    elseif sets.precast.BloodPactRage.Physical[pet.name] then
                        --print('Blood Pact Rage Physical Pet')
                        equip(sets.precast.BloodPactRage.Physical[pet.name])
                        eventArgs.handled = true
                    else
                        --print('Blood Pact Rage Physical Not Pet')
                        equip(sets.precast.BloodPactRage.Physical)
                        eventArgs.handled = true
                    end
                end
            end
            if not eventArgs.handled then
                --print('Blood Pact Rage')
                if sets.midcast.BloodPactRage[spell.name] then
                    equip(sets.midcast.BloodPactRage[spell.name])
                    eventArgs.handled = true
                elseif sets.midcast.BloodPactRage[pet.name] then
                    equip(sets.midcast.BloodPactRage[pet.name])
                    eventArgs.handled = true
                end
            end
        end
    else
        if spell.target.type == 'SELF' then
            local equipmentSet = get_precast_set(spell, spellMap)
            local set = 'Self'
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
    if spell.type == 'BloodPactRage' then
        if magicalRagePacts:contains(spell.english) then
            if sets.midcast.BloodPactRage.Magical then
                if sets.midcast.BloodPactRage.Magical[spell.name] then
                    equip(sets.midcast.BloodPactRage.Magical[spell.name])
                    eventArgs.handled = true
                elseif sets.midcast.BloodPactRage.Magical[pet.name] then
                    equip(sets.midcast.BloodPactRage.Magical[pet.name])
                    eventArgs.handled = true
                else
                    equip(sets.midcast.BloodPactRage.Magical)
                    eventArgs.handled = true
                end
            end
        else
            if sets.midcast.BloodPactRage.Physical then
                if sets.midcast.BloodPactRage.Physical[spell.name] then
                    equip(sets.midcast.BloodPactRage.Physical[spell.name])
                    eventArgs.handled = true
                elseif sets.midcast.BloodPactRage.Physical[pet.name] then
                    equip(sets.midcast.BloodPactRage.Physical[pet.name])
                    eventArgs.handled = true
                else
                    equip(sets.midcast.BloodPactRage.Physical)
                    eventArgs.handled = true
                end
            end
        end
        if not eventArgs.handled then
            if sets.midcast.BloodPactRage[spell.name] then
                equip(sets.midcast.BloodPactRage[spell.name])
                eventArgs.handled = true
            elseif sets.midcast.BloodPactRage[pet.name] then
                equip(sets.midcast.BloodPactRage[pet.name])
                eventArgs.handled = true
            end
        end
    end
end

function job_pet_aftercast(spell, action, spellMap, eventArgs)
end