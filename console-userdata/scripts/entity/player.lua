function new_Player()
    local result = new_Mob()

    result.xr = 2
    result.yr = 4

    result.tick = function(self)
        local xm = 0
        local ym = 0

        if key('up')    then ym = ym - 1 end
        if key('left')  then xm = xm - 1 end
        if key('down')  then ym = ym + 1 end
        if key('right') then xm = xm + 1 end

        self:move(xm, ym)
    end

    result.render = function(self)
        local sprite_id = self.dir
        local bounce_y = 0

        local animation_phase = (self.mov_animation + 9) // 10 % 4
        if animation_phase == 1 then
            sprite_id = sprite_id + 1 * 16
            bounce_y = 1
        elseif animation_phase == 3 then
            sprite_id = sprite_id + 2 * 16
            bounce_y = 1
        end

        spr(sprite_id, self.x - 4, self.y - 4 - bounce_y)
    end

    return result
end
