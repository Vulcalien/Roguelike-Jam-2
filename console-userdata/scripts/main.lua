-- For Documentation, see 'https://github.com/Vulcalien/LuaG-Console/wiki'

function init()
    ticks = 0

    settransparent(0xff00ff)

    loadscript('level.lua')

    loadscript('entity/entity.lua')
    loadscript('entity/mob.lua')
    loadscript('entity/player.lua')

    loadscript('entity/enemy.lua')
    loadscript('entity/virus.lua')

    loadscript('entity/particle/particle.lua')
    loadscript('entity/particle/spray.lua')

    loadscript('item/item.lua')
    loadscript('item/spray.lua')

    loadscript('menu/game.lua')
    loadscript('menu/pause.lua')

    level = new_Level()

    player = new_Player()
    player.item_a = new_Spray(2)
    level:insert(player)

    -- DEBUG
    player.x = map_w * 8 // 2
    player.y = map_h * 8 // 2

    level:insert(new_Virus(3, 3))
end

function tick()
    if menu then
        menu:tick()
    else
        level:tick()
    end

    ticks = ticks + 1
end

function render()
    do --draw background
        clear(0x001822)

        for i=0,scr_h / (font_h + 2) - 1 do
            local sin = math.sin(ticks / 180 + i * 2)

            write(
                '01010110 01110101 01101100 01100011',
                math.floor(0x99ff99),
                (i % 5) * 2 - 30 + math.floor(sin * 30), 1 + i * (font_h + 2),
                { alpha = math.floor(math.abs(sin) * 0x18) }
            )
        end
    end

    level:render()

    if menu then
        menu:render()
    end
end
