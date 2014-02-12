local hud = {}



function hud.createHud(event,group)
	
		local function forSfx(event)
			if event.phase == "began" then
				print("sfx")
			elseif event.phase == "ended" then
				--do nothing
			end
		end

		local function forMusic(event)
			if event.phase == "began" then
				print("music")
			elseif event.phase == "ended" then
				--do nothing
			end
		end
	
		local function returntrue()
			return true
		end
	local hudList = {
				{
				listener=forMusic,
				pic="art/Buttons/b_note.png",
				},
				{
				listener=forSfx,
				pic="art/Buttons/b_speaker.png",
				},
			}
	for i=1,2 do
		local hudGroup = display.newGroup()

		hudPic = display.newImage(hudGroup,hudList[i].pic,0,0,50,50)
		hudPic.x = hudPic.width*i*1.1
		hudGroup.xScale, hudGroup.yScale = 3,3

		hudGroup:addEventListener("touch",hudList[i].listener)
		hudGroup:addEventListener("tap",returntrue)
		group:insert(hudGroup)

	end
end


function hud.deleteHud(event)
	display.remove(hudTest)
end

return hud