local Queue = {}
Queue.__index = Queue

export type Type<T> = Queue<T>

function Queue.new<T>(... : T)
	return setmetatable({...}, Queue)
end

type Queue<T> = typeof(Queue.new((nil :: any) :: T))

function Queue.enqueue<T>(self : Queue<T>, value : T) : number
	table.insert(self :: any, value)
	return #self
end

function Queue.dequeue<T>(self : Queue<T>, value : T) : T
	local bottom = self[1]
	table.remove(self :: any, 1)
	return bottom
end

return Queue