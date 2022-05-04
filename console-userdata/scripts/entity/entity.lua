function new_Entity()
    return {
        x = 0,
        y = 0,

        xr = 0,
        yr = 0,

        tick = function(self) end,
        render = function(self) end
    }
end
