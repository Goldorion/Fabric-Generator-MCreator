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
<#include "../procedures.java.ftl">

/*
 *    MCreator note: This file will be REGENERATED on each build.
 */

package ${package}.init;

<#assign hasBlocks = false>
<#assign hasDoubleBlocks = false>
<#assign hasSigns = false>
<#assign chunks = items?chunk(2500)>
<#assign has_chunks = chunks?size gt 1>

public class ${JavaModName}Items {

	<@javacompress>
	<#list items as item>
		<#if item.getModElement().getTypeString() == "armor">
			<#if item.enableHelmet>public static Item ${item.getModElement().getRegistryNameUpper()}_HELMET;</#if>
			<#if item.enableBody>public static Item ${item.getModElement().getRegistryNameUpper()}_CHESTPLATE;</#if>
			<#if item.enableLeggings>public static Item ${item.getModElement().getRegistryNameUpper()}_LEGGINGS;</#if>
			<#if item.enableBoots>public static Item ${item.getModElement().getRegistryNameUpper()}_BOOTS;</#if>
		<#elseif item.getModElement().getTypeString() == "livingentity">
			public static Item ${item.getModElement().getRegistryNameUpper()}_SPAWN_EGG;
		<#elseif item.getModElement().getTypeString() == "fluid" && item.generateBucket>
			public static Item ${item.getModElement().getRegistryNameUpper()}_BUCKET;
		<#else>
			public static Item ${item.getModElement().getRegistryNameUpper()};
		</#if>
	</#list>
	</@javacompress>

	<#list chunks as sub_items>
	    public static void <#if has_chunks>register${sub_items?index}<#else>load</#if>() {
		<#list sub_items as item>
			<#if item.getModElement().getTypeString() == "armor">
				<#if item.enableHelmet>
				${item.getModElement().getRegistryNameUpper()}_HELMET =
					register("${item.getModElement().getRegistryName()}_helmet", ${item.getModElement().getName()}Item.Helmet::new);
				</#if>
				<#if item.enableBody>
				${item.getModElement().getRegistryNameUpper()}_CHESTPLATE =
					register("${item.getModElement().getRegistryName()}_chestplate", ${item.getModElement().getName()}Item.Chestplate::new);
				</#if>
				<#if item.enableLeggings>
				${item.getModElement().getRegistryNameUpper()}_LEGGINGS =
					register("${item.getModElement().getRegistryName()}_leggings", ${item.getModElement().getName()}Item.Leggings::new);
				</#if>
				<#if item.enableBoots>
				${item.getModElement().getRegistryNameUpper()}_BOOTS =
					register("${item.getModElement().getRegistryName()}_boots", ${item.getModElement().getName()}Item.Boots::new);
				</#if>
			<#elseif item.getModElement().getTypeString() == "livingentity">
				${item.getModElement().getRegistryNameUpper()}_SPAWN_EGG =
					register("${item.getModElement().getRegistryName()}_spawn_egg",
						properties -> new SpawnEggItem(${JavaModName}Entities.${item.getModElement().getRegistryNameUpper()}, properties));
			<#elseif item.getModElement().getTypeString() == "specialentity">
				${item.getModElement().getRegistryNameUpper()} =
					register("${item.getModElement().getRegistryName()}",
						properties -> new BoatItem(${JavaModName}Entities.${item.getModElement().getRegistryNameUpper()}, properties.stacksTo(1)));
			<#elseif item.getModElement().getTypeString() == "dimension" && item.hasIgniter()>
				${item.getModElement().getRegistryNameUpper()} =
					register("${item.getModElement().getRegistryName()}", ${item.getModElement().getName()}Item::new);
			<#elseif item.getModElement().getTypeString() == "fluid" && item.generateBucket>
				${item.getModElement().getRegistryNameUpper()}_BUCKET =
					register("${item.getModElement().getRegistryName()}_bucket", ${item.getModElement().getName()}Item::new);
			<#elseif item.getModElement().getTypeString() == "block" || item.getModElement().getTypeString() == "plant">
				<#if item.hasSpecialInformation(w)>
					${item.getModElement().getRegistryNameUpper()} =
						register("${item.getModElement().getRegistryName()}",
							<#if item.hasCustomItemProperties()>
								properties -> new ${item.getModElement().getName()}Block.Item(<@blockItemProperties item false/>)
							<#else>
								${item.getModElement().getName()}Block.Item::new
							</#if>
						);
				<#else>
					<#if item.isDoubleBlock()>
						<#assign hasDoubleBlocks = true>
						${item.getModElement().getRegistryNameUpper()} =
							doubleBlock(${JavaModName}Blocks.${item.getModElement().getRegistryNameUpper()}, "${item.getModElement().getRegistryName()}"
							<#if item.hasCustomItemProperties()>, <@blockItemProperties item/></#if>);
					<#elseif (item.getModElement().getTypeString() == "block") && (item.blockBase! == "Sign")>
						<#assign hasSigns = true>
						${item.getModElement().getRegistryNameUpper()} =
							signBlock(${JavaModName}Blocks.${item.getModElement().getRegistryNameUpper()}, "${item.getModElement().getRegistryName()}", ${JavaModName}Blocks.${item.getWallRegistryNameUpper()}
							<#if item.hasCustomItemProperties()>, <@blockItemProperties item/></#if>);
					<#else>
						<#assign hasBlocks = true>
						${item.getModElement().getRegistryNameUpper()} =
							block(${JavaModName}Blocks.${item.getModElement().getRegistryNameUpper()}, "${item.getModElement().getRegistryName()}"
							<#if item.hasCustomItemProperties()>, <@blockItemProperties item/></#if>);
					</#if>
				</#if>
			<#else>
				${item.getModElement().getRegistryNameUpper()} =
					register("${item.getModElement().getRegistryName()}", ${item.getModElement().getName()}Item::new);
			</#if>
		</#list>
	}
	</#list>

	<#if has_chunks>
	public static void load() {
		<#list 0..chunks?size-1 as i>register${i}();</#list>
	}
	</#if>

	// Start of user code block custom items
	// End of user code block custom items

	private static <I extends Item> I register(String name, Function<Item.Properties, ? extends I> supplier) {
		return (I) Items.registerItem(ResourceKey.create(Registries.ITEM, ResourceLocation.fromNamespaceAndPath(${JavaModName}.MODID, name)), (Function<Item.Properties, Item>) supplier);
	}

	<#if hasBlocks>
	private static Item block(Block block, String name) {
		return block(block, name, new Item.Properties());
	}

	private static Item block(Block block, String name, Item.Properties properties) {
		return Items.registerItem(ResourceKey.create(Registries.ITEM, ResourceLocation.fromNamespaceAndPath(${JavaModName}.MODID, name)), prop -> new BlockItem(block, prop), properties);
	}
	</#if>

	<#if hasDoubleBlocks>
	private static Item doubleBlock(Block block, String name) {
		return doubleBlock(block, name, new Item.Properties());
	}

	private static Item doubleBlock(Block block, String name, Item.Properties properties) {
		return Items.registerItem(ResourceKey.create(Registries.ITEM, ResourceLocation.fromNamespaceAndPath(${JavaModName}.MODID, name)), prop -> new DoubleHighBlockItem(block, prop), properties);
	}
	</#if>

	<#if hasSigns>
	private static Item signBlock(Block block, String name, Block wallBlock) {
		return signBlock(block, name, wallBlock, new Item.Properties());
	}

	private static Item signBlock(Block block, String name, Block wallBlock, Item.Properties properties) {
		return Items.registerItem(ResourceKey.create(Registries.ITEM, ResourceLocation.fromNamespaceAndPath(${JavaModName}.MODID, name)), prop -> new SignItem(block, wallBlock, prop), properties);
	}
	</#if>
}
<#macro blockItemProperties block newProperties=true>
<#if newProperties>new Item.Properties()<#else>properties</#if>
<#if block.maxStackSize != 64>
	.stacksTo(${block.maxStackSize})
</#if>
<#if block.rarity != "COMMON">
	.rarity(Rarity.${block.rarity})
</#if>
<#if block.immuneToFire>
	.fireResistant()
</#if>
</#macro>
<#-- @formatter:on -->