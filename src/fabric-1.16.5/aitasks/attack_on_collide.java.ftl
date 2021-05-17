<#include "aiconditions.java.ftl">
this.goalSelector.add(${customBlockIndex+1}, new MeleeAttackGoal(this, ${field$speed}, ${field$longmemory?lower_case})<@conditionCode field$condition/>);