local hud = {}


function hud.forSfx(event)
	print("sfx")
end

function hud.forMusic(event)
	print("music")
end
	
function hud.returntrue()
	return true
end

function hud.createHud(event,group)

	hudList = {
				{
				listener=hud.forMusic,
				pic="art/Buttons/b_note.png",
				},
				{
				listener=hud.forSfx,
				pic="art/Buttons/b_speaker.png",
				},
			}

	buttonList = {}
	
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

	function hud.gameOverBoxMove()
		hud.gameOverTransition = transition.to(hud.gameOver,{time=100,y=60,transition=easing.InOutQuad,onComplete=function()
			hud.gameOverTransition2 = transition.to(hud.gameOver,{time=100,y=50,transition=easing.InOutQuad})
		end})
	end

	hud.gameOver = display.newImage(hud.hudGroup,"/art/Ingame/gameoverbox.png",0,0)
	hud.gameOver.xScale, hud.gameOver.yScale = .7,.7
	hud.gameOver.x, hud.gameOver.y = 50,-50
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
	gameOverTransition2 = nil
	gameOverTransition = nil
end	



return hud