<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2012-2020, Pylo
 # Copyright (C) 2020-2023, Pylo, opensource contributors
 # Copyright (C) 2020-2023, Goldorion, opensource contributors
 #
 # Fabric-Generator-MCreator is free software: you can redistribute it and/or modify
 # it under the terms of the GNU Lesser General Public License as published by
 # the Free Software Foundation, either version 3 of the License, or
 # (at your option) any later version.

 # Fabric-Generator-MCreator is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 # GNU Lesser General Public License for more details.
 #
 # You should have received a copy of the GNU Lesser General Public License
 # along with Fabric-Generator-MCreator.  If not, see <https://www.gnu.org/licenses/>.
-->

<#-- @formatter:off -->
<#include "mcitems.ftl">

package ${package}.enchantment;

public class ${name}Enchantment extends Enchantment {

	public ${name}Enchantment(EquipmentSlot... slots) {
		super(Enchantment.Rarity.${data.rarity}, EnchantmentCategory.${generator.map(data.type, "enchantmenttypes")}, slots);
	}

	<#if data.minLevel != 1>
		@Override public int getMinLevel() {
			return ${data.minLevel};
		}
	</#if>

	<#if data.maxLevel != 1>
		@Override public int getMaxLevel() {
			return ${data.maxLevel};
		}
	</#if>

	<#if data.damageModifier != 0>
		@Override public int getDamageProtection(int level, DamageSource source) {
			return level * ${data.damageModifier};
		}
	</#if>

	<#if data.compatibleEnchantments?has_content>
		@Override protected boolean checkCompatibility(Enchantment ench) {
			<#list data.compatibleEnchantments as compatibleEnchantment>
				if(ench == ${compatibleEnchantment})
					return true;
			</#list>
			return false;
		}
	</#if>

	<#if data.compatibleItems?has_content>
		@Override public boolean canEnchant(ItemStack itemstack) {
			return <#if data.excludeItems>!</#if>${mappedMCItemsToIngredient(data.compatibleItems)}.test(itemstack);
		}
	</#if>

	<#if data.isTreasureEnchantment>
		@Override public boolean isTreasureOnly() {
			return true;
		}
	</#if>

	<#if data.isCurse>
		@Override public boolean isCurse() {
			return true;
		}
	</#if>

	<#if !data.isAllowedOnBooks>
		@Override public boolean isAllowedOnBooks() {
			return false;
		}
	</#if>

	<#if !data.canGenerateInLootTables>
		@Override public boolean isDiscoverable() {
			return false;
		}
	</#if>

	<#if !data.canVillagerTrade>
		@Override public boolean isTradeable() {
			return false;
		}
	</#if>
}
<#-- @formatter:on -->