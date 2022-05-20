--[=[
	@class Queue
]=]
local Queue = {}
Queue.__index = Queue

--[=[
	@type Type<T> {[number] : T, @metatable : Queue}
	@within Queue
]=]
export type Type<T> = Queue<T>

--[=[
	@param object any
	@return boolean
	Returns true if the object is a Queue
]=]
function Queue.Is(object : any) : boolean
	return type(object) == "table" and getmetatable(object) == Queue
end

--[=[
	@within Queue
	@param ... T -- Items already in the queue
	@return Type<T>

	Creates a new queue.
]=]
function Queue.new<T>(... : T)
	return setmetatable({...}, Queue)
end

type Queue<T> = typeof(Queue.new((nil :: any) :: T))

--[=[
	@method enqueue
	@within Queue
	@param value T -- The item to add to the queue
	@return number -- The new size of the queue

	Adds a new item to the end of the queue and returns the new size.
]=]
function Queue.enqueue<T>(self : Queue<T>, value : T) : number
	table.insert(self :: any, value)
	return #self
end

--[=[
	@method dequeue
	@within Queue
	@return T -- Item removed from the front of the queue

	Removes the first item from the queue and returns it.
]=]
function Queue.dequeue<T>(self : Queue<T>) : T
	local bottom = self[1]
	table.remove(self :: any, 1)
	return bottom
end

return Queue