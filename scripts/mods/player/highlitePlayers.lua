package.path = package.path .. ";data/scripts/systems/?.lua"
package.path = package.path .. ";data/scripts/lib/?.lua"
require ("randomext")

function initialize()
    Player():registerCallback("onPreRenderHud", "onPreRenderHud")
end

function onPreRenderHud()

    local nearby = {Sector():getEntitiesByType(EntityType.Ship)}
    local displayed = {}
    print(#nearby)
    for _, entity in pairs(nearby) do
--        if entity:isManned() then


            table.insert(displayed, {ship = entity})
--        end

    end
    print(#displayed)
    -- display nearest x
    local renderer = UIRenderer()

    for i = 1, #displayed do
        local tuple = displayed[i]
        -- uncomment to render targeter
        -- renderer:renderEntityTargeter(tuple.ship, ColorRGB(94,243,32), 0);
        -- comment if you don't like the an arrow
        renderer:renderEntityArrow(tuple.ship, 30, 10, 250, ColorRGB(94,243,32), 0);
    end

    renderer:display()
end

