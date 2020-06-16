<#-- @formatter:off -->
<#include "mcitems.ftl">

package ${package}.item;

import net.fabricmc.api.EnvType;
import net.fabricmc.api.Environment;
import ${package}.${JavaModName};

public enum ${name}Material implements ArmorMaterial {

	${name}("${registryname}", ${data.maxDamage}, new int[]{${data.damageValueBoots}, ${data.damageValueLeggings}, ${data.damageValueBody}, ${data.damageValueHelmet}}, ${data.enchantability},
  <#if data.equipSound?contains(modid)>${JavaModName}.${data.equipSound?remove_beginning(modid + ":")}Event<#else>
  SoundEvents.${data.equipSound}</#if>,
   ${data.toughness}F, () -> {
		return Ingredient.ofItems(<#if data.repairItems?has_content><#list data.repairItems as repairItem>${mappedMCItemToItemStackCode(repairItem)?replace("Blocks.", "Items.")}<#if repairItem?has_next>,</#if></#list><#else>Items.AIR</#if>);
		});

        private static final int[] BASE_DURABILITY = {13, 15, 16, 11};
        private final String name;
        private final int durabilityMultiplier;
        private final int[] armorValues;
        private final int enchantability;
        private final SoundEvent equipSound;
        private final float toughness;
        private final Lazy<Ingredient> repairIngredient;

        ${name}Material(String name, int durabilityMultiplier, int[] armorValueArr, int enchantability, SoundEvent soundEvent, float toughness, Supplier<Ingredient> repairIngredient) {
            this.name = name;
            this.durabilityMultiplier = durabilityMultiplier;
            this.armorValues = armorValueArr;
            this.enchantability = enchantability;
            this.equipSound = soundEvent;
            this.toughness = toughness;
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
    }
<#-- @formatter:on -->
