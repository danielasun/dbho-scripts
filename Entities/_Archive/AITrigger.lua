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
-- 10/12/04 by Kirill
-- CXP specific entity, to notify AI system of mission events, later this functionality will be 
-- implemented with mission flow system.

AITrigger = {
  type = "AITrigger",
	Properties = {
			modifyerName = "bridge",
			fAlarmRadius = 50,
	},
	
	Editor={
		--Model="Editor/Objects/T.cgf",
		Model="Editor/Objects/box.cgf",
	},
		
}

-------------------------------------------------------
function AITrigger:OnInit()
	self:OnReset();
	
end

-------------------------------------------------------
function AITrigger:OnReset()
	
--	AI:RegisterWithAI(self.id, self.Properties.Action);
--	self:RegisterWithAI(self.Properties.Action);
end

-------------------------------------------------------
-------------------------------------------------------
-- Input events
-------------------------------------------------------

function AITrigger:Event_Event( sender )
	AI.Event(1, self.Properties.modifyerName); 
	BroadcastEvent( self,"Event" );
	AI.Commander:OnBridgeDestroyed();
end

-------------------------------------------------------

function AITrigger:Event_Alarm( sender )
	System.Log( "Alarm!" );
	AI.SoundEvent(self:GetWorldPos(), self.Properties.fAlarmRadius, AISOUND_GENERIC, g_localActor.id);
	BroadcastEvent( self,"Alarm" );
end


-------------------------------------------------------

-------------------------------------------------------
-- Output events
-------------------------------------------------------
--function AIObject:Event_OnTouch(sender)
--	BroadcastEvent( self,"OnTouch" );
--end
-------------------------------------------------------


AITrigger.Events =
{
	Inputs =
	{
		Alarm = { AITrigger.Event_Alarm, "bool" },
		Event = { AITrigger.Event_Event, "bool" },
	},
	Outputs =
	{
		Alarm = "bool",
		Event = "bool",
	},
}