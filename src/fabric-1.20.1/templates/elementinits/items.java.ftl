<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2020-2023, Goldorion, opensource contributors
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
/*
 *	MCreator note: This file will be REGENERATED on each build.
 */

<#compress>
package ${package}.init;

<#assign hasBlocks = false>
<#assign hasItemsWithProperties = w.getGElementsOfType("item")?filter(e -> e.customProperties?has_content)?size != 0
	|| w.getGElementsOfType("tool")?filter(e -> e.toolType == "Shield")?size != 0>

public class ${JavaModName}Items {

	<#list items as item>
		<#if item.getModElement().getTypeString() == "armor">
			<#if item.enableHelmet>
				public static Item ${item.getModElement().getRegistryNameUpper()}_HELMET;
			</#if>
			<#if item.enableBody>
				public static Item ${item.getModElement().getRegistryNameUpper()}_CHESTPLATE;
			</#if>
			<#if item.enableLeggings>
				public static Item ${item.getModElement().getRegistryNameUpper()}_LEGGINGS;
			</#if>
			<#if item.enableBoots>
				public static Item ${item.getModElement().getRegistryNameUpper()}_BOOTS;
			</#if>
		<#elseif item.getModElement().getTypeString() == "livingentity">
			public static Item ${item.getModElement().getRegistryNameUpper()}_SPAWN_EGG;
		<#elseif item.getModElement().getTypeString() != "dimension">
			public static Item ${item.getModElement().getRegistryNameUpper()};
		</#if>
	</#list>

	public static void load() {
		<#list items as item>
			<#if item.getModElement().getTypeString() == "armor">
				<#if item.enableHelmet>
					${item.getModElement().getRegistryNameUpper()}_HELMET = register("${item.getModElement().getRegistryName()}_helmet", new ${item.getModElement().getName()}Item.Helmet());
				</#if>
				<#if item.enableBody>
					${item.getModElement().getRegistryNameUpper()}_CHESTPLATE = register("${item.getModElement().getRegistryName()}_chestplate", new ${item.getModElement().getName()}Item.Chestplate());
				</#if>
				<#if item.enableLeggings>
					${item.getModElement().getRegistryNameUpper()}_LEGGINGS = register("${item.getModElement().getRegistryName()}_leggings", new ${item.getModElement().getName()}Item.Leggings());
				</#if>
				<#if item.enableBoots>
					${item.getModElement().getRegistryNameUpper()}_BOOTS = register("${item.getModElement().getRegistryName()}_boots", new ${item.getModElement().getName()}Item.Boots());
				</#if>
			<#elseif item.getModElement().getTypeString() == "livingentity">
				${item.getModElement().getRegistryNameUpper()}_SPAWN_EGG = register("${item.getModElement().getRegistryName()}_spawn_egg", new SpawnEggItem(${JavaModName}Entities.${item.getModElement().getRegistryNameUpper()},
						${item.spawnEggBaseColor.getRGB()}, ${item.spawnEggDotColor.getRGB()}, new Item.Properties()));
				<#if item.creativeTab.getUnmappedValue() != "No creative tab entry">
					ItemGroupEvents.modifyEntriesEvent(${item.creativeTab}).register(content -> content.accept(${item.getModElement().getRegistryNameUpper()}_SPAWN_EGG));
				<#else>
					ItemGroupEvents.modifyEntriesEvent(CreativeModeTabs.SPAWN_EGGS).register(content -> content.accept(${item.getModElement().getRegistryNameUpper()}_SPAWN_EGG));
				</#if>
			<#elseif item.getModElement().getTypeString() == "block" || item.getModElement().getTypeString() == "plant">
				${item.getModElement().getRegistryNameUpper()} = register("${item.getModElement().getRegistryName()}", new BlockItem(${JavaModName}Blocks.${item.getModElement().getRegistryNameUpper()}, new Item.Properties()));
					<#if item.creativeTab.getUnmappedValue() != "No creative tab entry">
						ItemGroupEvents.modifyEntriesEvent(${item.creativeTab}).register(content -> content.accept(${item.getModElement().getRegistryNameUpper()}));
					</#if>
			<#else>
				<#if item.getModElement().getTypeString() != "dimension">
					${item.getModElement().getRegistryNameUpper()} = register("${item.getModElement().getRegistryName()}", new ${item.getModElement().getName()}Item());
				</#if>
			</#if>
		</#list>
	}

	public static void clientLoad() {
		<#if hasItemsWithProperties>
			<#list items as item>
				<#if item.getModElement().getTypeString() == "item">
					<#list item.customProperties.entrySet() as property>
					ItemProperties.register(${item.getModElement().getRegistryNameUpper()},
						new ResourceLocation(${JavaModName}.MODID, "${item.getModElement().getRegistryName()}_${property.getKey()}"),
						(itemStackToRender, clientWorld, entity, itemEntityId) ->
							<#if hasProcedure(property.getValue())>
								(float) <@procedureCode property.getValue(), {
									"x": "entity != null ? entity.getX() : 0",
									"y": "entity != null ? entity.getY() : 0",
									"z": "entity != null ? entity.getZ() : 0",
									"world": "entity != null ? entity.level : clientWorld",
									"entity": "entity",
									"itemstack": "itemStackToRender"
								}, false/>
							<#else>0</#if>
					);
					</#list>
				<#elseif item.getModElement().getTypeString() == "tool" && item.toolType == "Shield">
				    registerBlockingProperty(${item.getModElement().getRegistryNameUpper()});
				</#if>
			</#list>
		</#if>
	}

	private static Item register(String registryName, Item item) {
		return Registry.register(BuiltInRegistries.ITEM, new ResourceLocation(${JavaModName}.MODID, registryName), item);
	}

	private static void registerBlockingProperty(Item item) {
	    ItemProperties.register(item, new ResourceLocation("blocking"), (ClampedItemPropertyFunction) ItemProperties.getProperty(Items.SHIELD, new ResourceLocation("blocking")));
	}

}
</#compress>
<#-- @formatter:on -->