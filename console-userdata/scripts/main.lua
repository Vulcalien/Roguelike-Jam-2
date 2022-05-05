-- For Documentation, see 'https://github.com/Vulcalien/LuaG-Console/wiki'

function init()
    ticks = 0

    settransparent(0xff00ff)

    loadscript('level.lua')

    loadscript('entity/entity.lua')
    loadscript('entity/mob.lua')
    loadscript('entity/player.lua')

    level = new_Level()

    player = new_Player()
    player.x = map_w * 8 // 2
    player.y = map_h * 8 // 2
end

function tick()
    level:tick()
    player:tick()

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
    player:render()
end
