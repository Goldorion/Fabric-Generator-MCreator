<#include "aiconditions.java.ftl">
this.goalSelector.add(${customBlockIndex+1}, new SwimAroundGoal(this, ${field$speed}, 40)<@conditionCode field$condition/>);