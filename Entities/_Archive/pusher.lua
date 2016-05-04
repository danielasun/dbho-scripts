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
--created by Kirill	
--
--	this entity has to be attached to a trigger
--	it will add an impulse to a vehicle the player is in when triggering the trigger
--	if player is not in the vehicle - does nothing
--	Impulse is added in negative Y axis direction

Pusher = {
	type = "Pusher",
	Properties = {	
		fImpulse = 10,
		bEnabled = 1,
		bOnce = 0,
		},
	Editor={
		Model="Objects/Editor/T.cgf",
	},
}


function Pusher:OnInit()

	self:OnReset();
	
end

-----------------------------------------------------------------------------
function Pusher:OnReset( )

	self.isEnabled = self.Properties.bEnabled;
	
end



-----------------------------------------------------------------------------
function Pusher:Event_Push( trigger,areaId )

	if( self.isEnabled == 0 ) then return end
local player = trigger.Who;
	if( not player ) then return end
local theVehicle = player.theVehicle;	
	if( not theVehicle ) then return end
	if( not theVehicle.driverT ) then return end	
	if( theVehicle.driverT.entity ~= player ) then return end

	theVehicle:AddImpulseObj( self:GetDirectionVector(), self.Properties.fImpulse);
	
	if(self.Properties.bOnce == 1) then
		self.isEnabled = 0;
	end	
--System.Log("\001  pushing!!! ");
end


-----------------------------------------------------------------------------
function Pusher:OnShutDown()

end



----------------------------------------------------------------------------------------------------------------------------
--
function Pusher:Event_Enable( params )

	self.isEnabled = 1;

end

----------------------------------------------------------------------------------------------------------------------------
--
function Pusher:Event_Disable( params )

	self.isEnabled = 0;

end

Pusher.FlowEvents =
{
	Inputs =
	{
		Disable = { Pusher.Event_Disable, "bool" },
		Enable = { Pusher.Event_Enable, "bool" },
		Push = { Pusher.Event_Push, "bool" },
	},
	Outputs =
	{
		Disable = "bool",
		Enable = "bool",
		Push = "bool",
	},
}
