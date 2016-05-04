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
--	Description: all vehicles' goalpipes should go here
--
----------------------------------------------------------------------------------------------------
function PipeManager:InitVehicle()

	---------------------------------------------
	AI.BeginGoalPipe("tankclose_wait");
		AI.PushGoal("signal",0,1,"TANKCLOSE_CHECK_SHOOT",SIGNALFILTER_SENDER);
		AI.PushGoal("timeout",1,0.5);
		AI.PushGoal("signal",0,1,"TANKCLOSE_CHECK_SHOOT",SIGNALFILTER_SENDER);
		AI.PushGoal("timeout",1,0.5);
		AI.PushGoal("signal",0,1,"TANKCLOSE_CHECK_SHOOT",SIGNALFILTER_SENDER);
		AI.PushGoal("timeout",1,0.5);
		AI.PushGoal("signal",0,1,"TANKCLOSE_CHECK_SHOOT",SIGNALFILTER_SENDER);
		AI.PushGoal("timeout",1,0.5);
	AI.EndGoalPipe();

	---------------------------------------------
	AI.BeginGoalPipe("tankclose_wait3");
		AI.PushGoal("signal",0,1,"TANKCLOSE_CHECK_SHOOT",SIGNALFILTER_SENDER);
		AI.PushGoal("timeout",1,0.5);
		AI.PushGoal("signal",0,1,"TANKCLOSE_CHECK_SHOOT",SIGNALFILTER_SENDER);
		AI.PushGoal("timeout",1,0.5);
		AI.PushGoal("signal",0,1,"TANKCLOSE_CHECK_SHOOT",SIGNALFILTER_SENDER);
		AI.PushGoal("timeout",1,0.5);
		AI.PushGoal("signal",0,1,"TANKCLOSE_CHECK_SHOOT",SIGNALFILTER_SENDER);
		AI.PushGoal("timeout",1,0.5);
		AI.PushGoal("signal",0,1,"TANKCLOSE_ATTACK_START",SIGNALFILTER_SENDER);
	AI.EndGoalPipe();

	---------------------------------------------
	AI.BeginGoalPipe("tankclose_wait4");
		AI.PushGoal("signal",1,1,"TANKCLOSE_CHECK_SHOOT",SIGNALFILTER_SENDER);
		AI.PushGoal("timeout",1,0.5);
		AI.PushGoal("signal",1,1,"TANKCLOSE_ATTACK_START",SIGNALFILTER_SENDER);
	AI.EndGoalPipe();
	
	---------------------------------------------
	AI.BeginGoalPipe("tankclose_attack_start");
		AI.PushGoal("timeout",1,1.0);
		AI.PushGoal("signal",0,1,"TANKCLOSE_INIT",SIGNALFILTER_SENDER);
	AI.EndGoalPipe();

	---------------------------------------------
	AI.BeginGoalPipe("tankclose_____________error");
		AI.PushGoal("timeout",1,3.0);
		AI.PushGoal("signal",0,1,"TANKCLOSE_INIT", SIGNALFILTER_SENDER);
	AI.EndGoalPipe();

	---------------------------------------------
	AI.BeginGoalPipe("tankclose_speedzero");
			AI.PushGoal("timeout",1,0.5);
			AI.PushGoal("signal",1,1,"TANKCLOSE_ATTACK_START",SIGNALFILTER_SENDER);
	AI.EndGoalPipe();

	---------------------------------------------
	AI.BeginGoalPipe("tankclose_memoryattack");
		AI.PushGoal("timeout",1,1.0);
		AI.PushGoal("firecmd",0,1);
		AI.PushGoal("timeout",1,4.0);
		AI.PushGoal("firecmd",0,0);
		AI.PushGoal("signal",0,1,"TANKCLOSE_MEMORYATTACK_START",SIGNALFILTER_SENDER);
	AI.EndGoalPipe();

	---------------------------------------------
	AI.BeginGoalPipe("tankclose_alert_action");
		AI.PushGoal("timeout",1,1.0);
		AI.PushGoal("signal",1,1,"TANKCLOSE_MEMORYATTACK_START",SIGNALFILTER_SENDER);
	AI.EndGoalPipe();

	---------------------------------------------
	AI.BeginGoalPipe("tank_fire");
		AI.PushGoal("firecmd",0,FIREMODE_FORCED);
	AI.EndGoalPipe();

	---------------------------------------------
	AI.BeginGoalPipe("tank_nofire");
		AI.PushGoal("firecmd",0,0);
	AI.EndGoalPipe();

	---------------------------------------------
	AI.BeginGoalPipe("tank_fire_sec");
		AI.PushGoal("firecmd",0,FIREMODE_SECONDARY);
	AI.EndGoalPipe();

	---------------------------------------------
	AI.BeginGoalPipe("tank_fire_burst");
		AI.PushGoal("firecmd",0,FIREMODE_BURST);
	AI.EndGoalPipe();

	---------------------------------------------

	AI.LogEvent("VEHICLE PIPES LOADED");

end





