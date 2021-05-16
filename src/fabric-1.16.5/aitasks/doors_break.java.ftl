<#if !data.flyingMob>
<#include "aiconditions.java.ftl">
this.goalSelector.add(${customBlockIndex+1}, new BreakDoorGoal(this, e -> true)<@conditionCode field$condition/>);
</#if>