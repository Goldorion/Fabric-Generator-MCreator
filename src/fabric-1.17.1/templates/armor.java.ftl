<#--
 # MCreator (https://mcreator.net/)
 # Copyright (C) 2012-2020, Pylo
 # Copyright (C) 2020-2021, Pylo, opensource contributors
 # Copyright (C) 2020-2022, Goldorion, opensource contributors
 # 
 # This program is free software: you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
 # the Free Software Foundation, either version 3 of the License, or
 # (at your option) any later version.
 # 
 # This program is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 # 
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <https://www.gnu.org/licenses/>.
 # 
 # Additional permission for code generator templates (*.ftl files)
 # 
 # As a special exception, you may create a larger work that contains part or 
 # all of the MCreator code generator templates (*.ftl files) and distribute 
 # that work under terms of your choice, so long as that work isn't itself a 
 # template for code generation. Alternatively, if you modify or redistribute 
 # the template itself, you may (at your option) remove this special exception, 
 # which will cause the template and the resulting code generator output files 
 # to be licensed under the GNU General Public License without this special 
 # exception.
-->

<#-- @formatter:off -->
<#include "mcitems.ftl">
<#include "procedures.java.ftl">
<#include "triggers.java.ftl">

package ${package}.item;

import net.minecraft.sounds.SoundEvent;

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
				<#if data.equipSound??>
				    return new SoundEvent(new ResourceLocation("${data.equipSound}"));
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
			super(EquipmentSlot.HEAD, new Item.Properties().tab(${data.creativeTab})<#if data.helmetImmuneToFire>.fireResistant()</#if>);
		}

		<#if data.helmetSpecialInfo?has_content>
		@Override public void appendHoverText(ItemStack itemstack, Level world, List<Component> list, TooltipFlag flag) {
		super.appendHoverText(itemstack, world, list, flag);
			<#list data.helmetSpecialInfo as entry>
			list.add(new TextComponent("${JavaConventions.escapeStringForJava(entry)}"));
			</#list>
		}
		</#if>
	}
	</#if>

	<#if data.enableBody>
	public static class Chestplate extends ${name}Item {

		public Chestplate() {
			super(EquipmentSlot.CHEST, new Item.Properties().tab(${data.creativeTab})<#if data.bodyImmuneToFire>.fireResistant()</#if>);
		}

		<#if data.bodySpecialInfo?has_content>
		@Override public void appendHoverText(ItemStack itemstack, Level world, List<Component> list, TooltipFlag flag) {
		super.appendHoverText(itemstack, world, list, flag);
			<#list data.bodySpecialInfo as entry>
			list.add(new TextComponent("${JavaConventions.escapeStringForJava(entry)}"));
			</#list>
		}
		</#if>
	}
	</#if>

	<#if data.enableLeggings>
	public static class Leggings extends ${name}Item {

		public Leggings() {
			super(EquipmentSlot.LEGS, new Item.Properties().tab(${data.creativeTab})<#if data.leggingsImmuneToFire>.fireResistant()</#if>);
		}

		<#if data.leggingsSpecialInfo?has_content>
		@Override public void appendHoverText(ItemStack itemstack, Level world, List<Component> list, TooltipFlag flag) {
		super.appendHoverText(itemstack, world, list, flag);
			<#list data.leggingsSpecialInfo as entry>
			list.add(new TextComponent("${JavaConventions.escapeStringForJava(entry)}"));
			</#list>
		}
		</#if>
	}
	</#if>

	<#if data.enableBoots>
	public static class Boots extends ${name}Item {

		public Boots() {
			super(EquipmentSlot.FEET, new Item.Properties().tab(${data.creativeTab})<#if data.bootsImmuneToFire>.fireResistant()</#if>);
		}

		<#if data.bootsSpecialInfo?has_content>
		@Override public void appendHoverText(ItemStack itemstack, Level world, List<Component> list, TooltipFlag flag) {
		super.appendHoverText(itemstack, world, list, flag);
			<#list data.bootsSpecialInfo as entry>
			list.add(new TextComponent("${JavaConventions.escapeStringForJava(entry)}"));
			</#list>
		}
		</#if>
	}
	</#if>

}
<#-- @formatter:on -->