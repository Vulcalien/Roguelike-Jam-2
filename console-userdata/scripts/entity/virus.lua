local WALK_TIME     = 120
local DELIVERY_TIME = 180

function new_Virus(x0, y0)
    local result = new_Enemy()

    result.x = x0 * 8
    result.y = y0 * 8

    result.xr = 3
    result.yr = 4

    result.fertility = 3

    result.is_pregnant = false
    result.walk_time = 0
    result.pregnant_delivery_time = 0

    result.ignore_one_axis_time = 0

    result.tick = function(self)
        if ticks % 2 == 0 and not self.is_pregnant then
            return
        end

        -- TODO use a better pathfinder ???
        if not self.is_pregnant or self.walk_time > 0 then
            if self.ignore_one_axis_time == 0 and math.random(1, 50) == 1 then
                self.ignore_one_axis_time = math.random(30, 120)
            end

            local xm = 0
            local ym = 0

            local speed = 1

            if     player.x < self.x then xm = -speed
            elseif player.x > self.x then xm = speed
            end

            if     player.y < self.y then ym = -speed
            elseif player.y > self.y then ym = speed
            end

            if self.is_pregnant then
                xm = -xm
                ym = -ym
            end

            -- ignore one axis sometimes, just to add variety to the movement
            if xm ~= 0 and ym ~= 0 and self.ignore_one_axis_time > 0 then
                local xdiff = math.abs(player.x - self.x)
                local ydiff = math.abs(player.y - self.y)
                if xdiff < ydiff then
                    xm = 0
                elseif xdiff > ydiff then
                    ym = 0
                end

                self.ignore_one_axis_time = self.ignore_one_axis_time - 1
            end

            self:move(xm, ym)
        end

        if self.is_pregnant and self.walk_time > 0 then
            self.walk_time = self.walk_time - 1

            if self.walk_time == 0 then
                if self.fertility > 0 then
                    self.pregnant_delivery_time = DELIVERY_TIME
                else
                    self.is_pregnant = false
                end
            end
        end

        if self.is_pregnant and self.walk_time == 0 then
            self.pregnant_delivery_time = self.pregnant_delivery_time - 1

            if self.pregnant_delivery_time == 0 then
                self.is_pregnant = false

                local child = new_Virus(0, 0)
                child.x = self.x
                child.y = self.y

                self.fertility = self.fertility - 1
                child.fertility = self.fertility

                level:insert(child)
            end
        end
    end

    result.render = function(self)
        spr(3, self.x - 4, self.y - 4)

        if debug_info then
            write(
                'ignore axis time: ' .. self.ignore_one_axis_time ..
                '\npregnant: ' .. (self.is_pregnant and 1 or 0) ..
                '\n walk time: ' .. self.walk_time ..
                '\n delivery time: ' .. self.pregnant_delivery_time,
                0x000000, self.x, self.y
            )
        end
    end

    result.touch = function(self, e)
        if e == player then
            self.is_pregnant = true
            self.walk_time = WALK_TIME
        end
    end

    return result
end
