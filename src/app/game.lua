require("config")
require("framework.init")
require("framework.shortcodes")
require("framework.cc.init")

require("socket")

require("app.statics.consts")

local game = class("game", cc.mvc.AppBase)

function game:ctor()
    game.super.ctor(self)
end

local function initControls(self)
    self.bc = require("app.controls.BattleControl").new()
    self.mc = require("app.controls.MonsterControl").new()
end

local function initModules(self)
    
    local ccb = require("app.spritebuilder.ccb")
    ccb.init({ language = device.language, 
                defaultBMFontPath = defaultBMFontName(), 
                fonts_root_path = "fonts/", 
                translation_file = "fonts/Strings.json", })
    self.ccb = ccb
end

function game:run()
    
    game = self

    math.newrandomseed(socket.gettime())
    cc.FileUtils:getInstance():addSearchPath("res/")
    cc.FileUtils:getInstance():addSearchPath("res/images")
    
    initModules(self)

    self:enterScene("game_scene")
end


return game

