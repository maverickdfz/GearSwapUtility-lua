-- Initialization function for this job file.
function get_sets()
	-- Load and initialize the include file.
    mote_include_version = 2
	include('Mote-Include.lua')
    include('organizer-lib')
    
    local setsUtil = include('PLD-sets')
    sets = setsUtil.apply(sets)
end

function init_gear_sets()
end

-- Setup vars that are user-independent.
function job_setup()
    include('Mote-TreasureHunter')
    state.TreasureMode:set('None')

    state.Buff.Composure = buffactive.composure or false
    state.Buff.Temper = buffactive.temper or false
    
    update_buffs()
end

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal', 'Mid', 'Acc', 'Enmity')
    state.CastingMode:options('Normal', 'Resistant', 'Burst', 'Enfeebling')
    state.HybridMode:options('Normal', 'PDT', 'Enmity')
    state.WeaponskillMode:options('Normal', 'Mid', 'Acc')
    state.IdleMode:options('Normal', 'DT', 'Sphere', 'Enmity')
    state.RestingMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')
    state.MagicalDefenseMode:options('MDT')
    
    -- Additional local binds
    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind ^[ input /lockstyle on')
    send_command('bind ![ input /lockstyle off')
    send_command('bind != gs c toggle CapacityMode')
end

-- Called when this job file is unloaded (eg: job change)
function file_unload()
    send_command('unbind ^[')
    send_command('unbind !=')
    send_command('unbind ![')
end

function update_buffs()
    state.Buff['Divine Emblem'] = buffactive['Divine Emblem'] or false
    state.Buff['Holy Circle'] = buffactive['Holy Circle'] or false
    
    state.Buff['Invincible'] = buffactive['Invincible'] or false
    state.Buff['Sentinel'] = buffactive['Sentinel'] or false
    state.Buff['Cover'] = buffactive['Cover'] or false
end

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)
    if state.Buff[spell.english] ~= nil then
        state.Buff[spell.english] = true
    end
end

function job_precast(spell, action, spellMap, eventArgs)

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

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
    if (spell.name == 'Spectral Jig' or spell.name == 'Sneak') and buffactive.sneak then
            -- If sneak is active when using, cancel before completion
            send_command('cancel 71')
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)

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

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	if state.Buff[spell.english] ~= nil then
		state.Buff[spell.english] = not spell.interrupted or buffactive[spell.english]
	end
end

function job_status_change(newStatus, oldStatus, eventArgs)

end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
    	state.Buff[buff] = gain
        handle_equipping_gear(player.status)
    end

    if S{'madrigal'}:contains(buff:lower()) then
        if buffactive.madrigal and state.OffenseMode.value == 'Acc' then
            equip(sets.MadrigalBonus or {})
        end
    end
    
    if not midaction() then
        handle_equipping_gear(player.status)
    end
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    update_buffs()
end