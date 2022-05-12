function new_Enemy()
    local result = new_Mob()

    result.is_enemy = true

    result.die = function(self)
        level:remove(self)
    end

    result.blocks_movement = function(self, e)
        if e.is_enemy then
            return false
        end

        return true
    end

    return result
end
