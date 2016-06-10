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

Medic_x = {
  Properties = {
    bAdditionalBool = false,
  }
}

mergef(Medic_x,Human_x,1)

-- function Medic_x:OnEnemySeen()
--     Log("Medic OnEnemySeen!")
--     AIBase.OnEnemySeen(self);

--     local attentionTarget = AI.GetAttentionTargetEntity(self.id);

--     if (attentionTarget.Properties.esFaction == "Players" and attentionTarget.actor:GetHealth() < 800) then
--         AI.Signal(SIGNALFILTER_SENDER, 1, "OnInjuredPlayerSeen", self.id);
--     end
-- end

function Medic_x:HealPlayer()
    local attentionTarget = AI.GetAttentionTargetEntity(self.id);
    attentionTarget.actor:SetHealth(1000);  
end

function Medic_x:IdlingSignalFromMedic()
    Log("IdlingSignalFromMedic")
end

-- function Medic_x:OnCloseContact()
--     Log("Medic's CloseContact")

--     self:LogPosition()

-- end

function Medic_x:LogPosition()
    Log("Medic LogPosition!")

    local pos = self:GetPos()
    Log("Position is:")
    Log(pos.x)
    Log(pos.y)

    local data = CryAction.LoadXML("Scripts/Data/MedicDeathPosDefinition.xml", "Scripts/Data/MedicDeathPos.xml");

    -- get array length
    local endpos = data.t.tablelen + 1
    data.t.tablelen = endpos

    data.t.pos[endpos] = {x=pos.x,y=pos.y}
    if endpos <= data.t.maxsize then
        CryAction.SaveXML("Scripts/Data/MedicDeathPosDefinition.xml", "Scripts/Data/MedicDeathPos.xml",data);
        Log("Saved Position!")
    else
        Log("PosTable is full!")
    end
end

-- function Medic_x:OnSpawn()
--     Log("Medic_x:OnSpawn()")
-- end

-- function Medic_x:DumpEntities()
--    local ents=System.GetEntities();
--    System.Log("Entities dump");
--    for idx,e in pairs(ents) do
--       local pos=e:GetPos();
--       local ang=e:GetAngles();
--       System.Log("["..tostring(e.id).."]..name="..e:GetName().." clsid="..e.class..format(" pos=%.03f,%.03f,%.03f",pos.x,pos.y,pos.z)..format(" ang=%.03f,%.03f,%.03f",ang.x,ang.y,ang.z));
--    end
-- end

function BasicAI.OnDeath(entity)
    Log("Medic_x OnDeath")
    Log("entity.id,entity type = " .. tostring(entity.id) .. "," )

    entity:LogPosition()
    AI.SetSmartObjectState( entity.id, "Dead" );
    
    if Entity.GetArchetype(entity) == "humans.grunts.Medic-blue" then
        local aliveCount = GameToken.GetToken("GameStates.BlueNumAlive") - 1
        GameToken.SetToken("GameStates.BlueNumAlive",aliveCount)
        Log("BlueTeam = " .. GameToken.GetToken("GameStates.BlueNumAlive"))
    end

    if Entity.GetArchetype(entity) == "humans.grunts.Human-red" then
        local aliveCount = GameToken.GetToken("GameStates.RedNumAlive") - 1
        GameToken.SetToken("GameStates.RedNumAlive",aliveCount)
        Log("RedTeam = " .. GameToken.GetToken("GameStates.RedNumAlive"))
    end


    -- notify spawner - so it counts down and updates
    if(entity.AI.spawnerListenerId) then
        local spawnerEnt = System.GetEntity(entity.AI.spawnerListenerId);
        if(spawnerEnt) then
            spawnerEnt:UnitDown();
        end
    end

    if(entity.AI.theVehicle and entity.AI.theVehicle:IsDriver(entity.id)) then
            -- disable vehicle's AI
        if (entity.AI.theVehicle.AIDriver) then
          entity.AI.theVehicle:AIDriver(0);
        end
        entity.AI.theVehicle=nil;
    end

    GameAI.UnregisterWithAllModules(entity.id);
    AI.UnregisterTargetTrack(entity.id);

    if(entity.Event_Dead) then
        entity:Event_Dead(entity);
    end

    -- free mounted weapon
    if (entity.AI.current_mounted_weapon) then
        if (entity.AI.current_mounted_weapon.item:GetOwnerId() == entity.id) then
            entity.AI.current_mounted_weapon.item:Use( entity.id );--Stop using
            entity.AI.current_mounted_weapon.reserved = nil;
            AI.ModifySmartObjectStates(entity.AI.current_mounted_weapon.id,"Idle,-Busy");
        end
        entity.AI.current_mounted_weapon.listPotentialUsers = nil;
        entity.AI.current_mounted_weapon = nil;
        AI.ModifySmartObjectStates(entity.id,"-Busy");
    end
    -- check ammo count modifier
    if(entity.AI.AmmoCountModifier and entity.AI.AmmoCountModifier>0) then
        entity:ModifyAmmo();
    end

end


CreateActor(Medic_x)
Medic=CreateAI(Medic_x)

Script.ReloadScript( "SCRIPTS/AI/Assignments.lua")
InjectAssignmentFunctionality(Medic)
AddDefendAreaAssignment(Medic)
AddHoldPositionAssignment(Medic)
AddCombatMoveAssignment(Medic)
AddPsychoCombatAllowedAssignment(Medic)

Medic:Expose()