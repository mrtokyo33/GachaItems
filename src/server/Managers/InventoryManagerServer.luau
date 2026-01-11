local InventoryManagerServer = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ItemsFolder = ReplicatedStorage.Assets.Items

function InventoryManagerServer:giveTool(player, gachaId, itemId)
	local folder = ItemsFolder:FindFirstChild(gachaId)
	if not folder then
		warn("Invalid gacha folder:", gachaId)
		return
	end

	local tool = folder:FindFirstChild(itemId)
	if not tool then
		warn("Invalid item:", itemId)
		return
	end

	local clone = tool:Clone()
	clone.Parent = player:WaitForChild("Backpack")
end

return InventoryManagerServer
