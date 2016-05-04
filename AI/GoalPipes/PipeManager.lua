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
PipeManager = {}



function PipeManager:OnInit()

	Log("PipeManager: Creating goal pipes");

	self:ReloadScripts();
	self:CreateGoalPipes();

	Log("PipeManager: Finished creating goal pipes!");

end



function PipeManager:ReloadScripts()

	Script.ReloadScript("Scripts/AI/GoalPipes/PipeManagerVehicle.lua");
	Script.ReloadScript("Scripts/AI/GoalPipes/PipeManagerHuman.lua");
	Script.ReloadScript("Scripts/AI/GoalPipes/PipeManagerReusable.lua");

end



function PipeManager:CreateGoalPipes()

	-- Shared
	AI.LoadGoalPipes("Scripts/AI/GoalPipes/GoalPipesShared.xml");
	AI.LoadGoalPipes("Scripts/AI/GoalPipes/GoalPipesCoordination.xml");
	
	-- Specific (Lua)
	PipeManager:InitVehicle();
	PipeManager:InitHuman();
	PipeManager:InitReusable();

	-- Specific (Xml)
	AI.LoadGoalPipes("Scripts/AI/GoalPipes/GoalPipesHuman.xml");	
	AI.LoadGoalPipes("Scripts/AI/GoalPipes/GoalPipesHeli.xml");
	AI.LoadGoalPipes("Scripts/AI/GoalPipes/GoalPipesSwordsman.xml");
	AI.LoadGoalPipes("Scripts/AI/GoalPipes/GoalPipesZombie.xml");
	self:CreateAISystemGoalPipes();

end



function PipeManager:CreateAISystemGoalPipes()

	-- TODO: Investigate if we need the following goal pipes! /Jonas
	
	-- goal pipe used as inserted pipe while executing actions. used to temporary suspend previous pipe.
	-- it never ends, but will be forced to end by AI Action system after action execution
	AI.CreateGoalPipe("_action_");
	AI.PushGoal("_action_","timeout",1,0.1);
	AI.PushGoal("_action_","branch",1,-1,BRANCH_ALWAYS);

	-- Goal pipe is used by hit reaction system - suspends any pipework and will be removed by hit reaction system
	-- Note: Should be created in Code by System?
	AI.CreateGoalPipe("_SETINCODE_HIT_REACT_");
	AI.PushGoal("_SETINCODE_HIT_REACT_","timeout",1,0.1);
	AI.PushGoal("_SETINCODE_HIT_REACT_","branch",1,-1,BRANCH_ALWAYS);

	-- need this to let the AISystem know - all the later created pipes are dynamic, need to be saved
	AI.CreateGoalPipe("_last_");

end
