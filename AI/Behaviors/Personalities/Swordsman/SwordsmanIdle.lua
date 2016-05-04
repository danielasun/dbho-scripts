-- SwordsmanIdle behavior
-- Created by the_grim

local Behavior = CreateAIBehavior("SwordsmanIdle",
{
    Alertness = 0,

    Constructor = function (self, entity)
        Log("Idling...");
        AI.SetBehaviorVariable(entity.id, "AwareOfPlayer", false);
        entity:SelectPipe(0,"swordsman_idle");
        entity:DrawWeaponNow();
        self:GetNewDestination(entity);
    end,    

    Destructor = function(self, entity)
    end,

    OnGroupMemberDiedNearest = function ( self, entity, sender,data)
        AI.SetBehaviorVariable(entity.id, "Alerted", true);
        end,
    OnGroupMemberDied = function( self, entity, sender)
        AI.SetBehaviorVariable(entity.id, "Alerted", true);        
    end,

    AnalyzeSituation = function (self, entity, sender, data)
        local range = 2.5;
        local distance = AI.GetAttentionTargetDistance(entity.id);
        if(distance > (range)) then
            AI.SetBehaviorVariable(entity.id, "IsAttackRange", false);
        elseif(distance < (range)) then
            AI.SetBehaviorVariable(entity.id, "IsAttackRange", true);
        end

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