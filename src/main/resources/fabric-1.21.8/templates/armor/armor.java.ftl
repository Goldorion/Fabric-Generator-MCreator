<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2012-2020, Pylo
 # Copyright (C) 2020-2025, Pylo, opensource contributors
 # Copyright (C) 2020-2025, Goldorion, opensource contributors
 #
 # Fabric-Generator-MCreator is free software: you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
 # the Free Software Foundation, either version 3 of the License, or
 # (at your option) any later version.
 #
 # Fabric-Generator-MCreator is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
 # along with Fabric-Generator-MCreator. If not, see <https://www.gnu.org/licenses/>.
-->

<#-- @formatter:off -->
<#include "../mcitems.ftl">
<#include "../procedures.java.ftl">
<#include "../triggers.java.ftl">

package ${package}.item;

import java.util.Map;

public abstract class ${name}Item extends Item {

	public static ArmorMaterial ARMOR_MATERIAL = new ArmorMaterial(
		${data.maxDamage},
		Map.of(
			ArmorType.BOOTS, ${data.damageValueBoots},
			ArmorType.LEGGINGS, ${data.damageValueLeggings},
			ArmorType.CHESTPLATE, ${data.damageValueBody},
			ArmorType.HELMET, ${data.damageValueHelmet},
			ArmorType.BODY, ${data.damageValueBody}
		),
		${data.enchantability},
		<#if data.equipSound?has_content && data.equipSound.getUnmappedValue()?has_content>
		BuiltInRegistries.SOUND_EVENT.wrapAsHolder(BuiltInRegistries.SOUND_EVENT.getValue(ResourceLocation.parse("${data.equipSound}"))),
		<#else>
		BuiltInRegistries.SOUND_EVENT.wrapAsHolder(SoundEvents.EMPTY),
		</#if>
		${data.toughness}f,
		${data.knockbackResistance}f,
		TagKey.create(Registries.ITEM, ResourceLocation.parse("${modid}:${registryname}_repair_items")), <#-- data.repairItems are put into a tag -->
		ResourceKey.create(EquipmentAssets.ROOT_ID, ResourceLocation.parse("${modid}:${registryname}")) <#-- data.armorTextureFile - just dummy, we override this in client extensions -->
	);

	private ${name}Item(Item.Properties properties) {
		super(properties);
	}

	<#if data.enableHelmet>
	public static class Helmet extends ${name}Item {

		public Helmet(Item.Properties properties) {
			super(properties<#if data.helmetImmuneToFire>.fireResistant()</#if>.humanoidArmor(ARMOR_MATERIAL, ArmorType.HELMET));
		}

		<@addSpecialInformation data.helmetSpecialInformation, "item." + modid + "." + registryname + "_helmet"/>

		<@hasGlow data.helmetGlowCondition/>

		<@piglinNeutral data.helmetPiglinNeutral/>

		<@onArmorTick data.onHelmetTick/>
	}
	</#if>

	<#if data.enableBody>
	public static class Chestplate extends ${name}Item {

		public Chestplate(Item.Properties properties) {
			super(properties<#if data.bodyImmuneToFire>.fireResistant()</#if>.humanoidArmor(ARMOR_MATERIAL, ArmorType.CHESTPLATE));
		}

		<@addSpecialInformation data.bodySpecialInformation, "item." + modid + "." + registryname + "_chestplate"/>

		<@hasGlow data.bodyGlowCondition/>

		<@piglinNeutral data.bodyPiglinNeutral/>

		<@onArmorTick data.onBodyTick/>
	}
	</#if>

	<#if data.enableLeggings>
	public static class Leggings extends ${name}Item {

		public Leggings(Item.Properties properties) {
			super(properties<#if data.leggingsImmuneToFire>.fireResistant()</#if>.humanoidArmor(ARMOR_MATERIAL, ArmorType.LEGGINGS));
		}

		<@addSpecialInformation data.leggingsSpecialInformation, "item." + modid + "." + registryname + "_leggings"/>

		<@hasGlow data.leggingsGlowCondition/>

		<@piglinNeutral data.leggingsPiglinNeutral/>

		<@onArmorTick data.onLeggingsTick/>
	}
	</#if>

	<#if data.enableBoots>
	public static class Boots extends ${name}Item {

		public Boots(Item.Properties properties) {
			super(properties<#if data.bootsImmuneToFire>.fireResistant()</#if>.humanoidArmor(ARMOR_MATERIAL, ArmorType.BOOTS));
		}

		<@addSpecialInformation data.bootsSpecialInformation, "item." + modid + "." + registryname + "_boots"/>

		<@hasGlow data.bootsGlowCondition/>

		<@piglinNeutral data.bootsPiglinNeutral/>

		<@onArmorTick data.onBootsTick/>
	}
	</#if>

}
<#-- @formatter:on -->