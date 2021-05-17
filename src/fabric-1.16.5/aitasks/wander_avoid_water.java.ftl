<#include "aiconditions.java.ftl">
this.goalSelector.add(${customBlockIndex+1}, new WanderAroundFarGoal(this, ${field$speed})<@conditionCode field$condition/>);