<#include "mcitems.ftl">
((${input$entity} instanceof PlayerEntity)?((PlayerEntity)${input$entity}).inventory.contains(${mappedMCItemToItemStackCode(input$item, 1)}):false)