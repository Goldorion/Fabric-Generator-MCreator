<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2012-2020, Pylo
 # Copyright (C) 2020-2021, Pylo, opensource contributors
 # Copyright (C) 2020-2022, Goldorion, opensource contributors
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
<#include "procedures.java.ftl">
<#include "triggers.java.ftl">

package ${package}.item;

import net.minecraft.sounds.SoundEvent;
import net.fabricmc.api.Environment;

public abstract class ${name}Item extends ArmorItem {

	public ${name}Item(EquipmentSlot slot, Item.Properties properties) {
		super(new ArmorMaterial() {
			@Override public int getDurabilityForSlot(EquipmentSlot slot) {
				return new int[]{13, 15, 16, 11}[slot.getIndex()] * ${data.maxDamage};
			}

			@Override public int getDefenseForSlot(EquipmentSlot slot) {
				return new int[] { ${data.damageValueBoots}, ${data.damageValueLeggings}, ${data.damageValueBody}, ${data.damageValueHelmet} }[slot.getIndex()];
			}

			@Override public int getEnchantmentValue() {
				return ${data.enchantability};
			}

			@Override public SoundEvent getEquipSound() {
				<#if data.equipSound.getMappedValue()?has_content>
					<#if data.equipSound.getUnmappedValue().startsWith("CUSTOM:")>
						return ${JavaModName}Sounds.${data.equipSound?replace(modid + ":", "")?upper_case};
					<#else>
					<#assign s=data.equipSound>
						return SoundEvents.${(s?starts_with("ambient")||s?starts_with("music")||s?starts_with("ui")||s?starts_with("weather"))?string(s?upper_case?replace(".", "_"),s?keep_after(".")?upper_case?replace(".", "_"))};
					</#if>
				<#else>
					return null;
				</#if>
			}

			@Override public Ingredient getRepairIngredient() {
				<#if data.repairItems?has_content>
					return Ingredient.of(
								<#list data.repairItems as repairItem>
									${mappedMCItemToItemStackCode(repairItem,1)}<#if repairItem?has_next>,</#if>
								</#list>
					);
				<#else>
					return Ingredient.EMPTY;
				</#if>
			}

			@Environment(EnvType.CLIENT)
			@Override public String getName() {
				return "${data.armorTextureFile}";
			}

			@Override public float getToughness() {
				return ${data.toughness}f;
			}

			@Override public float getKnockbackResistance() {
				return ${data.knockbackResistance}f;
			}
		}, slot, properties);
	}

	<#if data.enableHelmet>
		public static class Helmet extends ${name}Item {
	
			public Helmet() {
				super(EquipmentSlot.HEAD, new Item.Properties()<#if data.helmetImmuneToFire>.fireResistant()</#if>);
		        ItemGroupEvents.modifyEntriesEvent(${data.creativeTab})
		            .register(entries -> entries.accept(this));
			}
	
			<#if data.helmetSpecialInfo?has_content>
				@Override public void appendHoverText(ItemStack itemstack, Level world, List<Component> list, TooltipFlag flag) {
				super.appendHoverText(itemstack, world, list, flag);
					<#list data.helmetSpecialInfo as entry>
						list.add(Component.literal("${JavaConventions.escapeStringForJava(entry)}"));
					</#list>
				}
			</#if>
			<#if hasProcedure(data.onHelmetTick)>
				@Override
				public void inventoryTick(ItemStack itemstack, Level world, Entity entity, int slotinv, boolean selected) {
					double unique = Math.random();
					ItemStack stack = entity instanceof LivingEntity _entGetArmor ? _entGetArmor.getItemBySlot(EquipmentSlot.HEAD) : ItemStack.EMPTY;
					if (stack.getItem() == (itemstack).getItem()) {
						if (stack.getOrCreateTag().getDouble("_id") != unique)
							stack.getOrCreateTag().putDouble("_id", unique);
						if (itemstack.getOrCreateTag().getDouble("_id") == unique)
							<@onArmorTick data.onHelmetTick/>
					}
				}
			</#if>
				}
	</#if>

	<#if data.enableBody>
		public static class Chestplate extends ${name}Item {
	
			public Chestplate() {
				super(EquipmentSlot.CHEST, new Item.Properties()<#if data.bodyImmuneToFire>.fireResistant()</#if>);
		        ItemGroupEvents.modifyEntriesEvent(${data.creativeTab})
		            .register(entries -> entries.accept(this));
			}
	
			<#if data.bodySpecialInfo?has_content>
				@Override public void appendHoverText(ItemStack itemstack, Level world, List<Component> list, TooltipFlag flag) {
				super.appendHoverText(itemstack, world, list, flag);
					<#list data.bodySpecialInfo as entry>
						list.add(Component.literal("${JavaConventions.escapeStringForJava(entry)}"));
					</#list>
				}
			</#if>
			<#if hasProcedure(data.onBodyTick)>
				@Override
				public void inventoryTick(ItemStack itemstack, Level world, Entity entity, int slotinv, boolean selected) {
					double unique = Math.random();
					ItemStack stack = entity instanceof LivingEntity _entGetArmor ? _entGetArmor.getItemBySlot(EquipmentSlot.CHEST) : ItemStack.EMPTY;
					if (stack.getItem() == (itemstack).getItem()) {
						if (stack.getOrCreateTag().getDouble("_id") != unique)
							stack.getOrCreateTag().putDouble("_id", unique);
						if (itemstack.getOrCreateTag().getDouble("_id") == unique)
							<@onArmorTick data.onBodyTick/>
					}
				}
			</#if>
		}
	</#if>

	<#if data.enableLeggings>
		public static class Leggings extends ${name}Item {
	
			public Leggings() {
				super(EquipmentSlot.LEGS, new Item.Properties()<#if data.leggingsImmuneToFire>.fireResistant()</#if>);
		        ItemGroupEvents.modifyEntriesEvent(${data.creativeTab})
		            .register(entries -> entries.accept(this));
			}
	
			<#if data.leggingsSpecialInfo?has_content>
				@Override public void appendHoverText(ItemStack itemstack, Level world, List<Component> list, TooltipFlag flag) {
				super.appendHoverText(itemstack, world, list, flag);
					<#list data.leggingsSpecialInfo as entry>
						list.add(Component.literal("${JavaConventions.escapeStringForJava(entry)}"));
					</#list>
				}
			</#if>
			<#if hasProcedure(data.onLeggingsTick)>
				@Override
				public void inventoryTick(ItemStack itemstack, Level world, Entity entity, int slotinv, boolean selected) {
					double unique = Math.random();
					ItemStack stack = entity instanceof LivingEntity _entGetArmor ? _entGetArmor.getItemBySlot(EquipmentSlot.LEGS) : ItemStack.EMPTY;
					if (stack.getItem() == (itemstack).getItem()) {
						if (stack.getOrCreateTag().getDouble("_id") != unique)
							stack.getOrCreateTag().putDouble("_id", unique);
						if (itemstack.getOrCreateTag().getDouble("_id") == unique)
							<@onArmorTick data.onLeggingsTick/>
					}
				}
			</#if>
		}
	</#if>

	<#if data.enableBoots>
		public static class Boots extends ${name}Item {
	
			public Boots() {
				super(EquipmentSlot.FEET, new Item.Properties()<#if data.bootsImmuneToFire>.fireResistant()</#if>);
		        ItemGroupEvents.modifyEntriesEvent(${data.creativeTab})
		            .register(entries -> entries.accept(this));
			}
	
			<#if data.bootsSpecialInfo?has_content>
				@Override public void appendHoverText(ItemStack itemstack, Level world, List<Component> list, TooltipFlag flag) {
				super.appendHoverText(itemstack, world, list, flag);
					<#list data.bootsSpecialInfo as entry>
						list.add(Component.literal("${JavaConventions.escapeStringForJava(entry)}"));
					</#list>
				}
			</#if>
			<#if hasProcedure(data.onBootsTick)>
				@Override
				public void inventoryTick(ItemStack itemstack, Level world, Entity entity, int slotinv, boolean selected) {
					double unique = Math.random();
					ItemStack stack = entity instanceof LivingEntity _entGetArmor ? _entGetArmor.getItemBySlot(EquipmentSlot.FEET) : ItemStack.EMPTY;
					if (stack.getItem() == (itemstack).getItem()) {
						if (stack.getOrCreateTag().getDouble("_id") != unique)
							stack.getOrCreateTag().putDouble("_id", unique);
						if (itemstack.getOrCreateTag().getDouble("_id") == unique)
							<@onArmorTick data.onBootsTick/>
					}
				}
			</#if>
		}
	</#if>

}
<#-- @formatter:on -->
