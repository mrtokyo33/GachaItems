local RollMath = {}

function RollMath.roll(items, pity)
	local total = 0
	local pool = {}

	for _, item in ipairs(items) do
		local chance = 1 / item.weight

		if item.rarity == "Legendary" then
			chance += pity * 0.002
		end

		table.insert(pool, {
			item = item,
			chance = chance,
		})

		total += chance
	end

	local r = math.random() * total
	local acc = 0

	for _, entry in ipairs(pool) do
		acc += entry.chance
		if r <= acc then
			return entry.item
		end
	end
end

return RollMath
