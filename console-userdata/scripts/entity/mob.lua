local function move2(mob, xm, ym)
    if xm == 0 and ym == 0 then
        return false
    end

    -- check map borders
    if mob.x - mob.xr + xm < 0 or
       mob.y - mob.yr + ym < 0 or
       mob.x + mob.xr + xm - 1 >= map_w * 8 or
       mob.y + mob.yr + ym - 1 >= map_h * 8 then
        return false
    end

    -- check for solid entities
    for i,e in ipairs(level.entities) do
        if e == mob then
            goto loop_end
        end

        if mob.x - mob.xr + xm <= e.x + e.xr and
           mob.y - mob.yr + ym <= e.y + e.yr and
           mob.x + mob.xr + xm >= e.x - e.xr and
           mob.y + mob.yr + ym >= e.y - e.yr then
            if mob.touch then
                mob:touch(e)
            end

            if e.touched_by then
                e:touched_by(mob)
            end

            return false
        end

        ::loop_end::
    end

    mob.x = mob.x + xm
    mob.y = mob.y + ym
    return true
end

function new_Mob()
    local result = new_Entity()

    -- by default, all mobs face towards the screen
    result.dir = 2

    result.mov_animation = 0

    result.move = function(self, xm, ym)
        if xm == 0 and ym == 0 then
            self.mov_animation = 0
            return
        end

        move2(self, xm, 0)
        move2(self, 0, ym)

        if     xm < 0 then self.dir = 1
        elseif xm > 0 then self.dir = 3
        end

        if     ym < 0 then self.dir = 0
        elseif ym > 0 then self.dir = 2
        end

        self.mov_animation = self.mov_animation + 1
    end

    result.touch = function(self, e) end
    result.touched_by = function(self, e) end

    return result
end
