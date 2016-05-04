WalkerIdleBehavior = CreateAIBehavior("WalkerIdle",
{
   Constructor = function(self, entity)
      Log("Wandering...");
      AI.SetBehaviorVariable(entity.id, "AwareOfPlayer", false);
      entity:SelectPipe(0,"walker_idle");
      self:GetNewDestination(entity);
   end,


   Destructor = function(self, entity)
      -- entity:CancelSubpipe();
   end,

   
   GetNewDestination = function(self, entity)
      local pos = entity:GetPos();
      pos.x = pos.x + random(-10, 10);
      pos.y = pos.y + random(-10, 10);
      
      local data = {};
      data.point = pos;
      data.fValue = 0;   -- EndAccuracy
      data.point2 = {};
      data.point2.x = 0; -- StopDistance
      data.iValue = BODYPOS_RELAXED; -- Stance
      
      AIBehavior.DEFAULT:ACT_GOTO(entity, entity, data);
   end,
   
   
   CANCEL_CURRENT = function(self, entity, data)
      entity:CancelSubpipe();
      self:GetNewDestination(entity);
   end,
   

   END_ACT_GOTO = function(self, entity, data)
      entity:CancelSubpipe();
      self:GetNewDestination(entity);
   end,
})
