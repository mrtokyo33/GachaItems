local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Networker = require(ReplicatedStorage.Packages.Networker)
local ItemsIndex = require(ReplicatedStorage.Modules.game.ItemsIndex)
local GachaIndex = require(ReplicatedStorage.Modules.game.GachaIndex)
local RollMath = require(ReplicatedStorage.Modules.math.RollMath)

local GachaServiceServer = {}

function GachaServiceServer:init()
	self.pity = {}

	self.networker = Networker.server.new("GachaService", self, {
		self.roll,
	})
end

function GachaServiceServer:getPity(player, gachaId)
	self.pity[player] = self.pity[player] or {}
	self.pity[player][gachaId] = self.pity[player][gachaId] or 0
	return self.pity[player][gachaId]
end

function GachaServiceServer:roll(player: Player, gachaId: string)
	local pity = self:getPity(player, gachaId) + 1
	self.pity[player][gachaId] = pity

	local items = ItemsIndex[gachaId]
	local config = GachaIndex[gachaId]

	local result

	if pity >= config.hardPity then
		result = RollMath.forceLegendary(items)
		self.pity[player][gachaId] = 0
	else
		local pool, total = RollMath.buildPool(items, pity, config)
		result = RollMath.rollFromPool(pool, total)

		if result.rarity == "Legendary" then
			self.pity[player][gachaId] = 0
		end
	end

	return {
		itemId = result.id,
		rarity = result.rarity,
		pity = self.pity[player][gachaId],
	}
end

return GachaServiceServer
