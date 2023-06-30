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

package ${package}.world.biome.regions;

import com.mojang.datafixers.util.Pair;
import net.minecraft.core.Registry;
import net.minecraft.resources.ResourceKey;
import net.minecraft.resources.ResourceLocation;
import net.minecraft.world.level.biome.Biome;
import net.minecraft.world.level.biome.Climate;
import terrablender.api.ParameterUtils;
import terrablender.api.Region;
import terrablender.api.RegionType;

public class ${name}Region extends Region {

	<#if data.spawnBiome || data.spawnBiomeNether>
		public static final Climate.ParameterPoint PARAMETER_POINTS = new Climate.ParameterPoint(
			Climate.Parameter.span(${data.genTemperature.min}f, ${data.genTemperature.max}f),
			Climate.Parameter.span(${data.genHumidity.min}f, ${data.genHumidity.max}f),
			Climate.Parameter.span(${data.genContinentalness.min}f, ${data.genContinentalness.max}f),
			Climate.Parameter.span(${data.genErosion.min}f, ${data.genErosion.max}f),
			Climate.Parameter.point(0.0f),
			Climate.Parameter.span(${data.genWeirdness.min}f, ${data.genWeirdness.max}f),
			0 <#-- offset -->
		);
	</#if>

	<#if data.spawnInCaves>
		public static final Climate.ParameterPoint UNDERGROUND_PARAMETER_POINTS = new Climate.ParameterPoint(
				Climate.Parameter.span(${data.genTemperature.min}f, ${data.genTemperature.max}f),
				Climate.Parameter.span(${data.genHumidity.min}f, ${data.genHumidity.max}f),
				Climate.Parameter.span(${data.genContinentalness.min}f, ${data.genContinentalness.max}f),
				Climate.Parameter.span(${data.genErosion.min}f, ${data.genErosion.max}f),
				Climate.Parameter.span(0.2f, 0.9f),
				Climate.Parameter.span(${data.genWeirdness.min}f, ${data.genWeirdness.max}f),
				0 <#-- offset -->
			)
		);
	</#if>

	public ${name}Region(ResourceLocation name) {
		super(name, <#if data.spawnBiome || data.spawnInCaves>RegionType.OVERWORLD<#elseif data.spawnBiomeNether>RegionType.NETHER</#if>, 2);
	}
	
	@Override
	public void addBiomes(Registry<Biome> registry, Consumer<Pair<Climate.ParameterPoint, ResourceKey<Biome>>> mapper) {
		<#if data.spawnBiome || data.spawnBiomeNether>
			this.addBiome(mapper, PARAMETER_POINTS, ${JavaModName}Biomes.${data.getModElement().getRegistryNameUpper()});
		<#elseif data.spawnInCaves>
			this.addBiome(mapper, UNDERGROUND_PARAMETER_POINTS, ${JavaModName}Biomes.${data.getModElement().getRegistryNameUpper()});
		</#if>
	}

}
<#-- @formatter:on -->