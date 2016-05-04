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
--	Description: SpeedBoat example implementation
--
----------------------------------------------------------------------------------------------------
SpeedBoat =
{
}

SpeedBoat.AIProperties =
{
	AIType = AIOBJECT_BOAT,
	PropertiesInstance =
	{
		aibehavior_behaviour = "BoatIdle",
	},

	Properties =
	{
		aicharacter_character = "Boat",
	},

	AIMovementAbility =
	{
		walkSpeed = 10.0,
		runSpeed = 20.0,
		sprintSpeed = 30.0,
		maneuverSpeed = 5.0,
		minTurnRadius = 0,
		maxTurnRadius = 25,
		passRadius = 9.0,
		-- pathType = "AIPATH_BOAT",
		pathType = "AIPATH_DEFAULT",
		pathLookAhead = 20,
		pathRadius = 5,
		pathSpeedLookAheadPerSpeed = 1.5,
		cornerSlowDown = 0.75,
		pathFindPrediction = 1.0,
		velDecay = 3,
		maneuverTrh = 2.0,
		resolveStickingInTrace = 0,
		pathRegenIntervalDuringTrace = 10.0,
		avoidanceRadius = 10.0,
	},
}