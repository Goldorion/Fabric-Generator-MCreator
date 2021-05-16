<#include "aiconditions.java.ftl">
this.goalSelector.add(${customBlockIndex+1},new EscapeDangerGoal(this, ${field$speed})<@conditionCode field$condition/>);