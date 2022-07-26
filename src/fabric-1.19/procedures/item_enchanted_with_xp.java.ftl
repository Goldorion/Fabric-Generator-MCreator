<#include "mcitems.ftl">
/*@ItemStack*/(EnchantmentHelper.enchantItem(new RandomSource(), ${mappedMCItemToItemStackCode(input$item, 1)}, ${opt.toInt(input$levels)}, ${input$treasure}))