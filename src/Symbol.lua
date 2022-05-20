--[=[
	@class Symbol
	Unique symbol identifier.
]=]
local Symbol = {}
--[=[
	@type Type { @metatable: Symbol }
	@within Symbol
]=]


--[=[
	@param name string

	Creates a new Symbol, can also be called by using `Symbol("foo")`
]=]
function Symbol.new(name: string)
	return setmetatable({}, {
		__tostring = function()
			return ("Symbol<%s>"):format(name or "")
		end
	})
end

--[=[
	@param object any
	@return boolean
	Returns true if the object is a Symbol
]=]
function Symbol.Is(object : any) : boolean
	return type(object) == "table" and getmetatable(object) == Symbol
end

export type Type = typeof(Symbol.new(""))

return setmetatable(Symbol, {
	__call = function(_, name)
		return Symbol.new(name)
	end
})