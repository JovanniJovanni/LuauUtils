local function Symbol(name: string)
	return setmetatable({}, {
		__tostring = function()
			return ("Symbol<%s>"):format(name)
		end
	})
end


return setmetatable({new = Symbol}, {
	__call = function(_, name)
		return Symbol(name)
	end
})