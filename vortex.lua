-- Game ID Checker Script
local GAME_ID_1 = 13822562292
local GAME_ID_2 = 15288629078

local function getCurrentGameId()
    return game.GameId
end

local currentGameId = getCurrentGameId()

if currentGameId == GAME_ID_1 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Xer9999/Vortex/refs/heads/main/Midnight_Chasers.lua"))()
elseif currentGameId == GAME_ID_2 then
    print("test") 
else
    game.Players.LocalPlayer:Kick("This script can only be used in specific games.")
end
