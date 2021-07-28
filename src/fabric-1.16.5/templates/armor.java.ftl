<#--
This file is part of Fabric-Generator-MCreator.

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

import net.fabricmc.api.EnvType;
import net.fabricmc.api.Environment;
import ${package}.${JavaModName};

public class ${name}ArmorMaterial implements ArmorMaterial {

    private static final int[] BASE_DURABILITY = new int[]{13, 15, 16, 11};
    private static final int[] PROTECTION_VALUES = new int[]{${data.damageValueBoots}, ${data.damageValueLeggings}, ${data.damageValueBody}, ${data.damageValueHelmet}};

    <#if data.enableHelmet>
        public static final Item HELMET = new ArmorItem(new ${name}ArmorMaterial(), EquipmentSlot.HEAD,
            new Item.Settings()<#if data.enableHelmet>.group(${data.creativeTab})</#if>) <#if data.helmetSpecialInfo?has_content> {
                @Override
                @Environment(EnvType.CLIENT)
                public void appendTooltip(ItemStack stack, World world, List<Text> tooltip, TooltipContext context) {
                    <#list data.helmetSpecialInfo as entry>
                    tooltip.add(new LiteralText("${JavaConventions.escapeStringForJava(entry)}"));
                    </#list>
                }
       }</#if>;
   </#if>

    <#if data.enableBody>
        public static final Item CHESTPLATE = new ArmorItem(new ${name}ArmorMaterial(), EquipmentSlot.CHEST,
            new Item.Settings()<#if data.enableBody>.group(${data.creativeTab})</#if>) <#if data.bodySpecialInfo?has_content> {
                @Override
                @Environment(EnvType.CLIENT)
                public void appendTooltip(ItemStack stack, World world, List<Text> tooltip, TooltipContext context) {
                    <#list data.bodySpecialInfo as entry>
                    tooltip.add(new LiteralText("${JavaConventions.escapeStringForJava(entry)}"));
                    </#list>
                }
       }</#if>;
   </#if>

    <#if data.enableLeggings>
        public static final Item LEGGINGS = new ArmorItem(new ${name}ArmorMaterial(), EquipmentSlot.LEGS,
            new Item.Settings()<#if data.enableLeggings>.group(${data.creativeTab})</#if>) <#if data.leggingsSpecialInfo?has_content> {
                @Override
                @Environment(EnvType.CLIENT)
                public void appendTooltip(ItemStack stack, World world, List<Text> tooltip, TooltipContext context) {
                    <#list data.leggingsSpecialInfo as entry>
                    tooltip.add(new LiteralText("${JavaConventions.escapeStringForJava(entry)}"));
                    </#list>
                }
       }</#if>;
   </#if>

    <#if data.enableBoots>
        public static final Item BOOTS = new ArmorItem(new ${name}ArmorMaterial(), EquipmentSlot.FEET,
            new Item.Settings()<#if data.enableBoots>.group(${data.creativeTab})</#if>) <#if data.bootsSpecialInfo?has_content> {
                @Override
                @Environment(EnvType.CLIENT)
                public void appendTooltip(ItemStack stack, World world, List<Text> tooltip, TooltipContext context) {
                    <#list data.bootsSpecialInfo as entry>
                    tooltip.add(new LiteralText("${JavaConventions.escapeStringForJava(entry)}"));
                    </#list>
                }
       }</#if>;
   </#if>

    public int getDurability(EquipmentSlot equipmentSlot_1) {
        return BASE_DURABILITY[equipmentSlot_1.getEntitySlotId()] * ${data.maxDamage};
    }

    public int getProtectionAmount(EquipmentSlot equipmentSlot_1) {
        return PROTECTION_VALUES[equipmentSlot_1.getEntitySlotId()];
    }

    public int getEnchantability() {
        return ${data.enchantability};
    }

    public SoundEvent getEquipSound() {
        return <#if data.equipSound?contains(modid)>${JavaModName}.${data.equipSound?remove_beginning(modid + ":")}Event
            <#elseif (data.equipSound?length > 0)>
                SoundEvents.${data.equipSound}
            <#else>
                null
            </#if>;
    }

    public Ingredient getRepairIngredient() {
        return Ingredient.ofItems(
            <#if data.repairItems?has_content>
                <#list data.repairItems as repairItem>
                    ${mappedMCItemToItemStackCodeNoItemStackValue(repairItem)?replace("Blocks.", "Items.")}<#if repairItem?has_next>,</#if>
               </#list>
            <#else>
                Items.AIR
            </#if>
        );
    }

    @Environment(EnvType.CLIENT)
    public String getName() {
        return "${data.armorTextureFile}";
    }

    public float getToughness() {
        return  ${data.toughness}F;
    }

    public float getKnockbackResistance() {
        return ${data.knockbackResistance}f;
    }
}
<#-- @formatter:on -->
