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
CharacterAttachHelper = {
	Editor={
		Icon="Magnet.bmp",
	},
	Properties =
	{
		BoneName = "Bip01 Head",
	},
}

--------------------------------------------------------------------------
function CharacterAttachHelper:OnInit()
	self:MakeAttachment();
end

--------------------------------------------------------------------------
function CharacterAttachHelper:OnStartGame()
  self:MakeAttachment();
end

--------------------------------------------------------------------------
function CharacterAttachHelper:OnPropertyChange()
	self:MakeAttachment();
end

--------------------------------------------------------------------------
function CharacterAttachHelper:OnBindThis()
	self:MakeAttachment();
end

--------------------------------------------------------------------------
function CharacterAttachHelper:OnUnBindThis()
	self:DestroyAttachment();
end

--------------------------------------------------------------------------
function CharacterAttachHelper:OnShutDown()
	self:DestroyAttachment();
end

--------------------------------------------------------------------------
function CharacterAttachHelper:MakeAttachment()
	local parent = self:GetParent();
	if (parent) then
		parent:DestroyAttachment( 0,self:GetName() );

	  -- Make sure the entity ignores transformation of the parent.
		self:EnableInheritXForm(0);

		-- Attach this entity to the parent.
		parent:CreateBoneAttachment( 0,self.Properties.BoneName,self:GetName() );
		parent:SetAttachmentObject( 0,self:GetName(),self.id,-1,0 );
	end
end

--------------------------------------------------------------------------
function CharacterAttachHelper:DestroyAttachment()
	local parent = self:GetParent();
	if (parent) then
		parent:DestroyAttachment( 0,self:GetName() );
	end
end

--------------------------------------------------------------------------
CharacterAttachHelper.Server = 
{
	OnBindThis = CharacterAttachHelper.OnBindThis,
	OnUnBindThis = CharacterAttachHelper.OnUnBindThis,
};
CharacterAttachHelper.Client = 
{
	OnBindThis = CharacterAttachHelper.OnBindThis,
	OnUnBindThis = CharacterAttachHelper.OnUnBindThis,
};
