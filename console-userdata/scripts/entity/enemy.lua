function new_Enemy()
    local result = new_Mob()

    result.die = function(self)
        level:remove(self)
    end

    return result
end
