local Memos = {}

function Memoize<K, V>(callbackFn : (K) -> V) : (K) -> V
	local memo = Memos[callbackFn]
	return function(key : K) : V
		if memo[key] == nil then
			memo[key] = callbackFn(key)
		end
		return memo[key]
	end
end

return Memoize