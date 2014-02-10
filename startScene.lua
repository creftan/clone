local storyboard 	= require "storyboard"
local scene 		= storyboard.newScene()

function scene:createScene(e)
	local sceneView = self.view
	print("Enter scene")


	print(menuDown)
	--[[	  VARIABLES		]]--

	local menuTransition
	local menuTransition2
	local buttonGroup
	local menuDown = false

	local createdBackground = false
	local startGame = false




	--[[		MENU 		]]--
	

	local function startGame(event)
		startGame = true
		timer.performWithDelay(250,deleteItAll)
		menuTransitionFunc("startGame")
	end

	local function startOptions()
		removeEventListeners()
		menuTransitionFunc("startOptions")
	end

	local function startHelp()
		menuTransitionFunc("startHelp")
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
				transitionFunc(menuGroup,100,_H*.2,easing.InOutQuad,function()
					storyboard.gotoScene(scene)
				end)
			end)
		end
	end



	sceneView:insert(menuGroup)
	sceneView:toFront()
	menuTransitionFunc()
	
	function deleteItAll()
		if startGame == true then
			print("Yesh")

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

			Runtime:removeEventListener("enterFrame",dostuff)
		end
	end

end 

function scene:enterScene(e)
	
end 

function scene:exitScene(e)
	local sceneView = self.view
	print("Leave scene")
	storyboard.purgeOnSceneChange = true
	display.remove(menuRect)
	display.remove(startButton)
	display.remove(optionsButton)
	display.remove(helpButton)
	display.remove(menuGroup)

	display.remove(startbutton)
	display.remove(optionbutton)
	display.remove(scorebutton)

			menuTransition2 = nil
			menuTransition 	= nil

	display.remove(buttonGroup)
	display.remove(backgroundGroup)

	

end 

function scene:destroyScene(e)
	local sceneView = self.view

end





scene:addEventListener("createScene",scene)
scene:addEventListener("enterScene",scene)
scene:addEventListener("exitScene",scene)
scene:addEventListener("destroyScene",scene)
return scene
