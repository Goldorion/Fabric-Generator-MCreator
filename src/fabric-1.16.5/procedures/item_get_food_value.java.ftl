<#include "mcitems.ftl">
(${mappedMCItemToItem(input$item)}.isFood() ? ${mappedMCItemToItem(input$item)}.getFoodComponent().getHunger() : 0)