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
Script.ReloadScript("scripts/gamerules/SinglePlayer.lua");

function GameRulesSetStandardFuncs(gamerules)

	if (not gamerules) then
		return;
	end;

-- ///////// Server/Client /////////
	if (not gamerules.Server) then
		gamerules.Server={};
	end;

	if (not gamerules.Client) then
		gamerules.Client={};
	end;

	if(not gamerules.AreUsable) then
		gamerules.AreUsable = SinglePlayer.AreUsable;
	end

-- Functions that unfortunately are called by CryAction (Interactor.cpp:47) and thus can't be 
-- moved into c++ without engine changes

-- ///////// IsUsable /////////
	if (not gamerules.IsUsable) then
		gamerules.IsUsable = function (self, srcId, objId)
			if not objId then return 0 end;

			local obj = System.GetEntity(objId);
			if (obj.IsUsable) then
				if (obj:IsHidden()) then
					return 0;
				end;
				local src = System.GetEntity(srcId);
				if (src and src.actor and (src:IsDead() or (src.actor:GetSpectatorMode()~=0))) then
					return 0;
				end
				return obj:IsUsable(src);
			end

			return 0;
		end
	end

-- ///////// OnNewUsable /////////
	if (not gamerules.OnNewUsable) then
		gamerules.OnNewUsable = function (self, srcId, objId, usableId)
			if not srcId then return end
			if objId and not System.GetEntity(objId) then objId = nil end

			local src = System.GetEntity(srcId)
			if src and src.SetOnUseData then
				src:SetOnUseData(objId or NULL_ENTITY, usableId)
			end

			if srcId ~= g_localActorId then return end

			if self.UsableMessage then
				self.UsableMessage = nil
			end
		end
	end

-- ///////// OnUsableMessage /////////
	if (not gamerules.OnUsableMessage) then
		gamerules.OnUsableMessage = SinglePlayer.OnUsableMessage;
	end

-- ///////// OnLongHover /////////
	if (not gamerules.OnLongHover) then
		gamerules.OnLongHover = function(self, srcId, objId)
		end
	end

	if (not gamerules.ProcessActorDamage) then
		gamerules.ProcessActorDamage = function(self, hit)
			-- Using SinglePlayer ProcessActorDamage
			gamerules.GetDamageAbsorption = SinglePlayer.GetDamageAbsorption;
			local died = SinglePlayer.ProcessActorDamage(self, hit);
			return died;
		end
	end

	if (not gamerules.Createhit) then
		gamerules.CreateHit = SinglePlayer.CreateHit;
	end

	if (not gamerules.CreateExplosion) then
		gamerules.CreateExplosion = SinglePlayer.CreateExplosion;
	end
end
