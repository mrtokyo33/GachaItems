local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GachaServiceClient = require(ReplicatedStorage.Shared.Services.GachaService.GachaServiceClient)

for _, machine in ipairs(CollectionService:GetTagged("gacha_machine")) do
	local part = machine:WaitForChild("interactible")
	local prompt = part:WaitForChild("ProximityPrompt")

	prompt.Triggered:Connect(function()
		local gachaId = machine:GetAttribute("GachaId")
		if not gachaId then
			return
		end

		local result = GachaServiceClient:roll(gachaId)
		print(result.itemId, result.rarity, result.pity)
	end)
end
