obs = obslua

local target_scenes = {"Graphics - 1", "Graphics - 2", "Graphics - 3"}

-- Logic for Natural Sorting (0-9, A-Z)
function natural_sort_compare(a, b)
    local function pad_numbers(str)
        return str:lower():gsub("(%d+)", function(n)
            return string.format("%010d", tonumber(n))
        end)
    end
    -- < puts 0 and A at the top
    return pad_numbers(a) < pad_numbers(b)
end

function sort_graphics_scenes()
    for _, scene_name in ipairs(target_scenes) do
        local source = obs.obs_get_source_by_name(scene_name)
        if source ~= nil then
            local scene = obs.obs_scene_from_source(source)
            local items = obs.obs_scene_enum_items(scene)
            
            -- Sort the items in a standard Lua table first
            table.sort(items, function(a, b)
                local name_a = obs.obs_source_get_name(obs.obs_sceneitem_get_source(a))
                local name_b = obs.obs_source_get_name(obs.obs_sceneitem_get_source(b))
                return natural_sort_compare(name_a, name_b)
            end)

            -- FIX: In some OBS versions, we must re-order by moving items one by one
            -- instead of passing a whole table at once to avoid the 'got table' error.
            for i, item in ipairs(items) do
                -- This moves the item to the specific index (0 is bottom, higher is top)
                -- We reverse the index to ensure A/0 stays at the top.
                obs.obs_sceneitem_set_order_position(item, #items - i)
            end
            
            -- Clean up
            obs.sceneitem_list_release(items)
            obs.obs_source_release(source)
        end
    end
end

-- Check every 1 second
function script_load(settings)
    obs.timer_add(sort_graphics_scenes, 1000)
end

function script_description()
    return "Compatible version: Sorts Graphics 1, 2, & 3.\nUses individual item positioning to avoid API table errors."
end