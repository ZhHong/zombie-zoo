-- spine events
SP_ANIMATION_START = 0
SP_ANIMATION_END = 1
SP_ANIMATION_COMPLETE = 2
SP_ANIMATION_EVENT = 3

-- resource related constants
local bmfonts = {
    cn = "fonts/font_en_hd.fnt", 
    en = "fonts/font_en_hd.fnt"
}

local ttffonts = {
    cn = "",
    en = "",
}

function defaultBMFontName()
    return bmfonts[device.language] or bmfonts.en
end

function defaultTTFFontName()
    return ttffonts[device.language] or ""
end


-- game constants
ACTOR_CAEMRA_FLAG = 2