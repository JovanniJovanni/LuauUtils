local null = nil :: any
--[=[
	@class Thread
]=]	
local Thread = {}
Thread.__index = Thread

--[=[
	@type Type { _coroutine : thread, @metatable: Thread}
	@within Thread
]=]
export type Type = Thread

--[=[
	@param callbackFn functoin
	@return Type

	Creates a new thread from a function.
]=]
function Thread.new(callbackFn : (...any) -> any)
	return setmetatable({
		_coroutine = coroutine.create(callbackFn),
	}, Thread)
end

--[=[
	@param thread thread
	@return Type
	Creates a thread from a thread gotten from coroutine.running().
]=]
function Thread.from(thread : thread) : Type
	return setmetatable({
		_coroutine = thread,
	}, Thread)
end


type Thread = typeof(Thread.new(null :: () -> ()))

--[=[
	@param ... any

	Resumes the thread and returns true if the thread is still running.
]=]
function Thread:resume(... : any)
	coroutine.resume(self._coroutine, ...)
end

--[=[
	@return "dead" | "running" | "suspended" | "normal"
	Returns the thread's status.
]=]
function Thread:getStatus()-- : "dead" | "running" | "suspended" | "normal"
	return coroutine.status(self._coroutine)-- :: "dead" | "running" | "suspended" | "normal"
end

--[=[
	Closes the thread
]=]
function Thread:close()
	coroutine.close(self._coroutine)
end

return Thread