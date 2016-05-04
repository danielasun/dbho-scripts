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
MH60_Blackhawk =
{
	Properties =
	{
		bDisableEngine = 0,
		material = "",
		Modification = "",
		soclasses_SmartObjectClass = "",
		esModularBehaviorTree = "",

		Perception =
		{
			FOVPrimary = -1,
			FOVSecondary = -1,
			sightrange = 200,
			stanceScale = 1,
			persistence = 60,
		},
	},

	isWheelRetracted = true,

	Client = {},
	Server = {},
}

MH60_Blackhawk.AIProperties =
{
	AIType = AIOBJECT_HELICOPTERCRYSIS2,
	AICombatClass = SafeTableGet(AICombatClasses, "Heli"),

	PropertiesInstance =
	{
		aibehavior_behaviour = "HeliIdle",
	},

	Properties =
	{
		aicharacter_character = "Heli",
	},

	AIMovementAbility =
	{
		walkSpeed = 15.0,
		runSpeed = 25.0,
		sprintSpeed = 40.0,
		maneuverSpeed = 5.0,
		b3DMove = 1,
		attackZoneHeight = 6,
		pathType = "AIPATH_DEFAULT",
		minTurnRadius = 1,
		maxTurnRadius = 35,
		optimalFlightHeight = 45.0,
		minFlightHeight = 25.0,
		maxFlightHeight = 300.0,
		pathLookAhead = 40,
		pathSpeedLookAheadPerSpeed = 8.0,
		cornerSlowDown = 1,
		pathFindPrediction = 2.0,
		pathRadius = 10,
		velDecay = 60,
		passRadius = 9.0,
		resolveStickingInTrace = 0,
		pathRegenIntervalDuringTrace = 0,
		avoidanceRadius = 20.0,
	},
}