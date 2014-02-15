local aud = {}

local basedir = "Audio/"
local music 
local sounds = {}
local count = 3 
local isplaying
local soundplayed 

function aud.playmusic(track)
if isplaying then 
	--print ("track playing "..isplaying.." track loading "..track)
end 

if isplaying then 
	if isplaying ~= track then -- om ulik låt
		--print ("changing"..track)
		audio.stop(1)
		audio.dispose(isplaying)
		music = audio.loadStream( basedir..track)
		audio.play(music, {channel = 1, loops = -1, fadein = 5000})

	end 
else --om ingen låt
	--print ("starting"..track)
	music = audio.loadStream( basedir..track)
	audio.play(music, {channel = 1, loops = -1, fadein = 5000})
end 
	isplaying = track

end 

function aud.stopmusic(track)
audio.stop(1)
isplaying = nil 
end

function aud.disposemusic()
--audio.dispose (music)
end 

function aud.loadsounds(soundtable)
	if not soundtable then 
		soundtable = {flap = {"flap.wav"}, die = {"die.wav"}, point = {"point.wav"}}
	end 

	for k,v in pairs(soundtable) do
		
		sounds[k] = {}
		for a = 1,#v do 
			sounds[k][a] = audio.loadSound (basedir..v[a])
		end 
	end
	
return sounds

end 

function aud.playMusic(sound)
	local music = audio.loadStream( sound )
	local bgMusic = audio.play( music, { channel=1, loops=-1 } )
	audio.setVolume(.3, {channel = 1})
end

function aud.play(sound, wait)


local function done(e)
	if e.completed then 
		soundplayed = false
	end 
end 

random = math.random(#sound)



count = count + 1; if count > 31 then count = 3;end 
--print ("channel "..count) 


if wait then 
--	print "waiting"
--	print (soundplayed)
	if not soundplayed then 
		soundplayed = true  
		audio.play (sound[random], {channel = count,  onComplete=done})
	end 
else
	audio.play (sound[random], {channel = count})
end 

end 


function aud.setmusicvolume(volume)
	audio.setVolume(volume, {channel = 1})
--	print ("set music volume to "..volume)
end 


function aud.setsoundvolume(volume)
	for i = 3,31 do 
		audio.setVolume(volume, {channel = i})
		
	end 
--	print ("set sound volume to "..volume)
end 



return aud

