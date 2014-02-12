local hud = {}
local socialModule = require "socialModule"

function hud.forSfx(event)
	print("sfx")
end

function hud.forMusic(event)
	print("music")
end
	
function hud.returntrue()
	return true
end

function hud.forFacebook(event)
	if event.phase == "ended" then
		socialModule.sendfbAppCapture("pic.png","FUCKING AWESOME!\ntest the app here: http://fuckyou.com/")
	end
end

function hud.forTwitter(event)
	if event.phase == "ended" then
		socialModule.sendTweetAppCapture("pic.png","FUCKING AWESOME!\ntest the app here: http://fuckyou.com/")
	end
end

function hud.createHud(event,group)
	socialList = {
				{listener=hud.forFacebook, 	pic="art/face.png"},
				{listener=hud.forTwitter,	pic="art/twit.png"},
	}

	hudList = {
				{listener=hud.forMusic,	pic="art/Buttons/b_note.png"},
				{listener=hud.forSfx,	pic="art/Buttons/b_speaker.png"},
			}

	buttonList = {}
	
	socialButtonList = {}

	for i=1,#hudList do
		hud.hudGroup = display.newGroup()
		hudPic = display.newImage(hud.hudGroup,hudList[i].pic,0,0,50,50)
		hudPic.x = hudPic.width*i*1.1
		hud.hudGroup.xScale, hud.hudGroup.yScale = 3,3
		
		buttonList[#buttonList+1] = hud.hudGroup

		hud.hudGroup:addEventListener("tap",hudList[i].listener)
		hud.hudGroup:addEventListener("touch",hud.returntrue)
		group:insert(hud.hudGroup)

	end

	hud.scoreText = display.newText(hud.hudGroup,"0",0,0,nil,14)
	hud.scoreText.x = 80

	function hud.getScore(score)
		hud.scoreText.text = score
	end

	function hud.gameOverBoxMove()
		hud.gameOverTransition = transition.to(hud.gameOverGroup,{time=80,y=160,transition=easing.InOutQuad,onComplete=function()
			hud.gameOverTransition2 = transition.to(hud.gameOverGroup,{time=80,y=150,transition=easing.InOutQuad})
		end})
	end
	hud.gameOverGroup = display.newGroup()
	hud.hudGroup:insert(hud.gameOverGroup)
	hud.gameOver = display.newImage(hud.gameOverGroup,"art/Ingame/gameoverbox.png",0,0)
	--hud.gameOver.xScale, hud.gameOver.yScale = .7,.7
	hud.gameOver.x, hud.gameOver.y = 53,-80
	--hud.gameOver:addEventListener("tap",hud.returntrue)

	for i=1,#socialList do
		hud.socialGroup = display.newGroup()
		hud.socialPics = display.newImage(hud.socialGroup,socialList[i].pic,0,0)
		hud.socialPics.x = hud.socialPics.width*i*2.1

		hud.socialGroup.x,hud.socialGroup.y = -10,-40
		socialButtonList[#socialButtonList+1] = hud.socialGroup
		hud.gameOverGroup:insert(hud.socialGroup)

		hud.socialGroup:addEventListener("touch",socialList[i].listener)
		hud.socialGroup:addEventListener("tap",hud.returntrue)
	end

	return hud.createHud
end

function hud.printScore(Score)
    hud.scoreText.text = Score
end

function hud.deleteHud(event,group)
	print("Deletes ")

	for i=1,#hudList do
		buttonList[i]:removeEventListener("tap",hudList[i].listener)
		buttonList[i]:removeEventListener("touch",hud.returntrue)
		display.remove(buttonList[i])
		display.remove(group)
	end

	for i=1,#socialList do
		socialButtonList[i]:removeEventListener("tap",hud.returntrue)
		socialButtonList[i]:removeEventListener("touch",socialList[i].listener)
		display.remove(socialButtonList)
		display.remove(socialGroup)
	end
	--hud.gameOver:removeEventListener("tap",hud.returntrue)
	gameOverTransition2 = nil
	gameOverTransition = nil
end	



return hud