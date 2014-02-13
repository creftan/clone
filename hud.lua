local hud = {}
local socialModule = require "socialModule"

function hud.makeRandomSentence()
	local list1 = {"SUCH","VERY","SO","MUCH","WOW"}
	local list2 = {"SCORE","BRAVE","PROGRESS","DOGE","GOOD"}
	local i1 = math.random(1,#list1)
	local i2 = math.random(1,#list2)
	local sentence = list1[i1].." "..list2[i2]

	return sentence
end 



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
		
		hudPic = display.newImage(hud.hudGroup,hudList[i].pic,0,0)
		hudPic.x = 20 + hudPic.width*(i-1)*2.5
		hudPic.xScale, hudPic.yScale = 2,2
	
		buttonList[#buttonList+1] = hud.hudGroup

		hud.hudGroup:addEventListener("tap",hudList[i].listener)
		hud.hudGroup:addEventListener("touch",hud.returntrue)
		group:insert(hud.hudGroup)

	end

	hud.scoreText = display.newText(hud.hudGroup,"0",0,0,"origamimommy",35)
	hud.scoreText.x = _W*.5
	hud.scoreText.y = _H*.15
	
	function hud.getScore(score)
		hud.scoreText.text = score
	end



	function hud.gameOverBoxMove()
		hud.gameOverTransition = transition.to(hud.gameOverGroup,{time=80,y=180,transition=easing.InOutQuad,onComplete=function()
			hud.gameOverTransition2 = transition.to(hud.gameOverGroup,{time=80,y=170,transition=easing.InOutQuad})
		end})
	end
	hud.gameOverGroup = display.newGroup()
	
	hud.hudGroup:insert(hud.gameOverGroup)
	
	hud.gameOver = display.newImage(hud.gameOverGroup,"art/Ingame/gameoverbox.png",0,0)

	hud.gameOverGroup.x = _W*.5
	hud.gameOverGroup.y = -_H
	hud.gameOverGroup.xScale, hud.gameOverGroup.yScale = 2.5,2.5
	
	for i=1,#socialList do
		hud.socialGroup = display.newGroup()
		hud.socialPics = display.newImage(hud.socialGroup,socialList[i].pic,0,0)
		hud.socialPics.x = hud.socialPics.width*(i-1)*2.1
		hud.socialGroup.x = -hud.socialGroup.width
		hud.socialGroup.y = hud.gameOver.y + 40
		
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

	gameOverTransition2 = nil
	gameOverTransition = nil
end	

sentence = hud.makeRandomSentence()
print (sentence)

return hud