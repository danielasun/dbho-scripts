-- SwordsmanSeek behavior
-- Created by the_grim

local Behavior = CreateAIBehavior("SwordsmanSeek",
{
    Alertness = 2,

    Constructor = function (self, entity)
        Log("Seeking!");
        entity:SelectPipe(0, "swordsman_seek");    
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
})