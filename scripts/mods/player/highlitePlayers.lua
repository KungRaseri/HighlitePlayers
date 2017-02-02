if onServer() then

package.path = package.path .. ";data/scripts/lib/?.lua"
package.path = package.path .. ";data/scripts/?.lua",
require ("randomext")

local consecutiveJumps = 0
local noSpawnTimer = 0

function initialize()
	if onClient() then
        Player():registerCallback("onPreRenderHud", "onPreRenderHud")
    end
    if onServer() then
    	invokeClientFunction(Player(), "initialize")
    end
end

function onSectorEntered(player, x, y)
	var sector = Sector(player)
end

function onPreRenderHud()

    local ship = Entity()
    local shipPos = ship.translationf

    local nearby = {Sector():getEntitiesByType(EntityType.Ship)}
    local displayed = {}

    -- detect all asteroids in range
    for _, entity in pairs(nearby) do

        if entity:isManned() then

            local d = distance2(entity.translationf, shipPos)

            table.insert(displayed, {ship = entity, distance = d})
        end

    end

    -- sort by distance
    table.sort(displayed, sort)

    -- display nearest x
    local renderer = UIRenderer()

    for i = 1, #displayed do
        local tuple = displayed[i]
        -- Render bright green targeter Hex value = #5EF320
        renderer:renderEntityTargeter(tuple.ship, ColorRGB(94,243,32));
        -- uncomment if you would like an arrow
        -- renderer:renderEntityArrow(tuple.asteroid, 30, 10, 250, tuple.material.color, 0);
    end

    renderer:display()
end
