local Iterators = {}

function Iterators.range(min : number, max : number, increment : number?) : () -> number?
	assert(min and max, "Range function must have two values passed.")

	local i = min - 1
	return function()
		i += increment or 1
		return (i <= max and i) or nil
	end
end

function Iterators.map<T, V>(arr : {T}, callbackFn : (T) -> V) : () -> V?
	local i = 0
	return function()
		i += 1
		if arr[i] then
			return callbackFn(arr[i])
		else
			return nil
		end
	end
end

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