<#include "aiconditions.java.ftl">
this.goalSelector.addGoal(${customBlockIndex+1}, new AvoidSunlightGoal(this)<@conditionCode field$condition/>);