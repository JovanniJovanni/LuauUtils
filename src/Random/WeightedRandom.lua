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
	local self = {}

	self.Items = Objects
	self.Weight = getWeight(Objects)

	self._rng = Random.new(seed)

	return self
end

type WeightedRandom<T> = typeof(WeightedRandom.new({} :: {Item<T>}))

--[=[
	@param item Item<T>
	
	Adds an item to a weighted random object's Items property.
]=]
function WeightedRandom.AddItem<T>(self : WeightedRandom<T>, item : Item<T>)
	table.insert(self.Items, item)
	self.Weight = getWeight(self.Items)
end

--[=[
	Destroys a weighted random object.
]=]
function WeightedRandom.Destroy<T>(self : WeightedRandom<T>)
	table.clear(self)
	setmetatable(self, nil)
end


--[=[
	Returns a random item's Value from the object's Items property.

	@within WeightedRandom
	@return T
]=]

function WeightedRandom.GetItem<T>(self : WeightedRandom<T>) : T
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
	@return Array<Item<T>>
	@within WeightedRandom
	
	A weighted random object's Items property.
]=]
function WeightedRandom.GetItems<T>(self : WeightedRandom<T>) : {Item<T>}
	return self.Items
end

--[=[
	@return number
	@within WeightedRandom
	
	A weighted random object's Weight property.
]=]
function WeightedRandom:GetWeight() : number
	return self.Weight
end


--[=[
	@param i number | Item<T>
	@within WeightedRandom

	
	Removes an item from a weighted random object using its index or .
]=]
function WeightedRandom.RemoveItem<T>(self : WeightedRandom<T>, i : number | Item<T>)
	if type(i) == "number" then
		table.remove(self.Items)
	else
		table.remove(self.Items, table.find(self, i))
	end
end

return WeightedRandom