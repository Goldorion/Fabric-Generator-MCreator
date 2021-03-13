<#include "mcitems.ftl">
if(${input$entity} instanceof PlayerEntity)
	((PlayerEntity)${input$entity}).getItemCooldownManager().set((${mappedMCItemToItemStackCode(input$item, 1)}).getItem(), (int) ${input$ticks});