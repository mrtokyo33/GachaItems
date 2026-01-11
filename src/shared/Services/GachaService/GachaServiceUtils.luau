local GachaServiceUtils = {}

function GachaServiceUtils.isValidGachaId(gachaId)
	return gachaId ~= nil and type(gachaId) == "string"
end

function GachaServiceUtils.isLegendary(rarity)
	return rarity == "Legendary"
end

return GachaServiceUtils
