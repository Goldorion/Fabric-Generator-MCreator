<#include "aiconditions.java.ftl">
this.goalSelector.add(${customBlockIndex+1},
        new FleeEntityGoal(this, ${generator.map(field$entity, "entities")?remove_ending(".ENTITY")}.class, (float)${field$radius}, ${field$nearspeed}, ${field$farspeed})<@conditionCode field$condition/>);