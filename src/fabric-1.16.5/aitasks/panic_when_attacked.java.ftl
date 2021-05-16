<#include "aiconditions.java.ftl">
this.goalSelector.addGoal(${customBlockIndex+1},new EscapeDangerGoal(this, ${field$speed})<@conditionCode field$condition/>);