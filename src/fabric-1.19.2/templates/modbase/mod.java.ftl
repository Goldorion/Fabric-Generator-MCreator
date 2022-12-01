<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2020-2021, Goldorion, opensource contributors
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
 *	MCreator note:
 *
 *	If you lock base mod element files, you can edit this file and the proxy files
 *	and they won't get overwritten. If you change your mod package or modid, you
 *	need to apply these changes to this file MANUALLY.
 *
 *
 *	If you do not lock base mod element files in Workspace settings, this file
 *	will be REGENERATED on each build.
 *
 */

package ${package};

import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.LogManager;
import ${package}.init.*;

public class ${JavaModName} implements ModInitializer {

	public static final Logger LOGGER = LogManager.getLogger();

	public static final String MODID = "${modid}";

	@Override
	public void onInitialize() {
		LOGGER.info("Initializing ${JavaModName}");

		<#if w.hasElementsOfType("tab")>${JavaModName}Tabs.load();</#if>
		<#if w.hasElementsOfType("gamerule")>${JavaModName}GameRules.load();</#if>
		<#if w.hasElementsOfType("enchantment")>${JavaModName}Enchantments.load();</#if>
		<#if w.hasElementsOfType("potion")>${JavaModName}Potions.load();</#if>
		<#if w.hasElementsOfBaseType("entity")>${JavaModName}Entities.load();</#if>
		<#if w.hasElementsOfBaseType("block")>${JavaModName}Blocks.load();</#if>
		<#if w.hasElementsOfBaseType("item")>${JavaModName}Items.load();</#if>
		<#if w.hasElementsOfBaseType("blockentity")>${JavaModName}BlockEntities.load();</#if>
		<#if w.hasElementsOfType("biome")>${JavaModName}Biomes.load();</#if>
		<#if w.hasElementsOfBaseType("feature")>${JavaModName}Features.load();</#if>
		<#if w.hasElementsOfType("painting")>${JavaModName}Paintings.load();</#if>
		<#if w.hasElementsOfType("procedure")>${JavaModName}Procedures.load();</#if>
		<#if w.hasElementsOfType("command")>${JavaModName}Commands.load();</#if>
		<#if w.hasElementsOfType("itemextension")>${JavaModName}ItemExtensions.load();</#if>
		<#if w.hasElementsOfType("gui")>${JavaModName}Menus.load();</#if>
		<#if w.hasElementsOfType("keybind")>${JavaModName}KeyMappings.serverLoad();</#if>
		<#if w.getRecipesOfType("Brewing")?has_content>${JavaModName}BrewingRecipes.load();</#if>
		<#if w.hasSounds()>${JavaModName}Sounds.load();</#if>
		<#if w.hasVariablesOfScope("GLOBAL_WORLD") || w.hasVariablesOfScope("GLOBAL_MAP")>{JavaModName}Variables.SyncJoin();</#if>
		<#if w.hasVariablesOfScope("GLOBAL_WORLD") || w.hasVariablesOfScope("GLOBAL_MAP")>{JavaModName}Variables.SyncChangeWorld();</#if>
	}
}
<#-- @formatter:on -->
