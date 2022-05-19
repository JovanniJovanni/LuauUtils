--[=[
	@class ColorUtils
]=]
local ColorUtils = {}

type HSV = {
	h : number,
	s : number,
	v : number
}

type RGB = {
	r : number,
	g : number,
	b : number
}


function ColorUtils.RBGtoHex(color : RGB) : string
	local r, g, b = tostring(color.r), tostring(color.g), tostring(color.b)
	
	if #r == 1 then
		r = "0" .. r
	end
	if #g == 1 then
		g = "0" .. g
	end
	if #b == 1 then
		b = "0" .. b
	end

	return ("#%s%s%s"):format(r,g,b)
end

function ColorUtils.HextoRGB(hex : string) : RGB
	if #hex == 4 then
		return 
	end

	return {}
end

return ColorUtils