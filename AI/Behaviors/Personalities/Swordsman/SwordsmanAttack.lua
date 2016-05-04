-- SwordsmanAttack behavior by the_grim
-- Based on FogOfWarAttack by Francesco Roccucci

local Behavior = CreateAIBehavior("SwordsmanAttack",
{
    Alertness = 2,

    Constructor = function (self, entity)
        entity:MakeAlerted();
        entity:DrawWeaponNow();
        Log("=======")
        Log("Attack!")
        Log("=======")
        entity:SelectPipe(0,"swordsman_attack");
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

        Log("Distance in attack:")
        Log(distance);

        if(distance > (range)) then
            AI.SetBehaviorVariable(entity.id, "IsAttackRange", false);
        elseif(distance < (range)) then
            AI.SetBehaviorVariable(entity.id, "IsAttackRange", true);
        end

    end,    
})