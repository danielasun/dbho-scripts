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
--
--	Description: Implementation of an abrams tank
--
----------------------------------------------------------------------------------------------------
Abrams =
{
	Sounds = {},

	Properties =
	{
		bDisableEngine = 0,
		Modification = "",
		soclasses_SmartObjectClass = "",
	},

	turretAngles = {},
	difPos = {},

	Client = {},
	Server = {}
}



--------------------------------------------------------------------------
function Abrams:GetSpecificFireProperties()
	if (self.AIFireProperties) then
		self.AIFireProperties[1] = {};
		self.AIFireProperties[1].min_distance = 20;
		self.AIFireProperties[1].max_distance = 400;
	end
end

--------------------------------------------------------------------------
Abrams.AIProperties =
{
	AIType = AIOBJECT_CAR,
	AICombatClass = AICombatClasses.Tank,
	AIDefaultSpecies = 1, -- This is enemy vehicle
	PropertiesInstance =
	{
		aibehavior_behaviour = "TankIdle",
		triggerRadius = 90,
	},

	Properties =
	{
		aicharacter_character = "Tank",
		bHidesPlayer=0,
		Perception =
		{
			FOVPrimary = -1, -- Normal fov
			FOVSecondary = -1, -- Peripheral vision fov
			sightrange = 400,
			persistence = 10,
		},
	},

	AIMovementAbility =
	{
		walkSpeed = 7.0,
		runSpeed = 11.0,
		sprintSpeed = 15.0,
		maneuverSpeed = 5.0,
		minTurnRadius = .2,
		maxTurnRadius = 10,
		pathType = "AIPATH_TANK",
		pathLookAhead = 8,
		pathRadius = 3,
		pathSpeedLookAheadPerSpeed = 1.0,
		cornerSlowDown = 0.75,
		pathFindPrediction = 1.0,
		maneuverTrh = 2.0,
		passRadius = 5.0,
		resolveStickingInTrace = 0,
		pathRegenIntervalDuringTrace = 4.0,
		avoidanceRadius = 10.0,
	},

	-- How fast I forget the target (S-O-M speed)
	forgetTimeTarget = 32.0,
	forgetTimeSeek = 40.0,
	forgetTimeMemory = 40.0,
}