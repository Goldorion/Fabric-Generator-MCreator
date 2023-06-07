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

<#include "../mcitems.ftl">

/*
 *	MCreator note: This file will be REGENERATED on each build.
 */

package ${package}.init;

import net.fabricmc.fabric.api.itemgroup.v1.FabricItemGroup;

public class ${JavaModName}Tabs {

	<#list tabs as tab>
		public static ResourceKey<CreativeModeTab> TAB_${tab.getModElement().getRegistryNameUpper()} = ResourceKey.create(Registries.CREATIVE_MODE_TAB, new ResourceLocation(${JavaModName}.MODID, "${tab.getModElement().getRegistryName()}"));
	</#list>

	public static void load() {
		<#list tabs as tab>
		Registry.register(BuiltInRegistries.CREATIVE_MODE_TAB, TAB_${tab.getModElement().getRegistryNameUpper()}, FabricItemGroup.builder()
			.title(Component.translatable("item_group." + ${JavaModName}.MODID + ".${tab.getModElement().getRegistryName()}"))
			.icon(()-> ${mappedMCItemToItemStackCode(tab.icon, 1)}).build());
		</#list>
	}

}

<#-- @formatter:on -->