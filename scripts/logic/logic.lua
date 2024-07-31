-- put logic functions here using the Lua API: https://github.com/black-sliver/PopTracker/blob/master/doc/PACKS.md#lua-interface
-- don't be afraid to use custom logic functions. it will make many things a lot easier to maintain, for example by adding logging.
-- to see how this function gets called, check: locations/locations.json
-- example:
function has_more_then_n_consumable(name, n)
    local count = Tracker:ProviderCountForCode(name)
    local val = (count >= tonumber(n))
    if val then
        return 1 -- 1 => access is in logic
    end
    return 0 -- 0 => no access
end

function has_key_pieces()
    local count = Tracker:ProviderCountForCode("keypiece")
    local req = Tracker:ProviderCountForCode("req_pieces")
    local val = (count >= req)
    if val then
        return 1 -- 1 => access is in logic
    end
    return 0 -- 0 => no access
end

function is_route(name)
    local count = Tracker:ProviderCountForCode(name)
    return count
end

function has_more_then_n_kills(name, n)
    local pack_size = Tracker:ProviderCountForCode('kill_sanity_pack_size')
    local count = Tracker:ProviderCountForCode(name) * pack_size
    local val = (count >= tonumber(n))
    if val or Tracker:ProviderCountForCode('killsanity_enabled') == 0 then
        return 1 -- 1 => access is in logic
    end
    return 0 -- 0 => no access
end

function has_more_then_n_spares(name, n)
    local pack_size = Tracker:ProviderCountForCode('spare_sanity_pack_size')
    local count = Tracker:ProviderCountForCode(name) * pack_size
    local val = (count >= tonumber(n))
    if val or Tracker:ProviderCountForCode('sparesanity_enabled') == 0 then
        return 1 -- 1 => access is in logic
    end
    return 0 -- 0 => no access
end

function exp_available()
    local exp = 0
    local pack_size = Tracker:ProviderCountForCode('kill_sanity_pack_size')
    local killsanity = Tracker:ProviderCountForCode('killsanity_enabled')
    if killsanity == 0 then
        killsanity = 40
    else
        killsanity = 0
    end
    if Tracker:ProviderCountForCode('ruins') == 1 then
        exp = exp + (math.min(20, Tracker:ProviderCountForCode('ruins_kills') * pack_size + killsanity) * 2)
        if Tracker:ProviderCountForCode('ruins_kills') * pack_size + killsanity >= 20 then
            exp = exp + 150
        end
    end
    if Tracker:ProviderCountForCode('snowdin') == 1 then
        exp = exp + (math.min(15, Tracker:ProviderCountForCode('snowdin_kills') * pack_size + killsanity) * 1)
        exp = exp + 170
        if Tracker:ProviderCountForCode('snowdin_kills') * pack_size + killsanity >= 16 then
            exp = exp + 222
        end
    end
    if Tracker:ProviderCountForCode('waterfall') == 1 then
        exp = exp + (math.min(18, Tracker:ProviderCountForCode('waterfall_kills') * pack_size + killsanity) * 3)
        exp = exp + 52
        if Tracker:ProviderCountForCode('item') == 1 and Tracker:ProviderCountForCode('waterfall_kills') * pack_size + killsanity >= 18 then
            exp = exp + 1500
        end
    end
    if Tracker:ProviderCountForCode('hotland') == 1 then
        exp = exp + 220
        exp = exp + 300
        exp = exp + (math.min(40, Tracker:ProviderCountForCode('hotland_kills') * pack_size + killsanity) * 70)
        if Tracker:ProviderCountForCode('hotland_kills') * pack_size + killsanity >= 40 then
            exp = 50000
        end
    end
    if Tracker:ProviderCountForCode('item') == 1 and Tracker:ProviderCountForCode('jump') == 1 and (has_key_pieces() == 1 or (Tracker:ProviderCountForCode('leftKey') == 1 and Tracker:ProviderCountForCode('rightKey') == 1)) then
        exp = 99999
    end
    return exp
end

function reachable_level(n)
    local lvl = 1
    local exp = exp_available()
    if exp >= 10 and lvl == 1 then
        lvl = lvl + 1
    end
    if exp >= 30 and lvl == 2 then
        lvl = lvl + 1
    end
    if exp >= 70 and lvl == 3 then
        lvl = lvl + 1
    end
    if exp >= 120 and lvl == 4 then
        lvl = lvl + 1
    end
    if exp >= 200 and lvl == 5 then
        lvl = lvl + 1
    end
    if exp >= 300 and lvl == 6 then
        lvl = lvl + 1
    end
    if exp >= 500 and lvl == 7 then
        lvl = lvl + 1
    end
    if exp >= 800 and lvl == 8 then
        lvl = lvl + 1
    end
    if exp >= 1200 and lvl == 9 then
        lvl = lvl + 1
    end
    if exp >= 1700 and lvl == 10 then
        lvl = lvl + 1
    end
    if exp >= 2500 and lvl == 11 then
        lvl = lvl + 1
    end
    if exp >= 3500 and lvl == 12 then
        lvl = lvl + 1
    end
    if exp >= 5000 and lvl == 13 then
        lvl = lvl + 1
    end
    if exp >= 7000 and lvl == 14 then
        lvl = lvl + 1
    end
    if exp >= 10000 and lvl == 15 then
        lvl = lvl + 1
    end
    if exp >= 15000 and lvl == 16 then
        lvl = lvl + 1
    end
    if exp >= 25000 and lvl == 17 then
        lvl = lvl + 1
    end
    if exp >= 50000 and lvl == 18 then
        lvl = lvl + 1
    end
    if exp >= 99999 and lvl == 19 then
        lvl = lvl + 1
    end
    local val = (lvl >= tonumber(n))
    if val then
        return 1 -- 1 => access is in logic
    end
    return 0 -- 0 => no access
end