local CCBString = class("CCBString")

local deepCopy = import(".ccb_tools").deepCopy
function CCBString:ctor(path, language)
    self.language = language
    assert(path, language)

    local data = cc.HelperFunc:getFileData(path)
    if data then
        local json = json.decode(data)

        -- create key-value index
        self.translations = {}
        for i = 1,#json.translations do
            local t = json.translations[i]
            local translation = {}
            deepCopy(translation, t.translations)
            self.translations[t.key] = translation
        end
    else
        assert(false, "Fail to find translation in path = " .. path)
    end
end


local languageCodeStr = {}
languageCodeStr[cc.LANGUAGE_ENGLISH] = "en"
languageCodeStr[cc.LANGUAGE_CHINESE] = "zh-Hans"


function CCBString:str(key)
    local l = self.language or 0
    local code = languageCodeStr[l]
    return self.translations[key][code]
end

return CCBString