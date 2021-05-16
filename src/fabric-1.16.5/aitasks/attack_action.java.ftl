<#include "aiconditions.java.ftl">
this.goalSelector.addGoal(${customBlockIndex+1}, new RevengeGoal(this)<@conditionCode field$condition/>
<#if field$callhelp?lower_case == "true">.setGroupRevenge(this.getClass())</#if>);