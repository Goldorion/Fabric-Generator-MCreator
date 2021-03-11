<#include "mcitems.ftl">
((EnchantmentHelper.getLevel(${generator.map(field$enhancement, "enchantments")}, ${mappedMCItemToItemStackCode(input$item, 1)}) != 0))