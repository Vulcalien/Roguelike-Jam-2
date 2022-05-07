local names = {
    'Virus Defender',
    'Bit Protector',
    'McAbee',
    'Auast',
    'Clams Antivirus',
    'HTML Blocker',
    'TrustMe AV'
}

function new_Spray(level, color)
    local result = new_Item(names[level], icon, math.random(0, 0xffffff))

    result.use = function(self, player)
        -- TODO deal damage to enemies in a certain range
    end

    return result
end
