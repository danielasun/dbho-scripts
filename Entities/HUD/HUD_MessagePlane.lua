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
HUD_MessagePlane = {
	type = "HUD_MessagePlane",
	Properties = {
		bEnabled=1,
	},
	Editor={
		Icon = "Prompt.bmp",
		IconOnTop=1,
		Model="Objects/hud/HintTest.cgf",
	},
}

function HUD_MessagePlane:OnInit()
	self:OnReset();
	self:Enable(tonumber(self.Properties.bEnabled)~=0);	
	if (System.IsEditor()) then
		self:LoadObject(0, self.Editor.Model);
	end
end

function HUD_MessagePlane:OnEditorSetGameMode(gameMode)
	if (gameMode) then
		self:DrawSlot(0, 0);
	else
		self:DrawSlot(0, 1);
	end
end

function HUD_MessagePlane:OnPropertyChange()
	self:OnReset();
end

function HUD_MessagePlane:Enable(enable)
	self.enabled=enable;
end

function HUD_MessagePlane:OnReset()
end

function HUD_MessagePlane:OnSave(tbl)
end

function HUD_MessagePlane:OnLoad(tbl)
end
 
function HUD_MessagePlane:OnPostLoad()
end

function HUD_MessagePlane:OnShutDown()
end

function HUD_MessagePlane:IsEnabled()
	return self.enabled;
end

function HUD_MessagePlane:Event_Enable()
		self:Enable(true);
		BroadcastEvent(self, "Enabled");
end

function HUD_MessagePlane:Event_Disable()
		self:Enable(false);
		BroadcastEvent(self, "Disabled");
end

HUD_MessagePlane.FlowEvents =
{
	Inputs =
	{
		Enable = { HUD_MessagePlane.Event_Enable, "bool" },
		Disable = { HUD_MessagePlane.Event_Disable, "bool" },
	},
	Outputs =
	{
		Enabled = "bool",
		Disabled = "bool",
	},
}
