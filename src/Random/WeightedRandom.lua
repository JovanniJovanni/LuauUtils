--!strict

--[=[
	@interface Type<T>
	@within WeightedRandom

	.Items Array<Item<T>>
	.Weight number

]=]
export type Type<T> = WeightedRandom<T>

--[=[
	@interface Item<T>
	@within WeightedRandom
	
	.Weight : number -- The weight of an item
	.Value : T -- The value to be returned when using :GetItem()
]=]
export type Item<T> = {
	Weight : number,
	Value : T
}

--[=[
	@class WeightedRandom
	
	A class used to create Weighted Randoms.
]=]
local WeightedRandom = {}
WeightedRandom.__index = WeightedRandom

local function getWeight(List : {Item<any>}) : number
	local totalWeight = 0
	for _, item in pairs(List) do
		totalWeight += item.Weight
	end
	return totalWeight
end


--[=[
	@prop Items Array<Item<T>>
	@within WeightedRandom
	@readonly
	
	A list of all items inside a weighted random object.
]=]
--[=[
	@prop Weight number
	@within WeightedRandom
	@readonly
	
	The total weight of all items in a weighted random object.
]=]


--[=[
	Create a new WeightedRandom object from Array<Item<T>> Objects.

	@param Objects Array<Item<T>>

	@return Type<T>
]=]
function WeightedRandom.new<T>(Objects : {Item<T>}, seed : number?)
	return setmetatable({

		Items = Objects,
		Weight = getWeight(Objects),

		_rng = Random.new(seed)

	}, WeightedRandom)
end

type WeightedRandom<T> = typeof(WeightedRandom.new({} :: {Item<T>}, 0))

--[=[
	Returns a random item's Value from the object's Items property.

	@method getItem
	@within WeightedRandom
	@return T
]=]

function WeightedRandom.getItem<T>(self : Type<T>) : T
	local pastPercent = 0
	local chosen
	for _, item : Item<T> in pairs(self.Items) do
		if self._rng:NextNumber(1, self.Weight) < item.Weight + pastPercent then
			chosen = item.Value
			break
		else
			pastPercent += item.Weight
		end
	end
	return chosen
end

--[=[
	@method getItems
	@within WeightedRandom
	@return Array<Item<T>>
	
	A weighted random object's Items property.
]=]
function WeightedRandom.getItems<T>(self : Type<T>) : {Item<T>}
	return self.Items
end

--[=[
	@return number
	@within WeightedRandom
	
	A weighted random object's Weight property.
]=]
function WeightedRandom:getWeight() : number
	return self.Weight
end

return WeightedRandom