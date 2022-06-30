--[=[
	@class Iterators
]=]
local Iterators = {}

--[=[
	@type Iterator<T...> () -> (T...)?
	@within Iterators
]=]

--[=[
	@param arr {T}
	@param callbackFn (T, K...) -> V
	@param ... K...
	@return Iterator<V>

	Returns an iterator that applies callbackFn to each element of arr. Additional parameters will be passed to callbackFn.
	
	```lua
		local arr = {1, 2, 3}
		local sum = 0
		for i in Iterators.map(arr, function(i)
			sum += i
		end)
		print(sum)
		-- Output:
		-- 1
		-- 3
		-- 6
	```
]=]
function Iterators.map<T, V, K...>(arr : {T}, callbackFn : (T, K...) -> V, ... : K...) : () -> V?
	local i = 0
	local args = {table.pack(...)}
	return function()
		i += 1
		if arr[i] then
			return callbackFn(arr[i], unpack(args))
		else
			return nil
		end
	end
end

--[=[
	@param arr1 {T}
	@param arr2 {V}
	@return Iterator<T, V>

	Returns an iterator that returns each element of the arrays in parallel.
	
	```lua
		local arr1 = {1, 2, 3}
		local arr2 = {4, 5, 6}
		for i, j in Iterators.zip(arr1, arr2) do
			print(i, j)
		end
		-- Output:
		-- 1 4
		-- 2 5
		-- 3 6
	```
]=]
function Iterators.zip<T, V>(arr1 : {T}, arr2 : {V}) : () -> (T?, V?)
	assert(#arr1 == #arr2, "Arrays are not the same size.")
	local i = 0
	return function()
		i += 1
		if i <= arr1 then
			return arr1[i], arr2[i]
		else
			return nil
		end
	end
end


return Iterators