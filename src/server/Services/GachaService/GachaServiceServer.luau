local GachaServiceServer = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Networker = require(ReplicatedStorage.Packages.Networker)
local ItemsIndex = require(ReplicatedStorage.Modules.Data.ItemsIndex)
local RollMath = require(ReplicatedStorage.Modules.math.RollMath)
local InventoryManager = require(ServerScriptService.Server.Managers.InventoryManagerServer)

function GachaServiceServer:roll(player: Player, gachaId: string)
	local items = ItemsIndex[gachaId]
	if not items then
		warn("Invalid gachaId:", gachaId)
		return
	end

	self.pity[player] = self.pity[player] or {}
	self.pity[player][gachaId] = (self.pity[player][gachaId] or 0) + 1

	local pityCount = self.pity[player][gachaId]
	local result = RollMath.roll(items, pityCount)

	if not result then
		return
	end

	InventoryManager:giveTool(player, gachaId, result.id)

	if result.rarity == "Legendary" then
		self.pity[player][gachaId] = 0
	end
end

function GachaServiceServer:init()
	self.pity = {}

	self.networker = Networker.server.new("GachaService", self, {
		self.roll,
	})
end

return GachaServiceServer
