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
			    if(ench == ${compatibleEnchantment})
                    return true;
            </#list>
            return false;
        }
    </#if>

    <#if data.compatibleItems?has_content>
		@Override
        public boolean isAcceptableItem(ItemStack stack) {
            <#list data.compatibleItems as compatibleItem>
			    if(stack.getItem() == ${mappedMCItemToItem(compatibleItem)})
                    return true;
            </#list>
            return false;
        }
    </#if>

    @Override
    public boolean isTreasure() {
        return ${data.isTreasureEnchantment};
    }

    @Override
    public boolean isCurse() {
        return ${data.isCurse};
    }

    @Override
    public boolean isAvailableForEnchantedBookOffer() {
        return ${data.isAllowedOnBooks};
    }
}

<#-- @formatter:on -->