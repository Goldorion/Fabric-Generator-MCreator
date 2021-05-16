<#include "aiconditions.java.ftl">
this.goalSelector.addGoal(${customBlockIndex+1}, new SwimAroundGoal(this, ${field$speed}, 40)<@conditionCode field$condition/>);