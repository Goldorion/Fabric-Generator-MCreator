<#include "aiconditions.java.ftl">
this.goalSelector.addGoal(${customBlockIndex+1},
        new FleeEntityGoal(this, ${generator.map(field$entity, "entities")}.class, (float)${field$radius}, ${field$nearspeed}, ${field$farspeed})<@conditionCode field$condition/>);