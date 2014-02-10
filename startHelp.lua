local storyboard    = require "storyboard"
local scene         = storyboard.newScene()

function scene:createScene(e)

local sceneView = self.view
	function changeScene()
		local previousScene=storyboard.getPrevious()
		storyboard.gotoScene(previousScene)
	end

	timer.performWithDelay(1000,changeScene)
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
