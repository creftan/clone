local storyboard    = require "storyboard"
local audiooo 		= require("audioo")
local scene         = storyboard.newScene()

--display.setDefault( "background", 255, 255, 255 )
display.setDefault( "magTextureFilter", "nearest" )

display.setDefault( "minTextureFilter", "nearest" )

function scene:createScene(e)

local sceneView = self.view
	local _W= display.contentWidth
	local _H = display.contentHeight
	bgRect = display.newRect(0,0,_W*1.5,_H*1.5)
	bgRect.x, bgRect.y = _W*.5, _H*.5
	bgRect:setFillColor(0)
	
	bg = display.newImage("art/startscreen/3ofus.png",0,0)
	bg.x, bg.y = _W*.5, -100
	bg.xScale, bg.yScale = 2,2
	
	sceneView:insert(bgRect)
	sceneView:insert(bg)
	
	tim2 = timer.performWithDelay(500,function()
		transition.to(bg,{ time = 100, y = _H*.5, transition = easing.InOutQuad})
		aud.play(sounds.splash)
	end) 
	tim = timer.performWithDelay(3000,function()
		transition.to(bg,{ time = 100, y = _H*1.5, transition = easing.InOutQuad, onComplete = function() 
		storyboard.gotoScene("startBackground")
		end })
	end)
end 

function scene:enterScene(e)
    
end 

function scene:exitScene(e)

tim = nil
tim2 = nil
local sceneView = self.view

end 

function scene:destroyScene(e)
    local sceneView = self.view
end





scene:addEventListener("createScene",scene)
scene:addEventListener("enterScene",scene)
scene:addEventListener("exitScene",scene)
scene:addEventListener("destroyScene",scene)
return scene
