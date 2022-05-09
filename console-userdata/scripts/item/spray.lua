local names = {
    'Virus Defender',
    'Bit Protector',
    'McAbee',
    'Auast',
    'Clams Antivirus',
    'HTML Blocker',
    'TrustMe AV'
}

function new_Spray(lvl)
    local result = new_Item(names[lvl], icon, math.random(0, 0xffffff))

    result.use = function(self, player)
        local x = player.x
        local y = player.y

        local range = 8
        local radius = 4

        if     player.dir == 0 then y = y - range
        elseif player.dir == 1 then x = x - range
        elseif player.dir == 2 then y = y + range
        elseif player.dir == 3 then x = x + range
        end

        level:insert(new_Spray_particle(x, y, self.item_col))

        for i,e in ipairs(level.room.entities) do
            if e == player then
                goto loop_end
            end

            if e:intersects(x, y, radius, radius) then
                if e.damage then
                    local dmg = lvl * 4 + math.random(-5, 5)
                    if dmg < 1 then
                        dmg = 1
                    end

                    e:damage(dmg)
                end
            end

            ::loop_end::
        end

        -- TODO deal damage to enemies in a certain range
    end

    return result
end
