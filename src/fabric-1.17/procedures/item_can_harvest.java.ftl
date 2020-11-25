<#include "mcitems.ftl">
new ItemStack((${mappedMCItemToItemStackCode(input$item, 1)}).getItem().isEffectiveOn(${mappedBlockToBlockStateCode(input$block)}))