<#include "aiconditions.java.ftl">
this.targetSelector.add(${customBlockIndex+1},
        new FollowTargetGoal(this, ${generator.map(field$entity, "entities")}.class, ${field$insight?lower_case},
        ${field$nearby?lower_case})<@conditionCode field$condition/>);