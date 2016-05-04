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
MineField =
{
	type = "MineField",

	Properties =
	{
		TacticalInfo =
		{
			bScannable = 1,
			LookupName = "",
		},
	},

	Editor =
	{
		Icon="mine.bmp",
	},

	Client = {},
	Server = {},
}

MakeUsable( MineField );

function MineField:OnSave(tbl)
	tbl.bUsable=self.bUsable;
end;

function MineField:OnLoad(tbl)
	self:OnReset();
	self.bUsable=tbl.bUsable;
end;

function MineField.Client:OnInit()
	self:OnReset();
end;

function MineField:OnReset()
	self.bUsable = self.Properties.bUsable;
end;

function MineField:OnUsed( user, idx )
end

function MineField:IsUsable(user)
	if(self.bUsable==1)then
		return 2;
	end
		
	return 0;	
end;

function MineField:OnPropertyChange()

end

-- Scanning callbacks

function MineField:HasBeenScanned()
	Game.SendEventToGameObject( self.id, "OnScanned" );
	self:ActivateOutput( "Scanned", true );
end

-- Flownode related

function MineField:Event_SetScanned()
	self:HasBeenScanned();
end;

function MineField:Event_Destroy()
	Game.SendEventToGameObject( self.id, "OnDestroy" );
	self:ActivateOutput( "Destroyed", true );
end;

MineField.FlowEvents =
{
	Inputs =
	{
		SetScanned = { MineField.Event_SetScanned, "bool" },
		SetDestroyed = { MineField.Event_Destroy, "bool" },
	},
	Outputs =
	{
		Scanned = "bool",
		Destroyed = "bool",
	},
}