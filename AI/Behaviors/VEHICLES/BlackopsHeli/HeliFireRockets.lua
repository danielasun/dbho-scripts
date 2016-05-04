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
local Behavior = CreateAIBehavior("HeliFireRockets",
{
	Constructor = function (self, entity)
		entity:SelectPrimaryWeapon()
		entity:SelectPipe(0, "do_nothing")
		
		local postures = 
		{
			{
				name = "StandAim",
				type = POSTURE_AIM,
				stance = STANCE_STAND,
				priority = 8.0,
				
				{
					name = "StandAimCenter",
					lean = 0.0,
					priority = 0.0,
				},
			},
			
			{
				name = "CrouchAim",
				type = POSTURE_AIM,
				stance = STANCE_CROUCH,
				priority = 8.0,
				
				{
					name = "CrouchAimCenter",
					lean = 0.0,
					priority = 0.0,
				},
			},
		}

		AI.SetPostures(entity.id, postures)
	end,
})