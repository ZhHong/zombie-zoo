local CCBString = import(".ccb_string")
local loader = import(".ccb_loader")
local CCB = {}

CCB.EN = 0
CCB.ZH_HANS = 1

function CCB.init( config )
	local translation = CCBString.new(config.translation_file, language)

	local cfg = config
	config.controlButtonUseBMFont = false
	config.translation = translation

	loader.init(cfg)
end

function CCB.load(jsonFileName, callbacks, root)
	return loader.load(jsonFileName, callbacks, root)
end

return CCB