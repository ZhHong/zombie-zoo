require("config")
require("framework.init")
require("framework.shortcodes")
require("framework.cc.init")

require("socket")

require("app.statics.consts")

print_r = require("app.statics.print_r")
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
                fonts_root_path = "", 
                translation_file = "fonts/Strings.json", })
    self.ccb = ccb

    local timer_mananger = require("app.network.timer_mananger")
    timer_mananger.init()

    self.timer_mananger = timer_mananger
end

function game:run()
    
    GAME = self

    math.newrandomseed(socket.gettime())
    cc.FileUtils:getInstance():addSearchPath("res/")
    cc.FileUtils:getInstance():addSearchPath("res/images")
    
    initModules(self)

    self:enterScene("login_scene")
end

function game:stop()
    self.timer_mananger.destory()
end


return game

