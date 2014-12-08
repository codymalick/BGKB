-- Globals
UpdateInterval = .5;
UpdateNumber = 0;
KillCount = 0;
DeathCount = 0;
InBG = 1;
KillSounds = {"shinji","ohgod","finnatry","fired","gameover","son"};
DeathSounds = {"ha","hum","ogre"};
KillStreakSounds = {"doublekill2","triplekill","ultrakill","stoopid"};
DeathStreakSounds = {"yo","yo2","yo3"};

-- Functions
function HelloWorld()
	print("KillingBlowDetected Loaded");
	RandSound(KillStreakSounds);
end

function EventHandler(self, event, ...)
	if InBG == 1 then
		if event == "PLAYER_PVP_KILLS_CHANGED" then
			print("Wrecked");
		end
		if event == "COMBAT_LOG_EVENT_UNFILTERED" then
			CheckKillingBlow( ... );
		end
		if event == "PLAYER_DEAD" then
			KillCount = 0;
			DeathCount = DeathCount + 1;
			temp = RandSound(KillSounds);
			temp = "Interface\\AddOns\\BGKB\\sound\\kills\\" .. KillSounds[temp] .. ".mp3";
			PlaySoundFile(temp);
		end
		if event == "PLAYER_PVP_KILLS_CHANGED" then
			temp = RandSound(KillSounds);
			temp = "Interface\\AddOns\\BGKB\\sound\\kills\\" .. KillSounds[temp] .. ".mp3";
			PlaySoundFile(temp);
		end
	end
end

function CheckKillingBlow( ... )
	local ag1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10 = ...;
	
	if arg2 == "PARTY_KILL" and arg5 == UnitName("player") then
		--Used for debugging which arg is which from combat log
		-- print("Timestamp: ", arg1);
		-- print("event: ", arg2);
		-- print("sourceGUID: ", arg4);
		-- print("sourceName: ", arg5);
		-- print("sourceFlags: ", arg7);
		-- print("destGUID: ", arg8);
		-- print("destName: ", arg9);
		-- print("destFlags: ", arg10);
		print(arg5, " has killed ", arg9);
		KillCount = KillCount + 1;
		DeathCount = 0;
		if KillCount == 1 then
			PlaySoundFile("Interface\\AddOns\\BGKB\\sound\\killstreaks\\firstblood.mp3");
		elseif KillCount == 2 then
			PlaySoundFile("Interface\\AddOns\\BGKB\\sound\\killstreaks\\doublekill2.mp3");
		elseif KillCount == 3 then
			PlaySoundFile("Interface\\AddOns\\BGKB\\sound\\killstreaks\\triplekill.mp3");
		elseif KillCount == 4 then
			PlaySoundFile("Interface\\AddOns\\BGKB\\sound\\killstreaks\\ultrakill.mp3");
		else
			temp = RandSound(KillSounds);
			temp = "Interface\\AddOns\\BGKB\\sound\\kills\\" .. KillSounds[temp] .. ".mp3";
			PlaySoundFile(temp);
		end
		
		print("Kill Streak: ", KillCount);	
	end
end

function RandSound(list)
	len = table.getn(list);
	print(len);
	val = math.random(0,len);
	print(val);
	return val;
end

-- function GetSoundFiles()
-- 	current_dir = io.popen"cd":read'*l';
-- 	print(current_dir);
-- 	for file in io.popen([[dir ":\Program Files\"World of Warcraft"\Interface\AddOns\BGKB\sound\death" /b /ad]]) do 
-- 		print(file);
-- 	end
-- end

-- local function BGKB_OnUpdate(self, elapsed)
--   self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed; 	

--   if (self.TimeSinceLastUpdate > UpdateInterval) then
--   	UpdateNumber = UpdateNumber + 1;
--     print("Updating ", UpdateNumber);

--     self.TimeSinceLastUpdate = 0;
--   end
-- end
