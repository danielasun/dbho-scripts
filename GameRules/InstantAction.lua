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

InstantAction= {};

GameRulesSetStandardFuncs(InstantAction);

----------------------------------------------------------------------------------------------------
function InstantAction:EquipActor(actor)
	--Log(">> SinglePlayer:EquipActor(%s) <<", actor:GetName());
	
	if(self.game:IsDemoMode() ~= 0) then -- don't equip actors in demo playback mode, only use existing items
		--Log("Don't Equip : DemoMode");
		return;
	end;

	if (actor.inventory) then
		actor.inventory:Destroy();
	end

	if (actor.actor and not actor.actor:IsPlayer()) then
		if (actor.Properties) then		
			local equipmentPack=actor.Properties.equip_EquipmentPack;
			if (equipmentPack and equipmentPack ~= "") then
				ItemSystem.GiveItemPack(actor.id, equipmentPack, false, false);
				if (actor.AssignPrimaryWeapon) then
					actor:AssignPrimaryWeapon();
				end
			end

	  	if(not actor.bGunReady) then
	  		actor.actor:HolsterItem(true);
	  	end
	  end
	end
end