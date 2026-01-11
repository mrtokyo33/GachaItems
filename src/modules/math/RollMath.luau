local RollMath = {}

function RollMath.weightToChance(weight)
	return 1 / weight
end

function RollMath.buildPool(items, pity, config)
	local pool = {}
	local totalWeight = 0

	for _, item in ipairs(items) do
		local chance = RollMath.weightToChance(item.weight)

		if item.rarity == "Legendary" and pity >= config.softPityStart then
			local t = (pity - config.softPityStart) / (config.hardPity - config.softPityStart)
			local boost = 1 + t * config.legendaryBoost
			chance *= boost
		end

		table.insert(pool, {
			item = item,
			weight = chance,
		})

		totalWeight += chance
	end

	return pool, totalWeight
end

function RollMath.rollFromPool(pool, totalWeight)
	local roll = math.random() * totalWeight
	local acc = 0

	for _, entry in ipairs(pool) do
		acc += entry.weight
		if roll <= acc then
			return entry.item
		end
	end
end

function RollMath.forceLegendary(items)
	local pool = {}

	for _, item in ipairs(items) do
		if item.rarity == "Legendary" then
			table.insert(pool, item)
		end
	end

	return pool[math.random(#pool)]
end

return RollMath
