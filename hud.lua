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
	return hud.createHud
end

function hud.deleteHud(event,group)
	print("Deletes ")

	for i=1,#hudList do
		buttonList[i]:removeEventListener("tap",hudList[i].listener)
		buttonList[i]:removeEventListener("touch",hud.returntrue)
		display.remove(buttonList[i])
		display.remove(group)
	end


end	




return hud