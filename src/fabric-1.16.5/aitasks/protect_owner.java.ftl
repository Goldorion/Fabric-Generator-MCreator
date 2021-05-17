<#if data.tameable>
<#include "aiconditions.java.ftl">
this.goalSelector.add(${customBlockIndex+1}, new TrackOwnerAttackerGoal(this)<@conditionCode field$condition/>);
</#if>