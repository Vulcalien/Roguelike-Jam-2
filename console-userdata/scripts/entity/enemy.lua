function new_Enemy()
    local result = new_Mob()
    result.entity_type['enemy'] = true

    result.die = function(self)
        level:remove(self)
    end

    result.blocks_movement = function(self, e)
        if e.entity_type['enemy'] then
            return false
        end

        return true
    end

    return result
end
