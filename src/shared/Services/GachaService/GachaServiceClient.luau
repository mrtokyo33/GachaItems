local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Networker = require(ReplicatedStorage.Packages.Networker)

local GachaServiceClient = {}

local networker = Networker.client.new("GachaService", GachaServiceClient)

function GachaServiceClient:roll(gachaId)
	return networker:invoke("roll", gachaId)
end

return GachaServiceClient
