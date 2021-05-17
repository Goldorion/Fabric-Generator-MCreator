<#if data.breedable>
<#include "aiconditions.java.ftl">
this.goalSelector.add(${customBlockIndex+1}, new AnimalMateGoal(this, ${field$speed})<@conditionCode field$condition/>);
</#if>