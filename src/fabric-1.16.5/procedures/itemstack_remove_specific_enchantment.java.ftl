<#include "mcitems.ftl">
{
	Map<Enchantment, Integer> _enchantments = EnchantmentHelper.get(${mappedMCItemToItemStackCode(input$item, 1)});
	if (_enchantments.containsKey(${generator.map(field$enhancement, "enchantments")})) {
		_enchantments.remove(${generator.map(field$enhancement, "enchantments")});
		EnchantmentHelper.set(_enchantments, ${mappedMCItemToItemStackCode(input$item, 1)});
	}
}