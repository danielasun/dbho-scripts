----------------------------------------------------------------------------------------------------
--
-- All or portions of this file Copyright (c) Amazon.com, Inc. or its affiliates or
-- its licensors.
--
-- For complete copyright and license terms please see the LICENSE at the root of this
-- distribution (the "License"). All use of this software is governed by the License,
-- or, if provided, by the license below or the license accompanying this file. Do not
-- remove or modify any license notices. This file is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--
-- Original file Copyright Crytek GMBH or its affiliates, used under license.
--
----------------------------------------------------------------------------------------------------
GameEvent =
{
    Properties = { 
			nId = 0,
			nAllowedDeaths = 3,
			sUniqueName = "",
			bRespawnAtTagpoint=0,
		},

    Editor = { Model="Objects/Editor/Anchor.cgf", },
}


function GameEvent:OnInit()
	--self.soundobj = Sound.LoadSound("sounds/waypoint/waypoint1.wav");
end

function GameEvent:OnShutDown()
end

function GameEvent:Event_Save(sender)
	--printf("CHECKPOINT REACHED: "..self.Properties.nId);
	--if sender~=nil then
	    --System.RemoveEntity(sender.id);
	--end

	self:EnableSave(nil);

--	if (_localplayer) then
--    	_localplayer:PlaySound(self.soundobj);
--	end

    --Hud:AddMessage("Checkpoint "..self.Properties.nId.." reached");
	System.Log("Checkpoint "..self.Properties.nId.." reached");
	--Hud:AddMessage("@Checkpointreached");

	self.bSaveNow = nil;
	
	self:SetTimer(100);
end

function GameEvent:OnTimer()


	if (_localplayer.timetodie) then return end

	if (self.bSaveNow) then	
		
		self.bSaveNow = nil;
		-- if in the vehicle - can't save at respawnPoint pos/angles  
		if (self.Properties.bRespawnAtTagpoint==1 and _localplayer.theVehicle==nil ) then
			_LastCheckPPos = new (self:GetPos());
			_LastCheckPAngles = new(self:GetAngles());
		else
			_LastCheckPPos = new (_localplayer:GetPos());
			_LastCheckPAngles = new(_localplayer:GetAngles(1));
		end

		self:KillTimer();

		AI:Checkpoint();
	
		if (self.Properties.sUniqueName ~= "") then 
			if (ALLOWED_DEATHS) then 
				if (ALLOWED_DEATHS[self.Properties.sUniqueName]) then
					AI:SetAllowedDeathCount(ALLOWED_DEATHS[self.Properties.sUniqueName].deaths);
				end
			end
		else
			AI:SetAllowedDeathCount(self.Properties.nAllowedDeaths);
		end

		Game:TouchCheckPoint(self.Properties.nId, _LastCheckPPos, _LastCheckPAngles);

		if (Game.OnAfterSave) then
			Game:OnAfterSave();
		end
	else
		if (Game.OnBeforeSave) then
			Game:OnBeforeSave();
		end

		self.bSaveNow = 1;
		self:SetTimer(1);
	end
end

GameEvent.FlowEvents =
{
	Inputs =
	{
		Save = { GameEvent.Event_Save, "bool" },
	},
	Outputs =
	{
		Save = "bool",
	},
}
