local name_pools = {
    -- nodeJS
    {
        'index.js',
        'package.json',

        'user.js',
        'class.js',
        'store.js',
        'game.js',
        'login.js',
        'register.js',
        'delete.js',
        'report.js',
        'modules.js',
        'routes.js',

        'page.ejs',
        'template.ejs',
        'info.ejs'
    },

    -- php
    {
        'index.php',

        'config.php',
        'login.php',
        'preview.php',
        'register.php',
        'contacts.php',
        'profile.php',
        'personal.php',
        'public.php',
        'database.php',
        'neo.php',
        'header.php',
        'footer.php',

        'links.json',
    },

    -- hidden
    {
        '.gitignore',
        '.gitattributes'
    }
}

local function new_Room(name, name_pool, used_names, room_count)
    local room = {
        name = name,

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

    room_count = room_count - 1
    if room_count ~= 0 then
        local next_name = nil

        -- try 3 times to get a random name
        for i=1,3 do
            local name_index = math.random(2, #name_pool)

            local contains = false
            for j=1,#used_names do
                if used_names[j] == name_index then
                    contains = true
                    break
                end
            end

            if contains == false then
                next_name = name_pool[name_index]
                table.insert(used_names, name_index)
                break
            end
        end

        -- if the name is still unset, just use the first unused name
        if next_name == nil then
            for i=2,#name_pool do
                local contains = false
                for j=1,#used_names do
                    if used_names[j] == i then
                        contains = true
                        break
                    end
                end

                if contains == false then
                    next_name = name_pool[i]
                    table.insert(used_names, i)
                    break
                end
            end
        end

        room.next_room = new_Room(next_name, name_pool, used_names, room_count)
    end

    return room
end

local function generate_rooms(name_pool)
    local room_count = math.random(5, #name_pool)
    return new_Room(name_pool[1], name_pool, {}, room_count)
end

function new_Level()
    local result = {
        tick = function(self)
            self.room:tick()
        end,

        render = function(self)
            self.room:render()
        end,

        insert = function(self, entity)
            self.room:insert(entity)
        end,

        remove = function(self, entity)
            self.room:remove(entity)
        end
    }

    local name_pool = name_pools[math.random(1, #name_pools - 1)]
    result.room = generate_rooms(name_pool)

    return result
end
