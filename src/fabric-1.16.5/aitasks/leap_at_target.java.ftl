<#include "aiconditions.java.ftl">
this.goalSelector.add(${customBlockIndex+1}, new PounceAtTargetGoal(this, (float)${field$speed})<@conditionCode field$condition/>);