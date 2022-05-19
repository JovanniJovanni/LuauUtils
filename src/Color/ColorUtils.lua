--[=[
	@class ColorUtils
]=]
local ColorUtils = {}

export type HSV = {
	h : number,
	s : number,
	v : number
}

export type RGB = {
	r : number,
	g : number,
	b : number
}


function ColorUtils.RBGtoHSV(rgb : RGB) : HSV
	local maxc = math.max(unpack(rgb))
	local minc = math.min(unpack(rgb))
	local v = maxc

	if minc == maxc then return {h = 0, s = 0, v = v} end

	local s = (maxc - minc) / maxc
	local rc = (maxc - rgb.r) / (maxc - minc)
	local gc = (maxc - rgb.g) / (maxc - minc)
	local bc = (maxc - rgb.b) / (maxc - minc)

	local h

	if rgb.r == maxc then 
		h = bc - gc
	elseif rgb.g == maxc then
		h = 2 + rc - bc
	else
		h = 4 + gc - rc
	end
	h /= 6

	return {h = h, s = s, v = v}
end


function ColorUtils.HSVtoRGB(hsv : HSV) : RGB
	if hsv.s == 0 then return {r = hsv.v, g = hsv.v, b = hsv.v} end

	local i = math.floor(hsv.h * 6)
	local f = hsv.h * 6 - i
	local p = hsv.v * (1 - hsv.s)
	local q = hsv.v * (1 - f * hsv.s)
	local t = hsv.v * (1 - hsv.s * (1 - f))
	i %= 6

	local HSVtoRGBswitch = {
		{r = hsv.v, g = t, b = p},
		{r = q, g = hsv.v, b = p},
		{r = p, g = hsv.v, b = t},
		{r = p, g = q, b = hsv.v},
		{r = t, g = p, b = hsv.v},
		{r = hsv.v, g = p, b = q}
	}

	return HSVtoRGBswitch[i + 1] -- +1 because tables are 1-indexed
end

return ColorUtils