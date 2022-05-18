--[=[
	@class Stack
]=]
local Stack = {}
Stack.__index = Stack

--[=[
	@type Type<T> {[number] : T, @metatable : Stack}
	@within Stack
]=]
export type Type<T> = Stack<T>

--[=[
	@param ... T -- Items already in the stack

	Creates a new stack object.
]=]
function Stack.new<T>(... : T)
	return setmetatable({...}, Stack)
end

type Stack<T> = typeof(Stack.new((nil :: any) :: T))

--[=[
	@method peak
	@within Stack
	@return T -- The item at the top of the stack

	Returns the item at the top of the stack without removing it.
]=]
function Stack.peak<T>(self : Stack<T>) : T
	return self[#self]
end

--[=[
	@method pop
	@within Stack
	@return T -- The item at the top of the stack

	Removes the item at the top of the stack and returns it.
]=]
function Stack.pop<T>(self : Stack<T>) : T
	local size = #self
	local top = self[size]
	table.remove(self :: any, size)
	return top
end

--[=[
	@method push
	@within Stack
	@param value T -- The item to add to the stack
	@return number -- The new size of the stack

	Adds a new item to the top of the stack and returns the new size.
]=]
function Stack.push<T>(self : Stack<T>, value : T) : number
	table.insert(self :: any, value)
	return #self
end

return Stack