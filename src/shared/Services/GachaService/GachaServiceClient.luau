local GachaServiceClient = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Networker = require(ReplicatedStorage.Packages.Networker)

local networker = Networker.client.new("GachaService", GachaServiceClient)

function GachaServiceClient.roll(gachaId: string)
	networker:fire("roll", gachaId)
end

return GachaServiceClient
