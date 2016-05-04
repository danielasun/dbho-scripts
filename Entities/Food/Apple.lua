Apple =
{
  Properties = {
    soclasses_SmartObjectClass = "AppleExample/Food",
    object_Model = "objects/default/primitive_sphere_small.cgf",
    material_Material = "materials/custom/apple.mtl",
    
    fDefaultFreshness = 100.0,
    fDecayRate = 10, -- decrease freshness per second
    
    fValue = 100.0,
    
    bRotten = false,
    fHealthRestore = 200,
  },
  
  -- instance variables
  freshness = 100.0,
  
  States = {"Edible", "Rotten"},
  
  Editor = {
    Icon = "Item.bmp",
  }
}

-- Called when level is loaded
function Apple:OnInit()
  self:OnReset(false);
  
  self:Activate(1);
end

-- Called when entity is reset
function Apple:OnReset(bGameStart)
  self.freshness = self.Properties.fDefaultFreshness;

  -- reload model
  if (not EmptyString(self.Properties.object_Model)) then
    self:LoadObject(0, self.Properties.object_Model);
  end
  -- reload materials
  if (not EmptyString(self.Properties.material_Material)) then
    self:SetMaterial(self.Properties.material_Material);
    self:CloneMaterial(0)
    self:SetMaterialVec3(0, 1, "diffuse", {x = 1, y = 0, z = 0});
  end
  self:DrawSlot(0, 1);
  
  if (not System.IsEditing()) then
    self:GotoState("Edible");
  end
end

-- Called when property is updated
function Apple:OnPropertyChange()
  self:OnReset(false);
end

-- Called every fame. To enable callback, call: self:Activate(1)
function Apple:OnUpdate(dt)

end

--------------------------------------------------
-- States
--------------------------------------------------

Apple.Edible = {
  OnBeginState = function(self)
    self.Properties.bRotten = false;
  end,
  
  OnUpdate = function(self, dt)
    self.freshness = self.freshness - self.Properties.fDecayRate * dt;
    
    local newColor = {};
    newColor.x = self.freshness / self.Properties.fDefaultFreshness / 2;
    newColor.y = 0;
    newColor.z = 0;
    self:SetMaterialVec3(0, 1, "diffuse", newColor);
    
    if (self.freshness <= 0) then
      self.freshness = 0;
      self:GotoState("Rotten");
    end
  end,
  
  OnEndState = function(self)
  Log("====I'm ROTTEN!!===")
  end,
}

Apple.Rotten = {
  OnBeginState = function(self)
    self.Properties.bRotten = true;
    self:SetMaterialVec3(0, 1, "diffuse", {x = 0, y = 0.05, z = 0});
  end,
}

--------------------------------------------------
-- FlowEvents
--------------------------------------------------

function Apple:Event_Destroy()
  System.RemoveEntity(self.id);
end

Apple.FlowEvents = {
  Inputs =
  {
    Destroy = { Apple.Event_Destroy, "any" },
  },
  Outputs =
  {
  },
}