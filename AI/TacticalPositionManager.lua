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
AI.TacticalPositionManager = AI.TacticalPositionManager or {};

Script.ReloadScript("Scripts/AI/TPS/SDKGruntQueries.lua");
Script.ReloadScript("Scripts/AI/TPS/HumanGruntQueries.lua");
Script.ReloadScript("Scripts/AI/TPS/SharedQueries.lua");
Script.ReloadScript("Scripts/AI/TPS/HelicopterQueries.lua");

function AI.TacticalPositionManager:OnInit()
	for i,v in pairs(self) do
		if (type(v) == "table" and v.OnInit) then
			v:OnInit();
			--System.Log("[AI] Initialising TPS queries for "..i);
		end
	end
end
