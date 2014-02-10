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

	local menuList					= {"START","OPTIONS","HELP"}

	local menuGroup 				= display.newGroup()
	menuGroup.x, menuGroup.y		= _W*.5, -_H
	menuGroup.alpha 				= .5
	
	local menuRect					= display.newRect(menuGroup,0,0,250,350)
	
	for i=1,#menuList do
		buttonGroup					= display.newGroup()
		buttonGroup.y 				= -180

		local buttons				= display.newRect(buttonGroup,0,0,120,60)
		buttons.y 					= buttons.height*i*1.5
		
		local buttonText 			= display.newText(buttonGroup,menuFunc[i].Label,0,0,nil,14)
		buttonText.x, buttonText.y 	= buttons.x, buttons.y

		menuGroup:insert(buttonGroup)

		buttonGroup:addEventListener("tap",menuFunc[i].EventListener)

		function removeEventListeners()
			print("Delete EventListener")
			buttonGroup:removeEventListener("tap",menuFunc[i].EventListener)
		end
	end

	--[[	   EFFECTS 		]]--


	function menuTransitionFunc(scene)
		if not menuDown then
			local menuTransition = transition.to(menuGroup, {time=100,y=_H*.55,transition=easing.InOutQuad,onComplete=function()
					local menuTransition2 = transition.to(menuGroup,{time=100,y=_H*.5})
			end})
			menuDown = true
		else
			local menuTransition = transition.to(menuGroup, {time=100,y=_H*.55,transition=easing.InOutQuad,onComplete=function()
					local menuTransition2 = transition.to(menuGroup,{time=100,y=-_H,onComplete=function()
						storyboard.gotoScene(scene)
					end})
			end})
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


menuTransition2 = nil
menuTransition 	= nil


end 

function scene:destroyScene(e)
end





scene:addEventListener("createScene",scene)
scene:addEventListener("enterScene",scene)
scene:addEventListener("exitScene",scene)
scene:addEventListener("destroyScene",scene)
return scene
