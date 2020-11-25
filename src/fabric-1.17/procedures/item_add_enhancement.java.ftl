<#include "mcitems.ftl">
new ItemStack(${mappedMCItemToItemStackCode(input$item, 1), 1}).addEnchantment(${generator.map(field$enhancement, "enchantments")},(int) ${input$level});