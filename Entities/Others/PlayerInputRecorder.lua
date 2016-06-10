PlayerInputRecorder = 
{
  Properties = {

  },
  
  Editor = {
    Icon = "bug.bmp",
  },
  
  time_elapsed = 0.0,
  entity_name_list = {},  
  event_list = {},
  
  tallies = {
    jumps = 0,
  },
  
  player_pos = {},
  
  xml_def_path = "Scripts/Entities/Others/PlayerInputRecorder_def.xml",
  xml_data_path = "Scripts/Entities/Others/PlayerInputRecorder_data.xml",
}

function PlayerInputRecorder:OnInit()
  self:Activate(1);
  
end

function PlayerInputRecorder:OnUpdate(dt)
  if (not System.IsEditing()) then
    self.time_elapsed = self.time_elapsed + dt;
  end
end

function PlayerInputRecorder:OnReset(bGameStart)
  self.time_elapsed = 0.0
  
  -- Save to XML
  if (not bGameStart) then
    CryAction.SaveXML(self.xml_def_path, self.xml_data_path, self)
  end
  
  -- -- Spawn an entity
  -- for i=1,2 do
  --   local params = {id,
  --                   class="Human",
  --                   name="grunts.Human-red"..i,
  --                   position={x=494,y=543,z=32},
  --                   orientation={1,0,0},
  --                   scale={1,1,1},
  --                   flags=0,
  --                   archetype="humans.grunts.Human-red",
  --   }

  --   self.entity_name_list[#self.entity_name_list+1] = params[name] 
  --   System.SpawnEntity(params)
  -- end

  -- Count entities on a team
  local humantable = System.GetEntitiesByClass("Human")

  


  Log("humantable = " .. #humantable)

  -- Reset events and tallies
  self.event_list = {}
  self.player_pos = {}
  self.tallies.jumps = 0
end

function PlayerInputRecorder:OnKeyPress()
  local humantable = System.GetEntitiesByClass("Human")
  Log("There are " .. #humantable .. " entities of type Human.")

  local ct = 0
  for k,v in pairs(humantable) do
    -- if (ct < 2) then
      Log("Removing " .. tostring(v.id) .. "  " .. tostring(v.name))
      -- v.DeleteThis()
      System.RemoveEntity(v.id)
    -- end
    -- ct = ct + 1
  end
end
----------------------
-- FlowEvents
----------------------

function PlayerInputRecorder:On_Event(sender, params)
  self.event_list[#self.event_list+1] = { t = self.time_elapsed, event = params };
  
  if params == "Jump" then
    self.tallies.jumps = self.tallies.jumps + 1
  end
   CryAction.SaveXML(self.xml_def_path, self.xml_data_path, self)
end

function PlayerInputRecorder:On_Position(sender, params)
  self.player_pos[#self.player_pos+1] = { t = self.time_elapsed, pos = params };
  CryAction.SaveXML(self.xml_def_path, self.xml_data_path, self)
  Log("$7printing")
  -- Log(tostring())
  -- Log("x pos" .. params.x)
  -- Log("y pos" .. params.y)
  -- Log("z pos" .. params.z)
end




PlayerInputRecorder.FlowEvents = {
  Inputs = {
    Event = { PlayerInputRecorder.On_Event, "string" },
    Position = { PlayerInputRecorder.On_Position, "Vec3" },
  },
  Outputs = {},
}
