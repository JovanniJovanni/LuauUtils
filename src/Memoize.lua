--[=[
	@class Memoize
]=]
local Memos = {}

--[=[
	@error "Memoize callback function must have one parameter." -- Memoize will error is the returned function is called with more than one parameter.

	@function new
	@within Memoize
	@param callbackFn (K) -> V
	@return (K) -> V

	Creates a new memoized function, can also be created by calling the class itself.

	Recursive functions must use the this differently compared to normal functions.
	```lua
		local Memoize = require("Memoize")

		--- Recursive impementation of fibonacci sequence:

		local function fib(n : number) : number
			if n < 2 then
				return n
			else
				return fib(n - 1) + fib(n - 2)
			end
		end

		fib = Memoize(fib)

		--- Normal impementation of fibonacci sequence:

		local fib = Memoize(function(n : number) : number
			local x, y, z = 0, 1, 1
			for i = 2, n do
				x = y
				y = z
				z = x + y
			end
		end)
	```
]=]
function Memoize<K, V>(callbackFn : (K) -> V) : (K) -> V
	local memo = Memos[callbackFn]
	return function(... : K) : V
		assert(select("#", ...) == 1, "Memoize callback function must have one parameter.")
		local key = ...
		if memo[key] == nil then
			memo[key] = callbackFn(key)
		end
		return memo[key]
	end
end

return setmetatable({new = Memoize}, {
	__call = function(_, callbackFn)
		return Memoize(callbackFn)
	end
})