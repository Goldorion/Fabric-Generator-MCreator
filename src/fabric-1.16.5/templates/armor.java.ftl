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

public static final ${name}ArmorMaterial ${name?upper_case} = new ${name}ArmorMaterial("${data.armorTextureFile}", ${data.maxDamage}, new int[]{${data.damageValueBoots}, ${data.damageValueLeggings}, ${data.damageValueBody}, ${data.damageValueHelmet}}, ${data.enchantability},
  <#if data.equipSound?contains(modid)>${JavaModName}.${data.equipSound?remove_beginning(modid + ":")}Event<#elseif (data.equipSound?length > 0)>
  SoundEvents.${data.equipSound}<#else>null</#if>,
${data.toughness}F, 0F, () -> {
return Ingredient.ofItems(<#if data.repairItems?has_content><#list data.repairItems as repairItem>${mappedMCItemToItemStackCodeNoItemStackValue(repairItem)?replace("Blocks.", "Items.")}<#if repairItem?has_next>,</#if></#list><#else>Items.AIR</#if>);
    });

    <#if data.enableHelmet>
        public static final ArmorItem HELMET = new ArmorItem(${name}ArmorMaterial.${name?upper_case}, EquipmentSlot.HEAD,
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
        public static final ArmorItem CHESTPLATE = new ArmorItem(${name}ArmorMaterial.${name?upper_case}, EquipmentSlot.CHEST,
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
        public static final ArmorItem LEGGINGS = new ArmorItem(${name}ArmorMaterial.${name?upper_case}, EquipmentSlot.LEGS,
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
        public static final ArmorItem BOOTS = new ArmorItem(${name}ArmorMaterial.${name?upper_case}, EquipmentSlot.FEET,
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

    private static final int[] BASE_DURABILITY = {13, 15, 16, 11};
    private final String name;
    private final int durabilityMultiplier;
    private final int[] armorValues;
    private final int enchantability;
    private final SoundEvent equipSound;
    private final float toughness;
    private final float knockbackResistance;
    private final Lazy<Ingredient> repairIngredient;

    private ${name}ArmorMaterial(String name, int durabilityMultiplier, int[] armorValueArr, int enchantability, SoundEvent soundEvent, float toughness, float knockbackResistance, Supplier<Ingredient> repairIngredient) {
        this.name = name;
        this.durabilityMultiplier = durabilityMultiplier;
        this.armorValues = armorValueArr;
        this.enchantability = enchantability;
        this.equipSound = soundEvent;
        this.toughness = toughness;
        this.knockbackResistance = knockbackResistance;
        this.repairIngredient = new Lazy(repairIngredient);
    }

    public int getDurability(EquipmentSlot equipmentSlot_1) {
        return BASE_DURABILITY[equipmentSlot_1.getEntitySlotId()] * this.durabilityMultiplier;
    }

    public int getProtectionAmount(EquipmentSlot equipmentSlot_1) {
        return this.armorValues[equipmentSlot_1.getEntitySlotId()];
    }

    public int getEnchantability() {
        return this.enchantability;
    }

    public SoundEvent getEquipSound() {
        return this.equipSound;
    }

    public Ingredient getRepairIngredient() {
        return this.repairIngredient.get();
    }

    @Environment(EnvType.CLIENT)
    public String getName() {
        return this.name;
    }

    public float getToughness() {
        return this.toughness;
    }

    public float getKnockbackResistance() {
        return this.knockbackResistance;
    }
}
<#-- @formatter:on -->
