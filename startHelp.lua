local storyboard    = require "storyboard"
local scene         = storyboard.newScene()

function scene:createScene(e)

local sceneView = self.view
	local _W= display.contentWidth
	local _H = display.contentHeight
	bg = display.newImage("art/startscreen/3ofus.png",0,0)
	bg.x, bg.y = _W*.5, _H*.5
end 

function scene:enterScene(e)
    
end 

function scene:exitScene(e)


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
