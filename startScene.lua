local storyboard 	= require "storyboard"
local scene 		= storyboard.newScene()

function scene:createScene(e)

--[[	local backgroundgroup = display.newGroup()   
	local buttongroup = display.newGroup()

	local sky = display.newImageRect(backgroundgroup,"art/sky.png",1000,1000)
   		sky.x =_W*.5
    	sky.y =_H*.5
    	backgroundgroup:toBack()

    local startbutton = display.newImageRect(buttongroup,"art/startbutton.png",317,144)
    	startbutton.xScale = .6
    	startbutton.yScale = .6
    	
    	startbutton.x = _W*.4
    	startbutton.y = _H*.8

    local optionbutton = display.newImageRect(buttongroup,"art/optionsbutton.png",225,231)
    	optionbutton.xScale = .4
    	optionbutton.yScale = .4
    	
    	optionbutton.x = _W*.8
    	optionbutton.y = _H*.6

    local scorebutton = display.newImageRect(buttongroup,"art/scorebutton.png",225,231)
    	scorebutton.xScale = .4
    	scorebutton.yScale = .4
    	
    	scorebutton.x = _W*.7
    	scorebutton.y = _H*.4

]]

	local sceneView = self.view
	
	--[[	  VARIABLES		]]--

	local menuTransition
	local menuTransition2
	local buttonGroup
	local menuDown = false


	--[[	BACKGROUND 		]]--


	display.setDefault( "magTextureFilter", "nearest" )
	display.setDefault( "minTextureFilter", "nearest" )

	local p = {}
	local parallax2 = display.newGroup()
	local parallax1 = display.newGroup()
	--local doge = display.newGroup()
	sceneView:insert(parallax2)
	sceneView:insert(parallax1)


	function makescene()
		--[[
		doge_body = display.newImageRect(doge,"art/startScreen/doge.png",32,32)
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

		parallax2.layer1_1=display.newImageRect(parallax2,"art/startScreen/mountain.png", 64,128)
		parallax2.layer1_1.xScale = 2
		parallax2.layer1_1.yScale = 2
		parallax2.layer1_1.x = _W/2
		parallax2.layer1_1.y = _H*.64

		parallax2.layer1_2=display.newImageRect(parallax2,"art/startScreen/mountain.png", 64,128)
		parallax2.layer1_2.xScale = 2
		parallax2.layer1_2.yScale = 2
		parallax2.layer1_2.x = _W/2 + 512
		parallax2.layer1_2.y = _H*.64

		parallax1.layer1_1=display.newImageRect(parallax1,"art/startScreen/bushes.png", 256,64)
		parallax1.layer1_1.xScale = 2
		parallax1.layer1_1.yScale = 2
		parallax1.layer1_1.x = _W/2
		parallax1.layer1_1.y = _H*.74

		parallax1.layer1_2=display.newImageRect(parallax1,"art/startScreen/bushes.png", 256,64)
		parallax1.layer1_2.xScale = 2
		parallax1.layer1_2.yScale = 2
		parallax1.layer1_2.x = _W/2 + 512
		parallax1.layer1_2.y = _H*.74

		parallax1.layer2_1=display.newImageRect(parallax2,"art/startScreen/clouds.png", 256,64)
		parallax1.layer2_1.xScale = 2
		parallax1.layer2_1.yScale = 2
		parallax1.layer2_1.x = _W/2
		parallax1.layer2_1.y = _H*.02

		parallax1.layer2_2=display.newImageRect(parallax2,"art/startScreen/clouds.png", 256,64)
		parallax1.layer2_2.xScale = 2
		parallax1.layer2_2.yScale = 2
		parallax1.layer2_2.x = _W/2 + 512
		parallax1.layer2_2.y = _H*.02


		floorgroup = display.newGroup()
		topgroup = display.newGroup()

		local sky = display.newImageRect ("art/backdrop/backdrop.png",_W,_H)
			sky:setFillColor(.5,.6,.9)
			sky.x = _W*.5
			sky.y = _H*.4
		
		local ground_top_1 = display.newImageRect(topgroup,"art/startScreen/ground_top_2.png",701,64)
			ground_top_1.xScale = 1
			ground_top_1.yScale = 1
			ground_top_1.x = _W*.5
			ground_top_1.y = _H*.84

		local ground_top_2 = display.newImageRect(topgroup,"art/startScreen/ground_top_2.png",701,64)
			ground_top_2.xScale = 1
			ground_top_2.yScale = 1
			ground_top_2.x = _W*.5 + 700
			ground_top_2.y = _H*.84
			
		local floorbottom = display.newRect(floorgroup,0,0,_W,_H)
			floorbottom.x = _W/2
			floorbottom.y = _H*1.3
			floorbottom:setFillColor(.62,.37,.16)

		floorgroup:insert(topgroup)
		sceneView:insert(floorgroup)
		sky:toBack()

		floorgroup.y = _H*.1
	end 

	local c = 0 

	function move(speed)

		c = c + 1 

		p.position1 = p.position1 - speed

		if p.position1 < -700 then 
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
		--doge.y =_H * .4 + math.sin(c/10)*5
		--doge_tail.rotation = 0 + math.sin(c/3)*10
	end

	function dostuff()
		move (1.5)
	end 


	makescene()
	Runtime:addEventListener("enterFrame",dostuff)

	--[[		MENU 		]]--
	

	local function startGame(event)
		menuTransitionFunc("startGame")
	end

	local function startOptions()
		menuTransitionFunc("startGame")
	end

	local function startHelp()
		menuTransitionFunc("startGame")
	end

	local menuFunc	= { 
						{ 
						EventListener=startGame,
						Label="START",
						}, 
						{ 
						EventListener=startOptions,
						Label="OPTIONS",
						}, 
						{ 
						EventListener=startHelp,
						Label="HELP",
						}, 
					}

	local menuList	= {"START","OPTIONS","HELP"}

	local menuGroup = display.newGroup()
	menuGroup.x, menuGroup.y = _W*.5, -_H
	menuGroup.alpha = .5
	menuGroup:toFront()

	local menuRect = display.newRect(menuGroup,0,0,250,350)
	
	for i=1,#menuList do
		buttonGroup	= display.newGroup()
		buttonGroup.y = -180

		local buttons = display.newRect(buttonGroup,0,0,120,60)
		buttons.y = buttons.height*i*1.5
		
		local buttonText = display.newText(buttonGroup,menuFunc[i].Label,0,0,nil,14)
		buttonText.x, buttonText.y = buttons.x, buttons.y

		menuGroup:insert(buttonGroup)

		buttonGroup:addEventListener("tap",menuFunc[i].EventListener)

		function removeEventListeners()
			print("Delete EventListener")
			buttonGroup:removeEventListener("tap",menuFunc[i].EventListener)
		end
	end

	--[[	   EFFECTS 		]]--



	function transitionFunc(object,timeTrans,yPos,transitionType,completed)
		local transition = transition.to(object,{time=timeTrans,y=yPos,transition=transitionType,onComplete=completed})
		print("Here again")
	end

	function menuTransitionFunc(scene)
		if not menuDown then
			transitionFunc(menuGroup,100,_H*.55,easing.InOutQuad,function()
				transitionFunc(menuGroup,100,_H*.5,easing.InOutQuad)
			end)
			menuDown = true
		else
			transitionFunc(menuGroup,100,_H*.55,easing.InOutQuad,function()
				transitionFunc(menuGroup,100,-_H,easing.InOutQuad,function()
					storyboard.gotoScene(scene)
				end)
			end)
		end
	end
	sceneView:insert(menuGroup)
	menuTransitionFunc()



end 

function scene:enterScene(e)
	
end 

function scene:exitScene(e)

removeEventListeners()
display.remove(menuRect)
display.remove(startButton)
display.remove(optionsButton)
display.remove(helpButton)
display.remove(menuGroup)

display.remove(startbutton)
display.remove(optionbutton)
display.remove(scorebutton)



display.remove(buttonGroup)
display.remove(backgroundGroup)

display.remove(parallax2)
display.remove(parallax1)
display.remove(parallax2)
display.remove(layer1_1)
display.remove(parallax2)
display.remove(layer1_2)
display.remove(layer1_2)
display.remove(parallax1)
display.remove(layer1_1)
display.remove(parallax1)
display.remove(layer1_2)
display.remove(parallax1)
display.remove(layer2_1)
display.remove(parallax1)
display.remove(layer2_2)
display.remove(floorgroup)
display.remove(topgroup)
display.remove(sky)
display.remove(ground_top_1)
display.remove(ground_top_2)
display.remove(floorbottom)

menuTransition2 = nil
menuTransition 	= nil

Runtime:removeEventListener("enterFrame",dostuff)

local sceneView = self.view

end 

function scene:destroyScene(e)
end





scene:addEventListener("createScene",scene)
scene:addEventListener("enterScene",scene)
scene:addEventListener("exitScene",scene)
scene:addEventListener("destroyScene",scene)
return scene
