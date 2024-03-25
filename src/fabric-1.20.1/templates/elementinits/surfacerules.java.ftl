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

<#include "../mcitems.ftl">
<#compress>

<#assign spawn_overworld = []>
<#assign spawn_caves = []>
<#assign spawn_nether = []>

<#list biomes as biome>
	<#if biome.spawnBiome>
		<#assign spawn_overworld += [biome]>
	</#if>
	<#if biome.spawnInCaves>
		<#assign spawn_caves += [biome]>
	</#if>
	<#if biome.spawnBiomeNether>
		<#assign spawn_nether += [biome]>
	</#if>
</#list>

package ${package}.init;

public class ${JavaModName}SurfaceRules {

	public static SurfaceRules.RuleSource makeOverworldRules() {
		return SurfaceRules.sequence(
		<#list spawn_overworld as biome>
			preliminarySurfaceRule(
				${JavaModName}Biomes.${biome.getModElement().getRegistryNameUpper()},
				${mappedBlockToBlockStateCode(biome.groundBlock)},
				${mappedBlockToBlockStateCode(biome.undergroundBlock)},
				${mappedBlockToBlockStateCode(biome.getUnderwaterBlock())}
			)<#sep>,</#sep>
		</#list><#if spawn_overworld?has_content && spawn_caves?has_content>,</#if>
		<#list spawn_caves as biome>
			anySurfaceRule(
				${JavaModName}Biomes.${biome.getModElement().getRegistryNameUpper()},
				${mappedBlockToBlockStateCode(biome.groundBlock)},
				${mappedBlockToBlockStateCode(biome.undergroundBlock)},
				${mappedBlockToBlockStateCode(biome.getUnderwaterBlock())}
			)<#sep>,</#sep>
		</#list>);
	}

	public static SurfaceRules.RuleSource makeNetherRules() {
		return SurfaceRules.sequence(
		<#list spawn_nether as biome>
			anySurfaceRule(
				${JavaModName}Biomes.${biome.getModElement().getRegistryNameUpper()},
				${mappedBlockToBlockStateCode(biome.groundBlock)},
				${mappedBlockToBlockStateCode(biome.undergroundBlock)},
				${mappedBlockToBlockStateCode(biome.getUnderwaterBlock())}
			)<#sep>,</#sep>
		</#list>);
	}
	
	
	<#if spawn_overworld?has_content>
		private static SurfaceRules.RuleSource preliminarySurfaceRule(ResourceKey<Biome> biomeKey, BlockState groundBlock, BlockState undergroundBlock, BlockState underwaterBlock) {
			return SurfaceRules.ifTrue(SurfaceRules.isBiome(biomeKey),
				SurfaceRules.ifTrue(SurfaceRules.abovePreliminarySurface(),
					SurfaceRules.sequence(
						SurfaceRules.ifTrue(SurfaceRules.stoneDepthCheck(0, false, 0, CaveSurface.FLOOR),
							SurfaceRules.sequence(
								SurfaceRules.ifTrue(SurfaceRules.waterBlockCheck(-1, 0),
									SurfaceRules.state(groundBlock)
								), SurfaceRules.state(underwaterBlock)
							)
						),
						SurfaceRules.ifTrue(SurfaceRules.stoneDepthCheck(0, true, 0, CaveSurface.FLOOR),
							SurfaceRules.state(undergroundBlock)
						)
					)
				)
			);
		}
	</#if>

	<#if spawn_nether?has_content || spawn_caves?has_content>
		private static SurfaceRules.RuleSource anySurfaceRule(ResourceKey<Biome> biomeKey, BlockState groundBlock, BlockState undergroundBlock, BlockState underwaterBlock) {
			return SurfaceRules.ifTrue(SurfaceRules.isBiome(biomeKey),
				SurfaceRules.sequence(
					SurfaceRules.ifTrue(SurfaceRules.stoneDepthCheck(0, false, 0, CaveSurface.FLOOR),
						SurfaceRules.sequence(
							SurfaceRules.ifTrue(SurfaceRules.waterBlockCheck(-1, 0),
								SurfaceRules.state(groundBlock)
							),
							SurfaceRules.state(underwaterBlock)
						)
					),
					SurfaceRules.ifTrue(SurfaceRules.stoneDepthCheck(0, true, 0, CaveSurface.FLOOR),
						SurfaceRules.state(undergroundBlock)
					)
				)
			);
		}
	</#if>
}

</#compress>
<#-- @formatter:on -->
