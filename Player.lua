local P = {}
P.ScreenMinX = 0;
P.ScreenMaxX = 0;
P.ScreenMinY = 0;
P.ScreenMaxY = 0;

P.Gravity = 0
P.YVelBoost = 0;
P.Density = 1;
P.Friction = 0.3;
P.Bounce = 0;

P.Player = nil;

P.Physics = nil;

P.Core = nil;

P.PlayerObsticleCollide = false;


function P:Init(PhysPointer, CorePointer, ScreenMinX, ScreenMaxX, ScreenMinY, ScreenMaxY, YGravity, FlappBoost )
	P.Physics = PhysPointer;
	P.Core = CorePointer;
	P.ScreenMinX = ScreenMinX;
	P.ScreenMaxX = ScreenMaxX;
	P.ScreenMinY = ScreenMinY;
	P.ScreenMaxY = ScreenMaxY;
	P.YVelBoost = FlappBoost;
	P.Gravity = YGravity;
	P.Physics.setGravity( 0, P.Gravity );
end

function P:CreatePlayer(PosX, PosY)
	local PosX = P.ScreenMaxX*0.25;
	local PosY = P.ScreenMaxY*0.5;
	
	P.Player = display.newGroup()

	P.Player.doge = display.newImageRect(P.Player,"art/Dogesmall.png",30,26);
	P.Player.tail = display.newImageRect(P.Player,"art/doge_tail.png",64,64)

	P.Player.tail.x = -15
	P.Player.tail.y = 6
	
	P.Player.x = PosX;
	P.Player.y = PosY;
	

	P.Player.PreY = PosY;
	local Radius = ((P.Player.width + P.Player.height) * 0.15)
	P.Physics.addBody( P.Player  ,"dynamic", { density = P.Density, friction = P.Friction, bounce = P.Bounce, radius = Radius } );
	P.Player:setLinearVelocity( 0, 0 );

	P.Player.preCollision = GlobalPreCollisionFunction
	P.Player:addEventListener( "preCollision", P.Player )
	P.Core:InsertInDisplayGroup( P.Player, P.Player , 10 );
	--P.Core:InsertInDisplayGroup( P.Player.tail, P.Player.tail , 10 );
	print("Player Created")
end

function P:DestroyPLayer()
	if P.Player ~= nil then
		print("Player Destroyed")
		P.Physics.removeBody( P.Player);
		P.Player:removeEventListener( "preCollision", P.Player )
		P.Player:removeSelf();
		P.Player = nil;
	end
end

function P:Rotate(counter)

	if P.Player ~= nil then
		local DeltaTime = P.Core:GetDeltaTime();
		local Rotate = (P.Player.y - P.Player.PreY) * DeltaTime * 35;

		if Rotate < 0 then
			Rotate = Rotate *2;
		end

		P.Player:rotate(Rotate);
		P.Player.PreY = P.Player.y;
		print (counter.." counter")
		P.Player.tail.rotation = math.sin(counter)*20	


		if P.Player.rotation > 75 then
			P.Player.rotation = 75;
		end
		if P.Player.rotation < -30 then
			P.Player.rotation = -30;
		end

		
	end
end

local counter = 0  

function P:Update()
	local GameRuns = P.Core:GetIfGameIsRunning();
	if GameRuns == true then

		
		counter = counter + .5
		
		if counter > 360 then counter = 0 
		end
		
		P:Rotate(counter);


		

	end
end

function OnTouch( event )
    if event.phase == "began" and P.Player ~= nil and P.Core.GameRunning == true then
      	if P.Player.y > P.Player.height then
         	P.Player:setLinearVelocity( 0, P.YVelBoost * -1 )
     	end
    elseif P.Core.GameReadyToRun == true then
    	P.Core.GameReadyToRun = false;
    	P.Core:StartGame();
    	P.Player:setLinearVelocity( 0, P.YVelBoost * -1 )
    end

end


function P:GetPlayerCollisionData()
	local ObsCol = P.PlayerObsticleCollide;
	P.PlayerObsticleCollide = false;
	return ObsCol;
end


function GlobalPreCollisionFunction(self, event)
	P.PlayerObsticleCollide = true;
end

Runtime:addEventListener( "touch", OnTouch )


return P;