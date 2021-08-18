<#include "mcitems.ftl">
(${mappedMCItemToItem(input$item)}.isFood() ? ${mappedMCItemToItem(input$item)}.getFoodComponent().getSaturationModifier() : 0)