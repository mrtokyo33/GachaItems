local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GachaServiceClient = require(ReplicatedStorage.Shared.Services.GachaService.GachaServiceClient)

for _, machine in ipairs(CollectionService:GetTagged("gacha_machine")) do
	local prompt = machine:FindFirstChildOfClass("ProximityPrompt")

	if not prompt then
		warn("Gacha machine without ProximityPrompt:", machine:GetFullName())
		continue
	end

	prompt.Triggered:Connect(function()
		local gachaId = machine:GetAttribute("GachaId")
		if not gachaId then
			warn("Gacha machine without GachaId:", machine:GetFullName())
			return
		end

		GachaServiceClient.roll(gachaId)
	end)
end
