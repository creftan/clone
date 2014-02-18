local O = {};

hud = require("hud");
O.Core = require("CoreMechanics");
O.Player = require("Player");

O.ScreenMinX = 0;
O.ScreenMaxX = 0;

O.ScreenMinY = 0;
O.ScreenMaxY = 0;

O.Physics = nil;

O.WorldSpeed = 0;

O.StartingGame = false;

-- Se "StartGmae.lua" for explaination about this function
function O:Init(PhysPointer, ScreenMinX, ScreenMaxX, ScreenMinY, ScreenMaxY, WorldSpeed, OverlayTimerSpeed, Gravity, FlappBoost)
	O.Physics = PhysPointer;
	O.ScreenMinX = ScreenMinX;
	O.ScreenMaxX = ScreenMaxX;
	O.ScreenMinY = ScreenMinY;
	O.ScreenMaxY = ScreenMaxY;
	O.WorldSpeed = WorldSpeed;
	O.Core:InitCore(PhysPointer, ScreenMinX, ScreenMaxX, ScreenMinY, ScreenMaxY, WorldSpeed, OverlayTimerSpeed);
	O.Player:Init(PhysPointer, O.Core, ScreenMinX, ScreenMaxX, ScreenMinY, ScreenMaxY, Gravity, FlappBoost );
	O.Core:SetPlayerClassPointer(O.Player);
	O.StartingGame = true;
	


	---- Init Player
end

function O:CreateObsticles()

	--- Obsticle
	local ObstCount = 0;
	local ObstWidth = 52;
	local ObstHeight = 320;
	local ObstSpace = 95 --95 
	local ObstStartPosX = O.ScreenMaxX  + (ObstWidth);
	local ObstStartPosY = O.ScreenMaxY*0.5;
	local ObstSpeed = 85

    local Rand = math.random(-95, 95)
    local Obj1Y = ObstStartPosY - (ObstHeight * 0.5) - (ObstSpace * 0.5) + Rand
    local Obj2Y = ObstStartPosY + (ObstHeight * 0.5) + (ObstSpace * 0.5) + Rand

--INFO!
    --Creating Tile-Objects, Tile'ing is only in X-Axis: O.Core:CreateTileObject(ImagePath1 for dayTile, ImagePath2 för night Tile, PostionX, PositionY, ObjectSpeed, LayerNumber(1 = most backgroundish), If image is a Phys-Object (true - false), if PhysObject is a Circle (true) or Square (false), Type of PhysObject ("static", "dynamic", "kinetic"), This last value is a SizeOffset, makes the collision-Phys Object larger or smaller then the ImageObject, only works on circles for the moment)
    --Creating Time-Objects, This creates the object in intrevals: O.Core:CreateTimeObject(First value now is the time interwall in sec between object creation, the rest has the same parameters as above) Extra: 3 last values is SinYMovement: How High and low it moves, SinYSpeed: self explainible, SinYStart: where to start on a sincurve. The New last value is the point the object gives if pased
  
  	-- Tricket med att få Tiles att funka är att skapa dem väldigt mycket åt höger, dock så är det mer prestanda ju mer åt höger man skapar dem

 	local DayNightValue = O.Core:GetTimeCycle()
 	DayNightValue = DayNightValue*DayNightValue; ---- för att svårighetsgraden ska öka exponentiellt istället för linjärt
 	--print (DayNightValue)
 	O.Core:CreateTimeObject( 20, "art/Ingame/mountain.png", "art/Ingame/mountainNight.png", ObstStartPosX, (O.ScreenMaxY*0.635), (O.WorldSpeed*0.3), 2, false, false, "static", 0, 0, 0, 0, 0)
	O.Core:CreateTimeObject( 15, "art/Ingame/mountain_2.png", "art/Ingame/mountain_2Night.png", ObstStartPosX, (O.ScreenMaxY*0.635), (O.WorldSpeed*0.35), 1, false, false, "static", 0, 0, 0, 0, 0)
	
	local RandomPosXOffset1 = math.random(-45,65) * DayNightValue;
	local RandomPosXOffset2 = math.random(-65,45)* -1 * DayNightValue; --- omkastning pga dålig random funktion

	O.Core:CreateTimeObject( 2, "art/Ingame/longcatbody1.png", "art/Ingame/longcatbody1Night.png", ObstStartPosX , Obj1Y, O.WorldSpeed, 4, true, false, "static", 0, 20*DayNightValue, 1*DayNightValue, 0, 1)
	O.Core:CreateTimeObject( 2, "art/Ingame/longcatbody2.png", "art/Ingame/longcatbody2Night.png", ObstStartPosX , Obj2Y, O.WorldSpeed, 4, true, false, "static", 0, 20*DayNightValue, 1*DayNightValue, 0, 0)
	O.Core:CreateTimeObject( 2, "art/Ingame/longcatarm1.png", "art/Ingame/longcatarm1Night.png", ObstStartPosX-35, Obj1Y+110, O.WorldSpeed, 4, true, false, "static", 0, 20*DayNightValue, 1*DayNightValue, 0, 0)
	O.Core:CreateTimeObject( 2, "art/Ingame/longcatarm2.png", "art/Ingame/longcatarm2Night.png", ObstStartPosX-35, Obj2Y-110, O.WorldSpeed, 4, true, false, "static", 0, 20*DayNightValue, 1*DayNightValue, 0, 0)


	--O.Core:CreateTileObject( "Pipe2.png", "Pipe2.png", ObstStartPosX, Obj2Y, O.WorldSpeed, 2, false, false, "static", 0)


--INFO!


	
	--- Important Function!!!!!
	O.Core:ResetCounters();

end


O.PlayerPoints = 0;
O.PrePlayerPoints = 0;
function O:Update(event)


	--- Player Points--------
	O.PlayerPoints = O.Player:GetPlayerPoints();
	if O.PlayerPoints > O.PrePlayerPoints then
		--print(O.PlayerPoints - O.PrePlayerPoints, 'New Points');
		--print(O.PlayerPoints, 'Total Points');
		hud.getScore(O.PlayerPoints)
		O.PrePlayerPoints = O.PlayerPoints;
	end
	-------------------------

	local PlayerCollide = O.Player:GetPlayerCollisionData()

	if PlayerCollide == true then
		O.Core:PauseGame();
		O.Player:Death();
		hud.gameOverBoxMove();
		
		local high = hud.loadHighscore()
		
		if high < O.PlayerPoints then 
			hud.saveHighscore(O.PlayerPoints)
			high = O.PlayerPoints
		end 

		hud.setScoresGameOver(O.PlayerPoints, high)

		function O.restartGame()
			O.Core:PauseGame();
			O.Core:StopGame()
			O.Player:DestroyPLayer();
			O.Core:DeleteDisplayGroups();
			
			hud.deleteHud(HudGroup);

			O.StartingGame = true;
			Runtime:removeEventListener("tap",O.restartGame)
		end
		timer.performWithDelay(1000,function()
			
			Runtime:addEventListener("tap",O.restartGame)
		end)
	elseif O.StartingGame == true then
		O.StartingGame = false;
		O:StartingUpGame(event);
	else
		O.Core:Update(event);
		O.Player:Update();
		O:CreateObsticles();
	end

end

function O:StartingUpGame(event)
	HudGroup = display.newGroup() -- Displaygroup that always is at top
	local HudGroup = O.Core:GetHudGroup();
	HudGroup.y = _H*.10
	hud.createHud(nil,HudGroup)
	O.Core:StartGame()
	O:StartingUpdate(event)
	timer.performWithDelay( 1, function() 
		O.Player:CreatePlayer(0, 0);
		O.Player:CreatePlayerTapImage();
		O.Player:SetPlayerPoints(0);
		O.PrePlayerPoints = 0;
		--hud.getScore(O.PlayerPoints)

		O.Core:PauseGame();
		O.Core.GameReadyToRun = true;
	 end, 1 )
end

function O:StartingUpdate(event)
	O.Core:Update(event);
	O:CreateObsticles();
	O:GameStartExclusiveContent();
	O.Core:GameRunningUpdate(event)
end

function O:GameStartExclusiveContent()  --- allt Content som ska laddas in under uppstart

	--- Obsticle
	local ObstWidth = 52;
	local ObstStartPosX = O.ScreenMaxX  + (ObstWidth);

	O.Core:CreateTimeObject( 0, "art/Ingame/mountain.png", "art/Ingame/mountainNight.png", O.ScreenMaxX * 0.35, (O.ScreenMaxY*0.635), (O.WorldSpeed*0.3), 2, false, false, "static", 0, 0, 0, 0, 0)

	O.Core:CreateTileObject( "art/Ingame/cloudsFront.png", "art/Ingame/cloudsFrontNight.png", (ObstStartPosX + 300), (O.ScreenMaxY*0)-20, (O.WorldSpeed * 1.05),5, false, false, "static", 0)
	O.Core:CreateTileObject( "art/Ingame/grass.png", "art/Ingame/grassNight.png", (ObstStartPosX + 200), O.ScreenMaxY, (O.WorldSpeed * 1.05), 5, true, false, "static", 0)
	
    O.Core:CreateTileObject( "art/Backdrop/backdropDay.png", "art/Backdrop/backdropNight.png", (ObstStartPosX + 300), (O.ScreenMaxY * 0.4),(O.WorldSpeed*0.3), 1, false, false, "static", 0)
 	O.Core:CreateTileObject( "art/Ingame/bushes.png", "art/Ingame/bushesNight.png", (ObstStartPosX + 300), (O.ScreenMaxY*0.735), (O.WorldSpeed * 0.5),3, false, false, "static", 0)
 	O.Core:CreateTileObject( "art/Ingame/clouds.png", "art/Ingame/cloudsNight.png", (ObstStartPosX + 300), (O.ScreenMaxY*0.02), (O.WorldSpeed * 0.2),2, false, false, "static", 0)



end


return O;