function new_Virus(x0, y0)
    local result = new_Enemy()

    result.x = x0 * 8
    result.y = y0 * 8

    result.xr = 3
    result.yr = 4

    result.is_pregnant = false

    result.tick = function(self)
        if ticks % 2 == 0 and is_pregnant == false then
            return
        end

        -- TODO use a pathfinder
        local xm = 0
        local ym = 0

        local speed = 1

        if     player.x < self.x then xm = -speed
        elseif player.x > self.x then xm = speed
        end

        if     player.y < self.y then ym = -speed
        elseif player.y > self.y then ym = speed
        end

        if self.is_pregnant == true then
            xm = -xm
            ym = -ym
        end

        self:move(xm, ym)
    end

    result.render = function(self)
        spr(3, self.x - 4, self.y - 4)
    end

    result.touch = function(self, e)
        if e == player then
            self.is_pregnant = true
        end
    end

    return result
end
