<#include "aiconditions.java.ftl">
this.goalSelector.add(${customBlockIndex+1}, new WanderAroundGoal(this, ${field$speed})<@conditionCode field$condition/>);