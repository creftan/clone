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

	O:StartingUpGame();
	


	---- Init Player
end

function O:CreateObsticles()

	--- Obsticle
	local ObstCount = 0;
	local ObstWidth = 52;
	local ObstHeight = 320;
	local ObstSpace = 107 --115;
	local ObstStartPosX = O.ScreenMaxX  + (ObstWidth);
	local ObstStartPosY = O.ScreenMaxY*0.5;
	local ObstSpeed = 85



    local Rand = math.random(-95, 95)
    local Obj1Y = ObstStartPosY - (ObstHeight * 0.5) - (ObstSpace * 0.5) + Rand
    local Obj2Y = ObstStartPosY + (ObstHeight * 0.5) + (ObstSpace * 0.5) + Rand

--INFO!
    --Creating Tile-Objects, Tile'ing is only in X-Axis: O.Core:CreateTileObject(ImagePath1 for dayTile, ImagePath2 för night Tile, PostionX, PositionY, ObjectSpeed, LayerNumber(1 = most backgroundish), If image is a Phys-Object (true - false), if PhysObject is a Circle (true) or Square (false), Type of PhysObject ("static", "dynamic", "kinetic"), This last value is a SizeOffset, makes the collision-Phys Object larger or smaller then the ImageObject, only works on circles for the moment)
    --Creating Time-Objects, This creates the object in intrevals: O.Core:CreateTimeObject(First value now is the time interwall in sec between object creation, the rest has the same parameters as above) Extra: 3 last values is SinYMovement: How High and low it moves, SinYSpeed: self explainible, SinYStart: where to start on a sincurve.
  
  	-- Tricket med att få Tiles att funka är att skapa dem väldigt mycket åt höger, dock så är det mer prestanda ju mer åt höger man skapar dem
    O.Core:CreateTileObject( "art/backdrop/backdrop.png", "art/backdrop/backdrop.png", 0, (O.ScreenMaxY * 0.4), 0, 1, false, false, "static", 0)
 	O.Core:CreateTileObject( "art/ingame/bushes.png", "art/ingame/bushes.png", (ObstStartPosX + 300), (O.ScreenMaxY*0.735), (O.WorldSpeed * 0.5),3, false, false, "static", 0)
 	O.Core:CreateTileObject( "art/ingame/clouds.png", "art/ingame/clouds.png", (ObstStartPosX + 300), (O.ScreenMaxY*0), (O.WorldSpeed * 0.2),2, false, false, "static", 0)

 	local randomlist = {}

 	O.Core:CreateTimeObject( 20, "art/ingame/mountain.png", "art/ingame/mountain.png", ObstStartPosX, (O.ScreenMaxY*0.635), (O.WorldSpeed*0.3), 2, false, false, "static", 0, 0, 0, 0)
	O.Core:CreateTimeObject( 15, "art/ingame/mountain_2.png", "art/ingame/mountain_2.png", ObstStartPosX, (O.ScreenMaxY*0.635), (O.WorldSpeed*0.3), 1, false, false, "static", 0, 0, 0, 0)
	
	O.Core:CreateTimeObject( 2, "art/ingame/longcatbody1.png", "art/ingame/longcatbody1.png", ObstStartPosX, Obj1Y, O.WorldSpeed, 4, true, false, "static", 0, 10, 1, 0)
	O.Core:CreateTimeObject( 2, "art/ingame/longcatbody2.png", "art/ingame/longcatbody2.png", ObstStartPosX, Obj2Y, O.WorldSpeed, 4, true, false, "static", 0, 10, 1, 0)
	O.Core:CreateTimeObject( 2, "art/ingame/longcatarm1.png", "art/ingame/longcatarm1.png", ObstStartPosX-35, Obj1Y+110, O.WorldSpeed, 4, true, false, "static", 0, 10, 1, 0)
	O.Core:CreateTimeObject( 2, "art/ingame/longcatarm2.png", "art/ingame/longcatarm2.png", ObstStartPosX-35, Obj2Y-110, O.WorldSpeed, 4, true, false, "static", 0, 10, 1, 0)



	O.Core:CreateTileObject( "art/ingame/grass.png", "art/ingame/grass.png", (ObstStartPosX + 300), O.ScreenMaxY, (O.WorldSpeed * 1.05), 5, true, false, "static", 0)
	

	--O.Core:CreateTileObject( "Pipe2.png", "Pipe2.png", ObstStartPosX, Obj2Y, O.WorldSpeed, 2, false, false, "static", 0)


--INFO!


	
	--- Important Function!!!!!
	O.Core:ResetCounters();

end


function O:Update(event)

	local PlayerCollide = O.Player:GetPlayerCollisionData()
	if PlayerCollide == true then
		O.Core:PauseGame();
		hud.gameOverBoxMove();
		function O.restartGame()
			O.Core:StopGame()
			O.Player:DestroyPLayer();
			O.Core:DeleteDisplayGroups();
			
			hud.deleteHud(HudGroup);

			O:StartingUpGame();
			Runtime:removeEventListener("tap",O.restartGame)
		end
		timer.performWithDelay(1000,function()
			Runtime:addEventListener("tap",O.restartGame)
		end)
		
	else
		O.Core:Update(event);
		O.Player:Update();
		O:CreateObsticles();
	end

end

function O:StartingUpGame()
	HudGroup = display.newGroup() -- Displaygroup that always is at top
	local HudGroup = O.Core:GetHudGroup();
	HudGroup.x = _W*.16
	HudGroup.y = _H*.14
	hud.createHud(nil,HudGroup)
	O.Core:StartGame()
	O:CreateObsticles();
	timer.performWithDelay( 1, function() 
		O.Player:CreatePlayer(0, 0);
		O.Core:PauseGame();
		O.Core.GameReadyToRun = true;
	 end, 1 )
end



return O;