<#include "aiconditions.java.ftl">
this.goalSelector.addGoal(${customBlockIndex+1}, new LookAroundGoal(this)<@conditionCode field$condition/>);