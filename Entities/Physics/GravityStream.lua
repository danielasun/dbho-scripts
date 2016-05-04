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
Script.ReloadEntityScript( "GravityValve" )

GravityStream =
{
	Editor =
	{
		Icon = "GravitySphere.bmp",
		IconOnTop = 1,
	},
}

-------------------------------------------------------
function GravityStream:OnLoad(table)
  self.oldPos = table.oldPos
end

-------------------------------------------------------
function GravityStream:OnSave(table)
  table.oldPos = self.oldPos
end

function GravityStream:GetValve()
	local name = self:GetName()
	--Log("***** "..name)
	local underscorePos, numberPos = string.find( name, "_[pP]", 1 )
	if not underscorePos then
		LogWarning("Incorrectly formatted name - should be GravityValveName_p?; GravityValveName is the name of the associated valve, and ? is an integer indice.")
		return
	end
	local index = tonumber( string.sub( name, numberPos+1 ) )
	if not index then return end
	local entity = System.GetEntityByName( string.sub( name, 1, underscorePos-1 ) )
	return entity, index
end

function GravityStream:OnUpdate()
	local curPos = self:GetPos()
	if not self.oldPos or LengthVector( DifferenceVectors( curPos, self.oldPos ) ) > 0.0001 then
		self.oldPos = curPos
		local valve, index = self:GetValve()
		if valve then valve:OnChange( index ) end
		return
	end
	local name = self:GetName()
	if not self._Name == name then
		self._Name = name;
		local valve, index = self:GetValve()
		if valve then valve:OnChange( index ) end
	end
end

GravityStream.OnSpawn = GravityStream.OnUpdate
GravityStream.OnDestroy = GravityStream.OnUpdate
GravityStream.OnReset = GravityStream.OnUpdate
GravityStream.OnPropertyChange = GravityStream.OnUpdate
