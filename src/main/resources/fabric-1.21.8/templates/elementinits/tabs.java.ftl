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

<#assign tabMap = w.getCreativeTabMap()>
<#assign vanillaTabs = tabMap.keySet()?filter(e -> !e?starts_with('CUSTOM:'))>
<#assign customTabs = tabMap.keySet()?filter(e -> e?starts_with('CUSTOM:'))>

/*
 *	MCreator note: This file will be REGENERATED on each build.
 */

package ${package}.init;

<@javacompress>
public class ${JavaModName}Tabs {

	<#list customTabs as customTab>
	<#assign tab = w.getWorkspace().getModElementByName(customTab.replace("CUSTOM:", "")).getGeneratableElement()>
		public static ResourceKey<CreativeModeTab> TAB_${tab.getModElement().getRegistryNameUpper()} = ResourceKey.create(Registries.CREATIVE_MODE_TAB, ResourceLocation.fromNamespaceAndPath(${JavaModName}.MODID, "${tab.getModElement().getRegistryName()}"));
	</#list>

	public static void load() {
	<#list customTabs as customTab>
		<#assign tab = w.getWorkspace().getModElementByName(customTab.replace("CUSTOM:", "")).getGeneratableElement()>
		Registry.register(BuiltInRegistries.CREATIVE_MODE_TAB, TAB_${tab.getModElement().getRegistryNameUpper()}, FabricItemGroup.builder()
			.title(Component.translatable("item_group.${modid}.${tab.getModElement().getRegistryName()}"))
			.icon(() -> ${mappedMCItemToItemStackCode(tab.icon, 1)})
			.displayItems((parameters, tabData) -> {
				<#list tabMap.get("CUSTOM:" + tab.getModElement().getName()) as tabElement>
				tabData.accept(${mappedMCItemToItem(tabElement)});
				</#list>
			}).build()
		);
	</#list>

		<#if vanillaTabs?has_content>
			<#list vanillaTabs as tabName>
				ItemGroupEvents.modifyEntriesEvent(${generator.map(tabName, "tabs")}).register(tabData -> {
					<#list tabMap.get(tabName) as tabElement>
					tabData.accept(${mappedMCItemToItem(tabElement)}<#if tabName == "OP_BLOCKS">, CreativeModeTab.TabVisibility.PARENT_TAB_ONLY</#if>);
					</#list>
				});
			</#list>
		</#if>
	}
}
</@javacompress>
<#-- @formatter:on -->