local utils = {}

-- highly used cocos2d-x helper functions

function utils.push_button(text, callback)
     return cc.ui.UIPushButton.new("#ui_button_middle.png", {scale9 = true})
                :setButtonSize(200, 80)
                :setButtonLabel(cc.ui.UILabel.new({text = text, size = 24, color = display.COLOR_WHITE}))
                :onButtonPressed(function(event)
                    
                end)
                :onButtonRelease(function(event)
                    if callback then
                        callback()
                    end
                end)
                :onButtonClicked(function(event)
                
                end)
end

function utils.delay_call(delay, call, ...)
    -- newer Lua version compatitable
    local unpack = unpack or table.unpack
    local delayTime = cc.DelayTime:create(delay)
    local args = {...}
    local callfunc = cc.CallFunc:create(function()
        if call and type(call) == 'function' then
            return call(unpack(args))
        end
    end)
    return cc.Sequence:create(delayTime, callfunc)
end

function utils.contains(node, x, y)
    local p = node:convertToNodeSpace(cc.p(x, y))
    local size = node:getContentSize()
    local rect = cc.rect(0, 0, size.width, size.height)
    return cc.rectContainsPoint(rect, p)
end

function utils.sec2str(sec)
    local min = math.floor(sec / 60)
    local sec = sec % 60
    return string.format("%.2d:%.2d", min, sec)
end

function utils.set_ctrl_btn(btn, callback, sound)
    if btn then
        btn:registerControlEventHandler(function()
            if sound then
                audio.playSound(sound, false)
            end
            return callback()
        end, cc.CONTROL_EVENTTYPE_TOUCH_UP_INSIDE)
    else
        assert(false, "Error in function setCtrlBtnEvent(), btn is nil!")
    end
end

function utils.sec2min(sec)
    local s = sec % 60
    local m = sec / 60
    return string.format("%02d : %02d", m, s)
end

function utils.loadfile2string(fileName)
    if device.platform == 'windows' then
        return cc.HelperFunc:getFileData("res/"..fileName)
    else
        return cc.HelperFunc:getFileData(fileName)
    end
end

function utils.ispc()
    return device.platform == "windows" or device.platform == "mac"
end

function utils.isphone()
    return device.platform == "ios" or device.platform == "android"
end

function utils.getdeviceid()
    if utils.ispc() then
        return device:getOpenUDID()
    else
        return TalkingDataGA:getDeviceId()
    end
end

function utils.left_bottom(node)
    local x, y = node:getPosition()
    local anchor = node:getAnchorPoint()
    local size = node:getContentSize()

    return x - size.width*anchor.x, y - size.height*anchor.y

end

return utils
