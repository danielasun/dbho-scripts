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
--Script.ReloadScript("Scripts/AI/anchor.lua");

System.Log("Loading AIAlertness.lua");

AIAlertness = {
  type = "AIAlertness",
  Properties = 
  {
  	bEnabled = 1,
  },
	
	Editor={
		Model="Editor/Objects/box.cgf",
	},
}

-------------------------------------------------------
function AIAlertness:OnPropertyChange()
	self:Register();	
end

-------------------------------------------------------
function AIAlertness:OnInit()
	self:Register();
end

-------------------------------------------------------
function AIAlertness:OnReset()
	self.bNowEnabled = self.Properties.bEnabled;
	if (self.Properties.bEnabled == 0) then
		self:TriggerEvent(AIEVENT_DISABLE);
	else
		self:TriggerEvent(AIEVENT_ENABLE);
	end
end

-------------------------------------------------------
function AIAlertness:Register()
	CryAction.RegisterWithAI( self.id, AIOBJECT_GLOBALALERTNESS );	
	self:OnReset();
end

-------------------------------------------------------
function AIAlertness:Event_Enable()
	self:TriggerEvent(AIEVENT_ENABLE);
	self.bNowEnabled = 1;
	BroadcastEvent(self, "Enable");
end

-------------------------------------------------------
function AIAlertness:Event_Disable()
	self:TriggerEvent(AIEVENT_DISABLE);
	self.bNowEnabled = 0;
	BroadcastEvent(self, "Disable");
end

-------------------------------------------------------
function AIAlertness:SetAlertness( level )
	if ( self.bNowEnabled ) then
		if ( level == 0 ) then
			self:Event_Green();
		elseif ( level == 1 ) then
			self:Event_Orange();
		elseif ( level == 2 ) then
			self:Event_Red();
		end
	end
end

-------------------------------------------------------
function AIAlertness:Event_Green( sender )
	AI.LogEvent("GLOBAL ALERTNESS STATE:  GREEN");
	BroadcastEvent(self, "Green");
end

-------------------------------------------------------
function AIAlertness:Event_Orange( sender )
	AI.LogEvent("GLOBAL ALERTNESS STATE:  ORANGE");
	BroadcastEvent(self, "Orange");
end

-------------------------------------------------------
function AIAlertness:Event_Red( sender )
	AI.LogEvent("GLOBAL ALERTNESS STATE:  RED");
	BroadcastEvent(self, "Red");
end

AIAlertness.FlowEvents =
{
	Inputs =
	{
		Disable = { AIAlertness.Event_Disable, "bool" },
		Enable = { AIAlertness.Event_Enable, "bool" },
		Green = { AIAlertness.Event_Green, "bool" },
		Orange = { AIAlertness.Event_Orange, "bool" },
		Red = { AIAlertness.Event_Red, "bool" },
	},
	Outputs =
	{
		Disable = "bool",
		Enable = "bool",
		Green = "bool",
		Orange = "bool",
		Red = "bool",
	},
}		
