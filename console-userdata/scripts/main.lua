-- For Documentation, see 'https://github.com/Vulcalien/LuaG-Console/wiki'

function init()
    settransparent(0xff00ff)

    loadscript('entity/entity.lua')
    loadscript('entity/mob.lua')
    loadscript('entity/player.lua')

    player = new_Player()
    player.x = map_w * 8 // 2
    player.y = map_h * 8 // 2
end

function tick()
    player:tick()
end

function render()
    player:render()
end
