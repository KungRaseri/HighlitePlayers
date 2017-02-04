package.path = package.path .. ";data/scripts/systems/?.lua"
package.path = package.path .. ";data/scripts/lib/?.lua"
require ("randomext")

function initialize()
    Player():registerCallback("onPreRenderHud", "onPreRenderHud")
end

function onPreRenderHud()

    local allShips = {Sector():getEntitiesByType(EntityType.Ship)}
    local displayed = {}
    local player = Player()
    for _, entity in pairs(allShips) do
        local faction = Faction(entity.factionIndex)
        if faction.isPlayer then
            table.insert(displayed, {ship = entity})
        end

    end
    --print("Displaying %s ships", #displayed)
    local renderer = UIRenderer()

    for i = 1, #displayed do
        local tuple = displayed[i]
        -- uncomment to render targeter
        -- renderer:renderEntityTargeter(tuple.ship, ColorRGB(1,0,1), 0);
        -- comment if you don't like the an arrow
        renderer:renderEntityArrow(tuple.ship, 30, 10, 250, ColorRGB(1,0,1), 0);
    end

    renderer:display()
end

