--[=[
	@class Set
]=]
local Set = {}
Set.__index = Set

--[=[
	@type Type<T> {[number] : T, @metatable : Queue}
	@within Set
]=]
export type Type<T = any> = Set<T>

--[=[
	@param object any
	@return boolean
	Returns true if the object is a Set
]=]
function Set.Is(object : any) : boolean
	return type(object) == "table" and getmetatable(object) == Set
end

--[=[
	@within Set
	@param ... T -- Items already in the set
	@return Type<T>

	Creates a new set.
]=]
function Set.new<T>(... : T)
	local self = setmetatable({}, Set)

	for _, value in ipairs({...}) do
		if not table.find(self, value) then
			table.insert(self, value)
		end
	end

	return self
end

type Set<T = any> = typeof(Set.new((nil :: any) :: T))

--[=[
	@method add
	@within Set
	@param value T -- The item to add to the set

	Adds a new item to the set, does nothing if the item is already in the set.
]=]
function Set.add<T>(self : Set<T>, value : T)
	if table.find(self, value) == nil then
		table.insert(self, value)
	end
end

--[=[
	@method remove
	@within Set
	@param value T -- The item to remove from the set

	Removes an item from the set.
]=]
function Set.remove<T>(self : Set<T>, value : T)
	table.remove(self, table.find(self, value))
end

--[=[
	@method contains
	@within Set
	@param value T -- The item to check for in the set
	@return boolean

	Returns true if the set contains the item.
]=]
function Set.contains<T>(self : Set<T>, value : T) : boolean
	return table.find(self, value) ~= nil
end

--[=[
	@method clear
	@within Set
	
	Removes all elements in the set.
]=]
function Set.clear(self : Set)
	table.clear(self)
end

return setmetatable(Set, {
	__call = function(_, ...)
		return Set.new(...)
	end
})