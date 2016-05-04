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
local Behavior = CreateAIBehavior("InVehicleControlled", "InVehicle",
{	Exclusive = 1,

	Constructor = function( self, entity, sender, data )
		if ( entity.actor:IsPlayer() ) then
			AI.LogEvent("ERROR : InVehicleControlledGunner is used for the player");
		else
			self:INVEHICLE_CONTROL_START( entity );
		end
	end,

	INVEHICLE_CONTROL_START = function( self, entity )
		AI.CreateGoalPipe("Invehicle_controltimer");
		AI.PushGoal("Invehicle_controltimer","timeout",1,random(1,2));
		AI.PushGoal("Invehicle_controltimer","signal",0,1,"INVEHICLE_REQUEST_START_FIRE",SIGNALFILTER_SENDER);
		AI.PushGoal("Invehicle_controltimer","timeout",1,random(6,12));
		AI.PushGoal("Invehicle_controltimer","signal",0,1,"INVEHICLE_REQUEST_STOP_FIRE",SIGNALFILTER_SENDER);
		entity:InsertSubpipe(0,"Invehicle_controltimer");
	end,

	INVEHICLE_REQUEST_START_FIRE = function( self, entity )
		local vehicleId = entity.actor:GetLinkedVehicleId();
		if ( vehicleId ) then
			AI.Signal(SIGNALFILTER_SENDER, 1, "INVEHICLE_REQUEST_START_FIRE", vehicleId);
		end
	end,
	
	INVEHICLE_REQUEST_STOP_FIRE = function( self, entity )

		local vehicleId = entity.actor:GetLinkedVehicleId();
		if ( vehicleId ) then
			AI.Signal(SIGNALFILTER_SENDER, 1, "INVEHICLE_REQUEST_STOP_FIRE", vehicleId);
		end

	end,
})