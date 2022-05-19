--[=[
	@class Math
]=]
--[=[
	@within Math
	@prop e number
	Euler's Number to the eigth decimal place (2.71828183)
]=]
local Math = setmetatable({
	e = 2.71828183

}, {
	__index = math
})

--[=[
	@param x number
	@return number
	Returns the cotangent of x.
]=]
function Math.cot(x : number) : number
	return 1 / Math.tan(x)
end

--[=[
	@param x number
	@return number
	Returns the hyperbolic cotangent of x.
]=]
function Math.coth(x : number) : number
	return 1 / Math.tanh(x)
end

--[=[
	@param x number
	@return number
	Returns the cosecant of x.
]=]
function Math.csc(x : number) : number
	return 1 / Math.sin(x)
end

--[=[
	@param x number
	@return number
	Returns the hyperbolic cosecant of x.
]=]
function Math.csch(x : number) : number
	return 1 / Math.sinh(x)
end

--[=[
	@function factorial
	@within Math
	@param n number
	@return number
	Returns the factorial of n.
]=]
local factorialMemo : {number} = {[0] = 1}
function Math.factorial(n : number) : number
	if not factorialMemo[n] then
		local result = 1
		for i = n, 2, -1 do
			result *= i
		end
		factorialMemo[n] = result
	end
	return factorialMemo[n]
end

--[=[
	@param ... number
	@return number
	Returns the mean of the given numbers.
]=]
function Math.mean(... : number) : number
	local args = {...}
	local sum = 0
	for _, v in ipairs(args) do
		sum += v
	end
	return sum / #args
end

--[=[
	@param ... number
	@return number

	Returns the median of the given numbers.
]=]
function Math.median(... : number) : number
	local args = {...}
	table.sort(args)
	local middle = #args / 2
	if math.floor(middle) == middle then
		return (args[middle] + args[middle - 1]) / 2
	else
		return args[math.floor(middle)]
	end
end

--[=[
	@param n number
	@param r number
	@return number
]=]
function Math.nCr(n : number, r : number) : number
	return Math.factorial(n) / (Math.factorial(r) * Math.factorial(n - r))
end
Math.combinations = Math.nCr

--[=[
	@param n number
	@param r number
	@return number
]=]
function Math.nPr(n : number, r : number) : number
	return Math.factorial(n) / Math.factorial(n - r)
end
Math.permutations = Math.nPr

--[=[
	@param radicand number
	@param index number
	@return number

	Returns the nth root of radicand. Equivalent to `radicand ^ (1 / index)`.
]=]
function Math.root(radicand : number, index : number) : number
	return radicand ^ (1 / index)
end

--[=[
	@param x number
	@return number
	Returns the secant of x.
]=]
function Math.sec(x : number) : number
	return 1 / Math.cos(x)
end

--[=[
	@param x number
	@return number
	Returns the hyperbolic secant of x.
]=]
function Math.sech(x : number) : number
	return 1 / Math.cosh(x)
end

--[=[
	@param i number -- index of summation
	@param n number -- upper limit of summation
	@param callbackFn (index : number, last : number) -> number -- function to call for each iteration
	@return number

	Returns the summation of the function callbackFn(index, last) from i to n.
]=]
function Math.summation(i : number, n : number, callbackFn : (number, number) -> number) : number
	local sum = 0
	local last
	for iteration = i, n do
		last = callbackFn(iteration, last)
		sum += last
	end
	return sum
end

--[=[
	@param x number
	@return number
	Removes the decimal places of x.
	]=]
function Math.trunc(x : number) : number
	return if x % 1 < 0.5 then math.floor(x) else math.ceil(x)
end

return Math