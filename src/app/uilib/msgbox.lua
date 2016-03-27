local msgbox = class("msgbox", function(...)
        return display.newNode()
    end)

local MSG_BOX_CONTENT_X_MARGIN = 10
local MSG_BOX_TITLE_Y_OFFSET = -20

local function contains(node, x, y)
    local p = node:convertToNodeSpace(cc.p(x, y))
    local size = node:getContentSize()
    local rect = cc.rect(0, 0, size.width, size.height)
    return cc.rectContainsPoint(rect, p)
end

local ZORDER_BG = 0
function msgbox:ctor(op)
    local options
    if not op then 
        options = {} 
    else
        options = op
    end
    
    local title = options.title or "msgbox title"
    local content = options.content or "no msgbox content, if this is too long to display something!"

    local background = options.background or "#ui_rect_bg.png"
    local ensureCallback = options.ensureCallback or function() print("not set msgbox Ensure!") end
    local bmfontName = options.bmfont_name or defaultBMFontName()
    local ttf_font_name = options.ttf_font_name or defaultTTFFontName()
    
    self.closeCallback = options.closeCallback

    local size = options.size or cc.size(500, 300)

    -- set the ccbox to ensure all the events can be captured by this ui
    self:setCascadeBoundingBox(cc.rect(0, 0, display.width, display.height))
     
    -- create the background
    local bg = display.newScale9Sprite(background)
    bg:setAnchorPoint(cc.p(0.5, 0.5))
    bg:setLocalZOrder(ZORDER_BG)
    self:addChild(bg)


    -- create the title
    local titleLabel = display.newBMFontLabel({ 
                                    text = title,
                                    font = bmfontName,
                                    })

    if titleLabel:getContentSize().width > size.width then
        size.width = titleLabel:getContentSize().width
    end


    -- create the content
    local contentLabel = display.newTTFLabel( {
                text = content,
                font = ttf_font_name,
                size = MSG_BOX_TITLE_FONT_SIZE,
                -- valign = cc.VERTICAL_TEXT_ALIGNMENT_CENTER,
        })

    local dimenionWidth = size.width - MSG_BOX_CONTENT_X_MARGIN
    local contentLabelWidth = contentLabel:getContentSize().width
    if  contentLabelWidth < size.width then
        dimenionWidth = contentLabelWidth
    end

    contentLabel:setDimensions(dimenionWidth, size.height)
    contentLabel:setPosition(cc.p(size.width/2, size.height/2))
    contentLabel:setAnchorPoint(cc.p(0.5, 1))
    self:addChild(contentLabel)

    -- add the ensure Btn
    local norSprite = display.newScale9Sprite("#ui_button_confirm_big.png")

    if options.ensure_btn_enable then
        local ensurebtn =  cc.ControlButton:create(norSprite)

        local btnSize = cc.size(110, 85)
        ensurebtn:setBackgroundSpriteForState(norSprite, cc.CONTROL_STATE_NORMAL)
        ensurebtn:setPreferredSize(cc.size(110, 85))
        ensurebtn:setPosition(cc.p(size.width, 0))
        ensurebtn:setZoomOnTouchDown(true)
        ensurebtn:registerControlEventHandler(ensureCallback, cc.CONTROL_EVENTTYPE_TOUCH_UP_INSIDE )

        self:addChild(ensurebtn)
    end


    -- set the content size before set position
    self:setContentSize(size)
    

    -- add 
    bg:setPreferredSize(size)
    bg:setPosition(cc.p( size.width/2, size.height/2 ))

    titleLabel:setAnchorPoint(cc.p(0.5, 1))
    titleLabel:setPosition(cc.p(size.width/2, size.height + MSG_BOX_TITLE_Y_OFFSET))


    self:setAnchorPoint(cc.p(0.5, 0.5))
    self:setPosition(cc.p(display.width/2, display.height/2))

    self:addChild(titleLabel)

    self:setNodeEventEnabled(true)
    self:setTouchEnabled(true)
    self.listener = self:addNodeEventListener(cc.NODE_TOUCH_EVENT, handler(self, self.onTouch))
end

function msgbox:onTouch(event)
      if event.name == "ended" then
        if not contains(self, event.x, event.y) then
            if self.closeCallback and type(self.closeCallback) == 'function' then 
                self.closeCallback()
            end
            self:remove()
        else
        end
    end
    return true
end

function msgbox:display()
    self:setScale(0)
    local scaleToMax = cc.EaseElasticOut:create(cc.ScaleTo:create(0.618, 1))
    self:runAction(scaleToMax)
    display.getRunningScene():addChild(self)
end

function msgbox:remove()
    local scaleToMin = (cc.ScaleTo:create(0.1, 0))
    local remove = cc.CallFunc:create(function() self:removeFromParent() end)
    local seq = cc.Sequence:create(scaleToMin, remove)
    self:runAction(seq)
end


return msgbox