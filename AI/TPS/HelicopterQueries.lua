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
AI.TacticalPositionManager.Helicopter = AI.TacticalPositionManager.Helicopter or {};

function AI.TacticalPositionManager.Helicopter:OnInit()

	AI.RegisterTacticalPointQuery({
		Name = "HelicopterFindGoodFiringSpot",
		{
			Parameters =
			{
				density = 8.0,
				horizontalSpacing = 4,
			},
			Generation =
			{
				pointsInDesignerPath_around_puppet = 75.0,
			},
			Conditions =
			{
				min_distance2d_to_attentionTarget = 15.0,
				canShootTwoRayTest_to_attentionTarget = true,
			},
			Weights =
			{
				distance_from_puppet = -1.0,
			},
		},
	});

end









