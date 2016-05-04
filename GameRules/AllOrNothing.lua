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
Script.ReloadScript("scripts/gamerules/GameRulesUtils.lua");

AllOrNothing = {};
GameRulesSetStandardFuncs(AllOrNothing);

AllOrNothing.OldCVars = {};
AllOrNothing.OldCVars.AllSeeingRadarSv = nil;

function AllOrNothing:SvStartSuddenDeath()
	Log("*** AllOrNothing:SvStartSuddenDeath()");
	if (not self.OldCVars.AllSeeingRadarSv) then
		self.OldCVars.AllSeeingRadarSv = System.GetCVar("g_mpAllSeeingRadarSv");
		Log("    (remembered)");
	end
	System.SetCVar("g_mpAllSeeingRadarSv", 1);
end

function AllOrNothing:SvEndSuddenDeath()
	Log("*** AllOrNothing:SvEndSuddenDeath()");
	if (self.OldCVars.AllSeeingRadarSv) then
		System.SetCVar("g_mpAllSeeingRadarSv", self.OldCVars.AllSeeingRadarSv);
		self.OldCVars.AllSeeingRadarSv = nil;
		Log("    (reverted)");
	end
end

