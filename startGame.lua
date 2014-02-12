local storyboard 	= require "storyboard"
local scene 		= storyboard.newScene()

function scene:createScene(e)
	local sceneView = self.view

--display.setDefault( "magTextureFilter", "nearest" )
--display.setDefault( "minTextureFilter", "nearest" )

-------------------------------------------
local Physics     = require( "physics" )
local ObjectManager = require("ObjectManager")
                    --require( "sprite" )
Physics.start();
--Physics.setDrawMode( "hybrid" );
-------------------------------------------


local string = "0"
local ScoreBoard = display.newText(string, 10, 10, native.systemFont, 10)
    --ScoreBoard:setFillColor(1,1,1)





local function PrintScore(Score)
    print ("Score  "..Score)
    ScoreBoard.text = Score
end


-- Important Part
-------------------------------------------------------
local CamMaxX = display.viewableContentWidth
local CamMaxY = display.viewableContentHeight
local WorldSpeed = 85
local DayNightSpeed = 0.5
local Gravity = 50
local FlappBoost= 400;
-- Info: Initiate ObjectManager, firstvalue: Physics pointer, next 4 walues: screen min and max, WorldSpeed: is a general gameplayspeed, DayNightSpeed is the night and day speedfactor, Gravity: quite self explanible, FlappBoost: the force that doge uses each tap
ObjectManager:Init(Physics, -70, CamMaxX, -50, CamMaxY, WorldSpeed, DayNightSpeed, Gravity, FlappBoost);

local function Update (event)
        ObjectManager:Update(event);
end
--Runtime:addEventListener( "enterFrame", Update )
--FULFIX 
timer.performWithDelay(1,function()
	Runtime:addEventListener( "enterFrame", Update )
end)

-------------------------------------------------------

 

end 

function scene:enterScene(e)
	
end 

function scene:exitScene(e)



end 

function scene:destroyScene(e)
end





scene:addEventListener("createScene",scene)
scene:addEventListener("enterScene",scene)
scene:addEventListener("exitScene",scene)
scene:addEventListener("destroyScene",scene)
return scene
