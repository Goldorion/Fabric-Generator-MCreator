<#-- @formatter:off -->
<#include "mcitems.ftl">

package ${package}.item;

import net.fabricmc.api.EnvType;
import net.fabricmc.api.Environment;

public class ${name} extends Item{
    public ${name}(){
        super(new Settings().group(${data.creativeTab})
			<#if data.damageCount != 0>.maxDamage(${data.damageCount})
			<#else>.maxCount(${data.stackSize})</#if>
			<#if data.stayInGridWhenCrafting>
			.recipeRemainder(${mappedMCItemToItem(mappedBlock,1)})</#if>);
    }

    <#if data.hasGlow>
    @Environment(EnvType.CLIENT)
    @Override
    public boolean hasEnchantmentGlint(ItemStack stack){
        return true;
    }
    </#if>

    <#if data.specialInfo?has_content>
		@Override
    public void appendTooltip(ItemStack stack, World world, List<Text> tooltip, TooltipContext context){
		    <#list data.specialInfo as entry>
  	     tooltip.add(new LiteralText("${JavaConventions.escapeStringForJava(entry)}"));
         </#list>
		}
    </#if>

    <#if data.enableMeleeDamage>
    @Override
    public Multimap<String, EntityAttributeModifier> getModifiers(EquipmentSlot slot){
        Multimap<String, EntityAttributeModifier> map = super.getModifiers(slot);
        if(slot == EquipmentSlot.MAINHAND){
            map.put(EntityAttributes.ATTACK_DAMAGE.getId(), new EntityAttributeModifier(ATTACK_DAMAGE_MODIFIER_UUID, "item_damage", (double) ${data.damageVsEntity - 2}, EntityAttributeModifier.Operation.ADDITION));
            map.put(EntityAttributes.ATTACK_SPEED.getId(), new EntityAttributeModifier(ATTACK_SPEED_MODIFIER_UUID, "item_attack_speed", -2.4, EntityAttributeModifier.Operation.ADDITION));
        }
        return map;
    }
    </#if>

    @Override
    public int getEnchantability(){
        return ${data.enchantability};
    }


    <#if data.destroyAnyBlock>
    @Override
    public boolean isEffectiveOn(BlockState state) {
        return true;
    }
    </#if>

}

<#-- @formatter:on -->
