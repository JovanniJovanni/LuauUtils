local Array = {}
Array.__index = Array

export type Type<T> = Array<T>

function Array.new<T>(... : T)
	return setmetatable({...}, Array)
end

type Array<T> = typeof(Array.new((nil :: any) :: T))

function Array.find<T>(self : Array<T>, item : T, init : number?) : number?
	return table.find(self :: any, item, init)
end


function Array.insert<T>(self : Array<T>, item : T)
	table.insert(self :: any, item)
end


function Array.push<T>(self : Array<T>, item : T) : number
	self.insert(self, item)
	return #self
end

function Array.pop<T>(self : Array<T>) : T
	local item = self[#self]
	self:remove()
	return item
end

function Array.remove<T>(self : Array<T>, pos : number?)
	table.remove(self :: any, pos or #self)
end

function Array.removeItem<T>(self : Array<T>, item : T)
	self:remove(self:find(item))
end

function Array.filter<T>(self : Array<T>, callback : (T, number) -> boolean) : Array<T>
	local newArr = Array.new()
	for i, v in self:ipairs() do
		if callback(v, i) then
			newArr:insert(v)
		end
	end
	return newArr
end

function Array.reduce<T>(self : Array<T>, callback : (T, T) -> T, init : number?) : T
	local result = self[init or 1]
	for i = (init or 1) + 1, #self do
		result = callback(result, self[i])
	end
	return result
end

function Array.map<T>(self : Array<T>, callback : (T, number) -> T) : Array<T>
	local newArr = Array.new()
	for i, v in self:ipairs() do
		newArr[i] = callback(v, i)
	end
	return newArr
end

function Array.join<T>(self : Array<T>, arr2 : Array<T>) : Array<T>
	for _, v in arr2:ipairs() do
		self:insert(v)
	end
	return self
end

function Array:ipairs()
	return ipairs(self :: any)
end

Array.freeze = table.freeze

return (Array :: any) :: {
	__index : typeof(Array),

	new : <T>(...T) -> Array<T>,
	find : <T>(self : Array<T>, item : T, init : number?) -> number?,
	insert : (<T>(self : Array<T>, item : T) -> ()) & (<T>(self : Array<T>, item : T, pos : number) -> ()),
	push : <T>(self : Array<T>, item : T) -> number,
	pop : <T>(self : Array<T>) -> T,
	remove : <T>(self : Array<T>, pos : number) -> (),
	removeItem : <T>(self : Array<T>, item : T) -> (),
	freeze : <T>(self : Array<T>) -> Array<T>,
}