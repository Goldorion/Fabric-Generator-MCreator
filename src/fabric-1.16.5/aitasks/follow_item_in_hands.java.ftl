<#include "mcitems.ftl">
<#include "aiconditions.java.ftl">
this.goalSelector.add(${customBlockIndex+1}, new TemptGoal(this, ${field$speed}, Ingredient.ofStacks(${mappedMCItemToItem(input$item)}), ${field$scared?lower_case})<@conditionCode field$condition/>);