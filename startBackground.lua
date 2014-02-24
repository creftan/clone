_W = display.contentWidth
_H = display.contentHeight
aud.playMusic("Audio/menu.mp3")
local storyboard    = require "storyboard"
local scene         = storyboard.newScene()



function scene:createScene(e)
local creditsstring = "Code : Oskar Andersson, Stian Saunes, Mikael Isaksson   Gfx : Stian Saunes   Music : Modulf (Moffus) Vartdal"

local sceneView = self.view
	
	display.setDefault( "magTextureFilter", "nearest" )
	display.setDefault( "minTextureFilter", "nearest" )

	p = {}
	parallax2 = display.newGroup()
	parallax1 = display.newGroup()
	parallax2:toBack()
	 
	--local doge = display.newGroup()
	--sceneView:insert(parallax2)
	--sceneView:insert(parallax1)


	function makescene()
		createdBackground = true
		--[[
		doge_body = display.newImageRect(doge,"art/startscreen/doge.png",32,32)
		doge_tail = display.newImageRect(doge,"art/startscreen/doge_tail.png",32,32)
		doge_body.xScale = 2
		doge_body.yScale = 2
		doge_tail.xScale = 2
		doge_tail.yScale = 2

		doge.x = _W * .25
		doge.y = _H * .4
		doge.isVisible = false
		]]--
		p.position1 = 0 
		p.position2 = 0 
		p.position3 = 0 

	logo = display.newImageRect("art/startscreen/logo.png", 226,60)
	logo.xScale = 2
	logo.yScale = 2
	logo.x = _W*.5
	logo.y = _H*.15
	
	copy = display.newImageRect("art/startscreen/copyright.png", 260,20)
	copy.xScale = 1
	copy.yScale = 1
	copy.x = _W*.5
	copy.y = _H*.25
	

		parallax2.layer1_1=display.newImageRect(parallax2,"art/startscreen/mountain.png", 64,128)
		parallax2.layer1_1.xScale = 2
		parallax2.layer1_1.yScale = 2
		parallax2.layer1_1.x = _W/2
		parallax2.layer1_1.y = _H*.64

		parallax2.layer1_2=display.newImageRect(parallax2,"art/startscreen/mountain.png", 64,128)
		parallax2.layer1_2.xScale = 2
		parallax2.layer1_2.yScale = 2
		parallax2.layer1_2.x = _W/2 + 512
		parallax2.layer1_2.y = _H*.64

		parallax2.layer3_1=display.newImageRect(parallax2,"art/startscreen/mountain_2.png", 64,128)
		parallax2.layer3_1.xScale = 2
		parallax2.layer3_1.yScale = 2
		parallax2.layer3_1.x = _W/2 + 300
		parallax2.layer3_1.y = _H*.64

		parallax2.layer3_2=display.newImageRect(parallax2,"art/startscreen/mountain_2.png", 64,128)
		parallax2.layer3_2.xScale = 2
		parallax2.layer3_2.yScale = 2
		parallax2.layer3_2.x = _W/2 + 812
		parallax2.layer3_2.y = _H*.64


		parallax1.layer1_1=display.newImageRect(parallax1,"art/startscreen/bushes.png", 256,64)
		parallax1.layer1_1.xScale = 2
		parallax1.layer1_1.yScale = 2
		parallax1.layer1_1.x = _W/2
		parallax1.layer1_1.y = _H*.74

		parallax1.layer1_2=display.newImageRect(parallax1,"art/startscreen/bushes.png", 256,64)
		parallax1.layer1_2.xScale = 2
		parallax1.layer1_2.yScale = 2
		parallax1.layer1_2.x = _W/2 + 512
		parallax1.layer1_2.y = _H*.74

		parallax1.layer2_1=display.newImageRect(parallax2,"art/startscreen/clouds.png", 256,64)
		parallax1.layer2_1.xScale = 2
		parallax1.layer2_1.yScale = 2
		parallax1.layer2_1.x = _W/2
		parallax1.layer2_1.y = _H*.02

		parallax1.layer2_2=display.newImageRect(parallax2,"art/startscreen/clouds.png", 256,64)
		parallax1.layer2_2.xScale = 2
		parallax1.layer2_2.yScale = 2
		parallax1.layer2_2.x = _W/2 + 512
		parallax1.layer2_2.y = _H*.02


		floorgroup = display.newGroup()
		topgroup = display.newGroup()

		sky = display.newImage ("art/Backdrop/backdrop.png")
			sky:setFillColor(.5,.6,.9)
			sky.x = _W*.5
			sky.y = _H*.4
		
		ground_top_1 = display.newImageRect(topgroup,"art/startscreen/ground_top_2.png",692,129)
			ground_top_1.xScale = 1
			ground_top_1.yScale = 1
			ground_top_1.x = _W*.5
			ground_top_1.y = _H*.90

		ground_top_2 = display.newImageRect(topgroup,"art/startscreen/ground_top_2.png",692,129)
			ground_top_2.xScale = 1
			ground_top_2.yScale = 1
			ground_top_2.x = _W*.5 + 692
			ground_top_2.y = _H*.90
			
		function rgbv(val)
			local answer = val / 256
			return answer
		end

		floorbottom = display.newRect(floorgroup,0,0,_W,_H)
			floorbottom.x = _W/2
			floorbottom.y = _H*1.3
			floorbottom:setFillColor(rgbv(160),rgbv(96),rgbv(40))

		floorgroup:insert(topgroup)
		--sceneView:insert(floorgroup)
		sky:toBack()
		copy:toFront()
		floorgroup.y = _H*.1

	creditstext = display.newText(creditsstring, 0,0, "Ponderosa", 10)
	creditstext.y = _H*.885
	creditstext.x = (creditstext.contentWidth)


	
	end 

	local c = 0 

	function move(speed)
		creditstext.x = creditstext.x - 2
		if creditstext.x == -600 then creditstext.x = creditstext.contentWidth end 
		c = c + .1 

		p.position1 = p.position1 - speed

		if p.position1 < -692 then 
			p.position1 = 0 
		end

		topgroup.x = p.position 

		p.position2 = p.position2 - speed*.5
		if p.position2 < -512 then 
			p.position2 = 0 
		end

		p.position3 = p.position3 - speed*.33
		if p.position3 < -512 then 
			p.position3 = 0 
		end

		topgroup.x = p.position1
		parallax1.x = p.position2 
		parallax2.x = p.position3 
		
		logo.y = _H*.15 + math.sin(c)*3
		copy.y = _H*.25 + math.sin(c+5)*3

		--doge.y =_H * .4 + math.sin(c/10)*5
		--doge_tail.rotation = 0 + math.sin(c/3)*10
	end

	if not createdBackground then 
		function dostuff()
			move (1.5)
		end 

		makescene()
		Runtime:addEventListener("enterFrame",dostuff)
	end
	storyboard.gotoScene("startScene")
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
