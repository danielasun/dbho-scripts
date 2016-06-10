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

function MyHuman_x:Callback()
    Log("callback")
end

-- function BasicAI.OnDeath( entity )
--     Log("MyHuman_x.OnDeath()")
--     AI.SetSmartObjectState( entity.id, "Dead" );

--     -- notify spawner - so it counts down and updates
--     if(entity.AI.spawnerListenerId) then
--         local spawnerEnt = System.GetEntity(entity.AI.spawnerListenerId);
--         if(spawnerEnt) then
--             spawnerEnt:UnitDown();
--         end
--     end

--     if(entity.AI.theVehicle and entity.AI.theVehicle:IsDriver(entity.id)) then
--             -- disable vehicle's AI
--         if (entity.AI.theVehicle.AIDriver) then
--           entity.AI.theVehicle:AIDriver(0);
--         end
--         entity.AI.theVehicle=nil;
--     end

--     GameAI.UnregisterWithAllModules(entity.id);
--     AI.UnregisterTargetTrack(entity.id);

--     if(entity.Event_Dead) then
--         entity:Event_Dead(entity);
--     end

--     -- free mounted weapon
--     if (entity.AI.current_mounted_weapon) then
--         if (entity.AI.current_mounted_weapon.item:GetOwnerId() == entity.id) then
--             entity.AI.current_mounted_weapon.item:Use( entity.id );--Stop using
--             entity.AI.current_mounted_weapon.reserved = nil;
--             AI.ModifySmartObjectStates(entity.AI.current_mounted_weapon.id,"Idle,-Busy");
--         end
--         entity.AI.current_mounted_weapon.listPotentialUsers = nil;
--         entity.AI.current_mounted_weapon = nil;
--         AI.ModifySmartObjectStates(entity.id,"-Busy");
--     end
--     -- check ammo count modifier
--     if(entity.AI.AmmoCountModifier and entity.AI.AmmoCountModifier>0) then
--         entity:ModifyAmmo();
--     end
-- end


CreateActor(MyHuman_x)
MyHuman=CreateAI(MyHuman_x)

Script.ReloadScript( "SCRIPTS/AI/Assignments.lua")
InjectAssignmentFunctionality(MyHuman)
AddDefendAreaAssignment(MyHuman)
AddHoldPositionAssignment(MyHuman)
AddCombatMoveAssignment(MyHuman)
AddPsychoCombatAllowedAssignment(MyHuman)

MyHuman:Expose()