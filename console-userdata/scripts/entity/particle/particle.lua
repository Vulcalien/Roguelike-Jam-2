function new_Particle(x, y, lasting_time)
    local result = new_Entity(x, y)

    result.lasting_time = lasting_time

    result.tick = function(self)
        result.lasting_time = result.lasting_time - 1
        if result.lasting_time == 0 then
            level:remove(self)
        end
    end

    return result
end
