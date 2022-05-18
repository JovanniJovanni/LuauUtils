local function Symbol(name: string)
	return setmetatable({}, {
		__tostring = function()
			return ("Symbol<%s>"):format(name)
		end
	})
end


return Symbol