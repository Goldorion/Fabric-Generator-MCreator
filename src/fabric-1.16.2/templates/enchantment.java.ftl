<#--
This file is part of MCreatorFabricGenerator.

MCreatorFabricGenerator is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

MCreatorFabricGenerator is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with MCreatorFabricGenerator.  If not, see <https://www.gnu.org/licenses/>.
-->

<#-- @formatter:off -->
<#include "mcitems.ftl">

package ${package}.item;

public class ${name}Enchantment extends Enchantment {
    public ${name}Enchantment() {
        super(Enchantment.Rarity.${data.rarity}, EnchantmentTarget.${generator.map(data.type, "enchantmenttypes")}, new EquipmentSlot[]{EquipmentSlot.MAINHAND});
    }

    @Override
    public int getMinLevel() {
        return 1;
    }

    @Override
    public int getMaxLevel() {
        return 1;
    }

    <#if data.damageModifier != 0>
        @Override public int getProtectionAmount(int level, DamageSource source) {
            return level * ${data.damageModifier};
        }
    </#if>

    <#if data.compatibleEnchantments?has_content>
		@Override
        public boolean canAccept(Enchantment ench) {
			<#list data.compatibleEnchantments as compatibleEnchantment>
			    if(ench == Enchantments.${compatibleEnchantment})
                    return true;
            </#list>
            return false;
        }
    </#if>

    <#if data.compatibleItems?has_content>
		@Override
        public boolean isAcceptableItem(ItemStack stack) {
            <#list data.compatibleItems as compatibleItem>
			    if(stack.getItem() == ${mappedMCItemToItem(compatibleItem)?remove_ending(", (int)(1)")})
                    return true;
            </#list>
            return false;
        }
    </#if>

    @Override
    public boolean isTreasure() {
        return ${data.isTreasureEnchantment};
    }

    public boolean isCurse() {
        return ${data.isCurse};
    }

    @Override
    public boolean isAvailableForEnchantedBookOffer() {
        return ${data.isAllowedOnBooks};
    }
}

<#-- @formatter:on -->
