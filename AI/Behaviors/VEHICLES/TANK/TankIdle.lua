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
local Behavior = CreateAIBehavior("TankIdle", "VehicleIdle",
{
	Alertness = 0,

	---------------------------------------------
	Constructor = function( self , entity )
		
		AI.SetAdjustPath(entity.id,1);
		
		entity.AI.strategy = 0;
		entity.AI.protect = nil;
		entity.AI.vDefultPos = {};
		CopyVector ( entity.AI.vDefultPos, entity:GetPos() );

		self.parent:Constructor( entity );
	end,

	--------------------------------------------------------------------------
	TANK_PROTECT_ME = function( self, entity, sender )
		if ( AI.GetSpeciesOf(entity.id) == AI.GetSpeciesOf(sender.id) ) then

			entity.AI.protect = sender.id;

			if ( entity.id == sender.id ) then
				if (entity.AI.mindType == 3 ) then
					entity.AI.mindType = 2;
				end
			else
				if (entity.AI.mindType == 2 ) then
					entity.AI.mindType = 3;
				end
			end

		end
	end,
})
