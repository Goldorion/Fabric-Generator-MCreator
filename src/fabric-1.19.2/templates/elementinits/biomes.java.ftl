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
 *	MCreator note: This file will be REGENERATED on each build.
 */

<#include "../mcitems.ftl">

<#assign spawn_overworld = []>
<#assign spawn_nether = []>

<#list biomes as biome>
	<#if biome.spawnBiome>
		<#assign spawn_overworld += [biome]>
	</#if>
	<#if biome.spawnBiomeNether>
		<#assign spawn_nether += [biome]>
	</#if>
</#list>

package ${package}.init;

import terrablender.api.Regions;
import terrablender.api.SurfaceRuleManager;

public class ${JavaModName}Biomes {

	<#list biomes as biome>
		public static ResourceKey<Biome> ${biome.getModElement().getRegistryNameUpper()} = ResourceKey.create(Registry.BIOME_REGISTRY,
			new ResourceLocation(${JavaModName}.MODID, "${biome.getModElement().getRegistryName()}"));
	</#list>

	public static void load() {
		<#list biomes as biome>
			${biome.getModElement().getName()}Biome.createBiome();
		</#list>
	}
	
	public static void loadTerraBlenderAPI() {
		<#list biomes as biome>
			Regions.register(new ${biome.getModElement().getName()}Region(new ResourceLocation(${JavaModName}.MODID, "${biome.getModElement().getRegistryName()}")));
		</#list>

		<#if spawn_overworld?has_content>
			SurfaceRuleManager.addSurfaceRules(SurfaceRuleManager.RuleCategory.OVERWORLD, ${JavaModName}.MODID, ${JavaModName}SurfaceRules.makeOverworldRules());
		</#if>

		<#if spawn_nether?has_content>
			SurfaceRuleManager.addSurfaceRules(SurfaceRuleManager.RuleCategory.NETHER, ${JavaModName}.MODID, ${JavaModName}SurfaceRules.makeNetherRules());
		</#if>
	}

}

<#-- @formatter:on -->