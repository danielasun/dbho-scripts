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
Script.ReloadScript( "SCRIPTS/Entities/AI/Characters/Human_x.lua")
Script.ReloadScript( "SCRIPTS/Entities/actor/BasicActor.lua")
Script.ReloadScript( "SCRIPTS/Entities/AI/Shared/BasicAI.lua")

MyHuman_x = {
  Properties = {
    bAdditionalBool = true,
  }
}

mergef(MyHuman_x, Human_x, 1)

CreateActor(MyHuman_x)
MyHuman=CreateAI(MyHuman_x)

Script.ReloadScript( "SCRIPTS/AI/Assignments.lua")
InjectAssignmentFunctionality(MyHuman)
AddDefendAreaAssignment(MyHuman)
AddHoldPositionAssignment(MyHuman)
AddCombatMoveAssignment(MyHuman)
AddPsychoCombatAllowedAssignment(MyHuman)

MyHuman:Expose()