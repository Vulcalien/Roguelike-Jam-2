function new_Level()
    return {
        tick = function(self)
            for i,e in ipairs(self.entities) do
                e:tick()
            end
        end,

        render = function(self)
            maprender()

            for i,e in ipairs(self.entities) do
                e:render()
            end
        end,

        entities = {},

        insert = function(self, entity)
            table.insert(self.entities, entity)
        end,

        remove = function(self, entity)
            for i,e in ipairs(self.entities) do
                if e == entity then
                    table.remove(self.entities, i)
                    break
                end
            end
        end
    }
end
