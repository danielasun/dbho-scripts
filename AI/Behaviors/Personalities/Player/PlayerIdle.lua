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
local Behavior = CreateAIBehavior("PlayerIdle",{
---------------------------------------------
	Constructor = function (self, entity)
		-- called when the behaviour is selected
		-- the extra data is from the signal that caused the behavior transition
		
		AI.ChangeParameter(entity.id, AIPARAM_COMBATCLASS, AICombatClasses.Player);
	end,
	---------------------------------------------
	Destructor = function (self, entity,data)
		-- called when the behaviour is de-selected
		-- the extra data is from the signal that is causing the behavior transition
	end,

	---------------------------------------------
	ACT_ENTERVEHICLE = function( self, entity, sender, data )
		local vehicle = entity.AI.theVehicle;
		if ( entity.AI.theVehicle ) then
			-- fail if already inside a vehicle
			--Log( "Player is already inside a vehicle" );
			return;
		end

		-- get the vehicle
		entity.AI.theVehicle = System.GetEntity( data.id );
		local vehicle = entity.AI.theVehicle;
	 	if ( vehicle == nil ) then
	 		-- no vehicle found
	 		return;
	 	end

		local numSeats = count( vehicle.Seats );

		if ( data.fValue<1 or data.fValue>numSeats ) then
			entity.AI.mySeat = vehicle:RequestClosestSeat( entity.id );
		else
			entity.AI.mySeat = data.fValue;
		end
		
		if ( entity.AI.mySeat==nil ) then
			Log( "Can't find the seat" );
			return;
		end
		
		vehicle:ReserveSeat( entity.id, entity.AI.mySeat );
		
		-- always do fast entering on the player
		vehicle:EnterVehicle( entity.id, entity.AI.mySeat, false );
		if(vehicle:IsDriver(entity.id)) then 
			AI.Signal(SIGNALFILTER_LEADER,1,"OnDriverEntered",entity.id);
		end
	end,	
	---------------------------------------------
	ACT_ANIM = function( self, entity, sender )
	end,
	
	
	-----------------------------------------------------------------
	
})