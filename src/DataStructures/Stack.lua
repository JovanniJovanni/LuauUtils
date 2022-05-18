local Stack = {}
Stack.__index = Stack

export type Type<T> = Stack<T>

function Stack.new<T>(... : T)
	return setmetatable({...}, Stack)
end

type Stack<T> = typeof(Stack.new((nil :: any) :: T))

function Stack.peak<T>(self : Stack<T>) : T
	return self[#self]
end

function Stack.pop<T>(self : Stack<T>) : T
	local size = #self
	local top = self[size]
	table.remove(self :: any, size)
	return top
end

function Stack.push<T>(self : Stack<T>, value : T) : number
	table.insert(self :: any, value)
	return #self
end

return Stack