--!strict
local null = nil :: any

--[=[
	@class Generator
]=]
local Generator = {}
Generator.__index = Generator

--[=[
	@type Type<T...>
	@within Generator
]=]
export type Type<T...> = Generator<T...>

function Generator.Is(object : any) : boolean
	return type(object) == "table" and object.__index == Generator
end

--[=[
	@param callbackFn (yield : (T...) -> ()) -> ()
	@returns Generator<T...>

	Creates a new generator.

	```lua
	local generator = Generator.new(function(yield)
		yield(1)
		yield(2)
	end)

	print(generator:next()) -- 1
	print(generator:next()) -- 2
	print(generator:isDone()) -- true
	```
]=]
function Generator.new<T...>(callbackFn : (yield : (T...) -> ()) -> ()) 
	return setmetatable({

		_co = coroutine.create(callbackFn)

	}, Generator)
end

type Generator<T...> = typeof(Generator.new(
	null :: (yield : (T...) -> ()) -> ()
))

--[=[
	@return T...

	Resumes the generator and returns the value passed to `yield`.
]=]
function Generator.next<T...>(self : Generator<T...>) : T...
	return select(2, coroutine.resume(self._co))
end

--[=[
	@return Boolean

	Returns true if the generator has finished or errored.
]=]
function Generator.isDone<T...>(self : Generator<T...>) : boolean
	return coroutine.status(self._co) == "dead"
end

return Generator