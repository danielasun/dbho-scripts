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
local Behavior = CreateAIBehavior("InVehicleChangeSeat", "InVehicle",
{
	--------------------------------------------------------------------------
	Constructor = function( self, entity, sender, data )
		entity.AI.changeSeatTimer= nil;
	end,

	--------------------------------------------------------------------------
	Destructor = function ( self, entity, sender, data )
		if ( entity.AI.changeSeatTimer~= nil ) then
			entity.AI.changeSeatTimer= nil;
		end
	end,
	
	--------------------------------------------------------------------------
	ACT_DUMMY = function( self, entity, sender, data )
		self:INVEHICLE_CHANGESEAT( entity, sender, data );
	end,

	--------------------------------------------------------------------------
	INVEHICLE_CHANGESEAT = function( self, entity, sender, data )

		AI.CreateGoalPipe("InVehicleChangeSeat");
		AI.PushGoal("InVehicleChangeSeat","waitsignal", 1, "ChangeSeatEnd", nil, 1000.0 );
		entity:InsertSubpipe(AIGOALPIPE_SAMEPRIORITY,"InVehicleChangeSeat",nil,data.iValue);

		entity.AI.changeSeatTimer= 1;
		Script.SetTimerForFunction( 500, "AIBehavior.InVehicleChangeSeat.INVEHICLE_CHANGESEAT_SUB", entity );
		
	end,

	--------------------------------------------------------------------------
	INVEHICLE_CHANGESEAT_SUB = function( entity )

		if ( entity.AI.changeSeatTimer == nil ) then
			return;
		end

		if ( entity.id and System.GetEntity( entity.id ) ) then
		else
			entity.AI.changeSeatTimer =nil;
			return;
		end

		if ( entity:IsActive() and AI.IsEnabled(entity.id) ) then
		else
			entity.AI.changeSeatTimer =nil;
			return;
		end

		local cameraFwdDir = {};
		local vDir = {};

		CopyVector( cameraFwdDir, System.GetViewCameraDir() );
		SubVectors( vDir, entity:GetPos(), System.GetViewCameraPos() );

		NormalizeVector( cameraFwdDir );
		NormalizeVector( vDir );

		if ( dotproduct3d( cameraFwdDir, vDir ) < 0 ) then

			entity.AI.changeSeatTimer= nil;
			if ( entity.AI.theVehicle and entity.AI.theVehicle.vehicle ) then
				entity.AI.theVehicle.vehicle:ChangeSeat( entity.id, 1, false );
				AI.Signal(SIGNALFILTER_SENDER, 1, "ChangeSeatEnd", entity.id);
			else
				entity:CancelSubpipe();
			end

		else

			entity.AI.changeSeatTimer = 1;
			Script.SetTimerForFunction( 500, "AIBehavior.InVehicleChangeSeat.INVEHICLE_CHANGESEAT_SUB", entity );

		end

	end,
})
