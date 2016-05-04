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
function AssignPFPropertiesToPathType(...)
	AI.AssignPFPropertiesToPathType(...);
	if (System.IsEditor() and EditorAI) then
		EditorAI.AssignPFPropertiesToPathType(...);
	end
end

-- Default properties for humans
AssignPFPropertiesToPathType(
	"AIPATH_HUMAN",
	NAV_TRIANGULAR + NAV_WAYPOINT_HUMAN + NAV_SMARTOBJECT,
	0.0, 0.0, 0.0, 0.0, 0.0,
	5.0, 0.5, -10000.0, 0.0, 20.0, 3.5,
	0, 0.4, 2, 45, 1, true);

AI.AssignPathTypeToSOUser("Human", "AIPATH_HUMAN");

-- Default properties for car/vehicle agents
AssignPFPropertiesToPathType(
	"AIPATH_CAR",
	NAV_TRIANGULAR + NAV_WAYPOINT_HUMAN + NAV_ROAD, 
	18.0, 18.0, 0.0, 0.0, 0.0, 
	0.0, 1.5, -10000.0, 0.0, 0.0, 7.0,
	0, 0.3, 2.0, 0.0, 5, true);

AssignPFPropertiesToPathType(
	"AIPATH_TANK",
	NAV_TRIANGULAR + NAV_WAYPOINT_HUMAN + NAV_ROAD, 
	18.0, 18.0, 0.0, 0.0, 0.0, 
	0.0, 1.5, -10000.0, 0.0, 0.0, 7.0,
	0, 0.3, 2.0, 0.0, 6, true);

--- character that travels on the surface but has no preferences - except it prefers to walk around
--- hills rather than over them
AssignPFPropertiesToPathType(
	"AIPATH_DEFAULT",
	NAV_TRIANGULAR + NAV_WAYPOINT_HUMAN + NAV_SMARTOBJECT,
	0.0, 0.0, 0.0, 0.0, 0.0, 
	5.0, 0.5, -10000.0, 0.0, 20.0, 3.5,
	0, 0.4, 2, 45, 7, true);
