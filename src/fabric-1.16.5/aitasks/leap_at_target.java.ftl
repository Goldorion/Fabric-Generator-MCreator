<#include "aiconditions.java.ftl">
this.goalSelector.addGoal(${customBlockIndex+1}, new PounceAtTargetGoal(this, (float)${field$speed})<@conditionCode field$condition/>);