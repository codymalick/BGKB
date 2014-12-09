-- Globals
UpdateInterval = 5
KillCount = 0
DeathCount = 0
UpdateCount = 0
InBG = 0
KillSounds = {"shinji","ohgod","finnatry","fired","gameover","son"}
DeathSounds = {"ha","hum","ogre"}
KillStreakSounds = {"doublekill2","triplekill","ultrakill","stoopid"}
DeathStreakSounds = {"yo","yo2","yo3"}

-- Functions
function HelloWorld()
	print("KillingBlowDetected Loaded")
	print("running")
end

local function BGCheck()
	local index = 1
	local numBattlefields = GetMaxBattlefieldID()
	local status, mapName, instanceID, lowestLevel, highestLevel, teamSize, registeredMatch
	for i = 1, numBattlefields, 1 do
 		status, mapName, instanceID, lowestLevel, highestLevel, teamSize = GetBattlefieldStatus(i)
		-- print(status, mapName, instanceID, lowestLevel, highestLevel, teamSize, registeredMatch)
		if status == "active" then
			if InBG == 0 then
				print("Entering BG")
			end
			InBG = 1
		else
			if InBG == 1 then
				print("Leaving BG")
			end
			InBG = 0
			KillCount = 0
			DeathCount = 0
		end
	end
	-- InBG = 1
end

function EventHandler(self, event, ...)
	if InBG == 1 then
		if event == "COMBAT_LOG_EVENT_UNFILTERED" then
			CheckKillingBlow( ... )
		end
		if event == "PLAYER_DEAD" then
			KillCount = 0
			DeathCount = DeathCount + 1
			print("Deathstreak: " .. DeathCount)
			if DeathCount == 2 then
				local temp = "Interface\\AddOns\\BGKB\\sound\\death\\" .. DeathStreakSounds[1] .. ".mp3"
				PlaySoundFile(temp)
			elseif DeathCount == 3 then
				local temp = "Interface\\AddOns\\BGKB\\sound\\death\\" .. DeathStreakSounds[2] .. ".mp3"
				PlaySoundFile(temp)
			elseif DeathCount == 4 then
				local temp = "Interface\\AddOns\\BGKB\\sound\\death\\" .. DeathStreakSounds[3] .. ".mp3"
				PlaySoundFile(temp)
			else
				local temp = RandSound(KillSounds)
				temp = "Interface\\AddOns\\BGKB\\sound\\death\\" .. DeathSounds[temp] .. ".mp3"
				PlaySoundFile(temp)
			end
		end
		if event == "PLAYER_PVP_KILLS_CHANGED" then
			UpdateCount = UpdateCount + 1
			if(UpdateCount == 2) then
				local temp = RandSound(KillSounds)
				temp = "Interface\\AddOns\\BGKB\\sound\\kills\\" .. KillSounds[temp] .. ".mp3"
				PlaySoundFile(temp)
				UpdateCount = 0
			end
		end
	end
end

function CheckKillingBlow( ... )
	local ag1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10 = ...
	
	if arg2 == "PARTY_KILL" and arg5 == UnitName("player") then
		--Used for debugging which arg is which from combat log
		-- print("Timestamp: ", arg1)
		-- print("event: ", arg2)
		-- print("sourceGUID: ", arg4)
		-- print("sourceName: ", arg5)
		-- print("sourceFlags: ", arg7)
		-- print("destGUID: ", arg8)
		-- print("destName: ", arg9)
		-- print("destFlags: ", arg10)
		print(arg5, " has killed ", arg9)
		KillCount = KillCount + 1
		DeathCount = 0
		if KillCount == 1 then
			PlaySoundFile("Interface\\AddOns\\BGKB\\sound\\killstreaks\\firstblood.mp3")
		elseif KillCount == 2 then
			PlaySoundFile("Interface\\AddOns\\BGKB\\sound\\killstreaks\\doublekill2.mp3")
		elseif KillCount == 3 then
			PlaySoundFile("Interface\\AddOns\\BGKB\\sound\\killstreaks\\triplekill.mp3")
		elseif KillCount == 4 then
			PlaySoundFile("Interface\\AddOns\\BGKB\\sound\\killstreaks\\ultrakill.mp3")
		else
			temp = RandSound(KillSounds)
			temp = "Interface\\AddOns\\BGKB\\sound\\kills\\" .. KillSounds[temp] .. ".mp3"
			PlaySoundFile(temp)
		end
		
		print("Kill Streak: ", KillCount)	
	end
end

function RandSound(list)
	local len = table.getn(list)
	local val = math.random(0,len)
	return val
end

function BGKB_OnUpdate(self, elapsed)
  self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed
  if self.TimeSinceLastUpdate > UpdateInterval then
  	BGCheck()
    self.TimeSinceLastUpdate = 0
  end
end

-- function GetSoundFiles()
-- 	current_dir = io.popen"cd":read'*l'
-- 	print(current_dir)
-- 	for file in io.popen([[dir ":\Program Files\"World of Warcraft"\Interface\AddOns\BGKB\sound\death" /b /ad]]) do 
-- 		print(file)
-- 	end
-- end

