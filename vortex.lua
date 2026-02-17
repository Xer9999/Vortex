local PLACE_ID_1 = 13822562292
local PLACE_ID_2 = 15288629078

local currentId = game.PlaceId

if currentId == PLACE_ID_1 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Xer9999/Vortex/refs/heads/main/Midnight_Chasers.lua"))()
elseif currentId == PLACE_ID_2 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Xer9999/Vortex/refs/heads/main/Highway%20Legends.lua"))()
else
    game.Players.LocalPlayer:Kick("This script can only be used in specific games.")
end
