------------------------------------------------------------
-- INTERNAL
------------------------------------------------------------

function round(num)
	return num + (2^52 + 2^51) - (2^52 + 2^51)
end

function _hsv(h, s, v)
	if s <= 0 then return v,v,v end
	h = h*6
	local c = v*s
	local x = (1-math.abs((h%2)-1))*c
	local m,r,g,b = (v-c), 0, 0, 0
	if h < 1 then
		r, g, b = c, x, 0
	elseif h < 2 then
		r, g, b = x, c, 0
	elseif h < 3 then
		r, g, b = 0, c, x
	elseif h < 4 then
		r, g, b = 0, x, c
	elseif h < 5 then
		r, g, b = x, 0, c
	else
		r, g, b = c, 0, x
	end
	return r+m, g+m, b+m
end

function _hex(v)
	return string.format("%02x", round(255 * v))
end

------------------------------------------------------------
-- EXPORTED
------------------------------------------------------------

hsv = function(h, s, v)
	local r, g, b = _hsv(h, s, v)
	return string.format("#%s%s%s", _hex(r), _hex(g), _hex(b))
end

return hsv
