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

<#include "../mcitems.ftl">

<#assign spawn_overworld = []>
<#assign spawn_overworld_caves = []>
<#assign spawn_nether = []>

<#list biomes as biome>
	<#if biome.spawnBiome>
		<#assign spawn_overworld += [biome]>
	</#if>
	<#if biome.spawnInCaves>
		<#assign spawn_overworld_caves += [biome]>
	</#if>
	<#if biome.spawnBiomeNether>
		<#assign spawn_nether += [biome]>
	</#if>
</#list>

package ${package}.init;

import com.mojang.datafixers.util.Pair;

public class ${JavaModName}Biomes {

	<#list biomes as biome>
		public static ResourceKey<Biome> ${biome.getModElement().getRegistryNameUpper()} = ResourceKey.create(Registries.BIOME,
			new ResourceLocation(${JavaModName}.MODID, "${biome.getModElement().getRegistryName()}"));
	</#list>

	public static void loadEndBiomes() {
		<#list biomes as me>
			<#assign biome = me.getModElement().getGeneratableElement()>
			<#list generator.sortByMappings(biome.defaultFeatures, "defaultfeatures") as defaultFeature>
				<#if generator.map(defaultFeature, "defaultfeatures") = "EndHighlandsBiome">
					TheEndBiomes.addHighlandsBiome(${me.getModElement().getRegistryNameUpper()}, 10);
				<#elseif generator.map(defaultFeature, "defaultfeatures") = "EndIslandsBiome">
					TheEndBiomes.addSmallIslandsBiome(${me.getModElement().getRegistryNameUpper()}, 10);
				</#if>
			</#list>
		</#list>
	}

	public static void load(MinecraftServer server) {
		Registry<DimensionType> dimensionTypeRegistry = server.registryAccess().registryOrThrow(Registries.DIMENSION_TYPE);
		Registry<LevelStem> levelStemTypeRegistry = server.registryAccess().registryOrThrow(Registries.LEVEL_STEM);
		Registry<Biome> biomeRegistry = server.registryAccess().registryOrThrow(Registries.BIOME);

		for (LevelStem levelStem : levelStemTypeRegistry.stream().toList()) {
			DimensionType dimensionType = levelStem.type().value();

			<#if spawn_overworld?has_content || spawn_overworld_caves?has_content>
			if(dimensionType == dimensionTypeRegistry.getOrThrow(BuiltinDimensionTypes.OVERWORLD)) {
				ChunkGenerator chunkGenerator = levelStem.generator();

				// Inject biomes to biome source
				if(chunkGenerator.getBiomeSource() instanceof MultiNoiseBiomeSource noiseSource) {
					List<Pair<Climate.ParameterPoint, Holder<Biome>>> parameters = new ArrayList<>(noiseSource.parameters().values());

					<#list spawn_overworld as biome>
					parameters.add(new Pair<>(
						new Climate.ParameterPoint(
							Climate.Parameter.span(${biome.genTemperature.min}f, ${biome.genTemperature.max}f),
							Climate.Parameter.span(${biome.genHumidity.min}f, ${biome.genHumidity.max}f),
							Climate.Parameter.span(${biome.genContinentalness.min}f, ${biome.genContinentalness.max}f),
							Climate.Parameter.span(${biome.genErosion.min}f, ${biome.genErosion.max}f),
							Climate.Parameter.point(0.0f),
							Climate.Parameter.span(${biome.genWeirdness.min}f, ${biome.genWeirdness.max}f),
							0 <#-- offset -->
						),
						biomeRegistry.getHolderOrThrow(ResourceKey.create(Registries.BIOME, new ResourceLocation("${modid}", "${biome.getModElement().getRegistryName()}")))
					));
					parameters.add(new Pair<>(
						new Climate.ParameterPoint(
							Climate.Parameter.span(${biome.genTemperature.min}f, ${biome.genTemperature.max}f),
							Climate.Parameter.span(${biome.genHumidity.min}f, ${biome.genHumidity.max}f),
							Climate.Parameter.span(${biome.genContinentalness.min}f, ${biome.genContinentalness.max}f),
							Climate.Parameter.span(${biome.genErosion.min}f, ${biome.genErosion.max}f),
							Climate.Parameter.point(1.0f),
							Climate.Parameter.span(${biome.genWeirdness.min}f, ${biome.genWeirdness.max}f),
							0 <#-- offset -->
						),
						biomeRegistry.getHolderOrThrow(ResourceKey.create(Registries.BIOME, new ResourceLocation("${modid}", "${biome.getModElement().getRegistryName()}")))
					));
					</#list>

					<#list spawn_overworld_caves as biome>
					parameters.add(new Pair<>(
						new Climate.ParameterPoint(
							Climate.Parameter.span(${biome.genTemperature.min}f, ${biome.genTemperature.max}f),
							Climate.Parameter.span(${biome.genHumidity.min}f, ${biome.genHumidity.max}f),
							Climate.Parameter.span(${biome.genContinentalness.min}f, ${biome.genContinentalness.max}f),
							Climate.Parameter.span(${biome.genErosion.min}f, ${biome.genErosion.max}f),
							Climate.Parameter.span(0.2f, 0.9f),
							Climate.Parameter.span(${biome.genWeirdness.min}f, ${biome.genWeirdness.max}f),
							0 <#-- offset -->
						),
						biomeRegistry.getHolderOrThrow(ResourceKey.create(Registries.BIOME, new ResourceLocation("${modid}", "${biome.getModElement().getRegistryName()}")))
					));
					</#list>

					chunkGenerator.biomeSource = MultiNoiseBiomeSource.createFromList(new Climate.ParameterList<>(parameters));
					chunkGenerator.featuresPerStep = Suppliers.memoize(() ->
							FeatureSorter.buildFeaturesPerStep(List.copyOf(chunkGenerator.biomeSource.possibleBiomes()), biome ->
									chunkGenerator.generationSettingsGetter.apply(biome).features(), true));
				}
				
				// Inject surface rules
				if(chunkGenerator instanceof NoiseBasedChunkGenerator noiseGenerator) {
					NoiseGeneratorSettings noiseGeneratorSettings = noiseGenerator.settings.value();
					((NoiseGeneratorSettingsAccess)(Object)noiseGeneratorSettings).addSurfaceRules(SurfaceRules.sequence(
						${JavaModName}SurfaceRules.makeOverworldRules(), noiseGeneratorSettings.surfaceRule()));
				}
			}
			</#if>
			
			<#if spawn_nether?has_content>
			if(dimensionType == dimensionTypeRegistry.getOrThrow(BuiltinDimensionTypes.NETHER)) {
				ChunkGenerator chunkGenerator = levelStem.generator();

				// Inject biomes to biome source
				if(chunkGenerator.getBiomeSource() instanceof MultiNoiseBiomeSource noiseSource) {
					List<Pair<Climate.ParameterPoint, Holder<Biome>>> parameters = new ArrayList<>(noiseSource.parameters().values());

					<#list spawn_nether as biome>
					parameters.add(new Pair<>(
						new Climate.ParameterPoint(
							Climate.Parameter.span(${biome.genTemperature.min}f, ${biome.genTemperature.max}f),
							Climate.Parameter.span(${biome.genHumidity.min}f, ${biome.genHumidity.max}f),
							Climate.Parameter.span(${biome.genContinentalness.min}f, ${biome.genContinentalness.max}f),
							Climate.Parameter.span(${biome.genErosion.min}f, ${biome.genErosion.max}f),
							Climate.Parameter.point(0.0f),
							Climate.Parameter.span(${biome.genWeirdness.min}f, ${biome.genWeirdness.max}f),
							0 <#-- offset -->
						),
						biomeRegistry.getHolderOrThrow(ResourceKey.create(Registries.BIOME, new ResourceLocation("${modid}", "${biome.getModElement().getRegistryName()}")))
					));
					parameters.add(new Pair<>(
						new Climate.ParameterPoint(
							Climate.Parameter.span(${biome.genTemperature.min}f, ${biome.genTemperature.max}f),
							Climate.Parameter.span(${biome.genHumidity.min}f, ${biome.genHumidity.max}f),
							Climate.Parameter.span(${biome.genContinentalness.min}f, ${biome.genContinentalness.max}f),
							Climate.Parameter.span(${biome.genErosion.min}f, ${biome.genErosion.max}f),
							Climate.Parameter.point(1.0f),
							Climate.Parameter.span(${biome.genWeirdness.min}f, ${biome.genWeirdness.max}f),
							0 <#-- offset -->
						),
						biomeRegistry.getHolderOrThrow(ResourceKey.create(Registries.BIOME, new ResourceLocation("${modid}", "${biome.getModElement().getRegistryName()}")))
					));
					</#list>

					chunkGenerator.biomeSource = MultiNoiseBiomeSource.createFromList(new Climate.ParameterList<>(parameters));
					chunkGenerator.featuresPerStep = Suppliers.memoize(() ->
							FeatureSorter.buildFeaturesPerStep(List.copyOf(chunkGenerator.biomeSource.possibleBiomes()), biome ->
									chunkGenerator.generationSettingsGetter.apply(biome).features(), true));
				}

				// Inject surface rules
				if(chunkGenerator instanceof NoiseBasedChunkGenerator noiseGenerator) {
					NoiseGeneratorSettings noiseGeneratorSettings = noiseGenerator.settings.value();
					((NoiseGeneratorSettingsAccess)(Object)noiseGeneratorSettings).addSurfaceRules(SurfaceRules.sequence(
						${JavaModName}SurfaceRules.makeNetherRules(), noiseGeneratorSettings.surfaceRule()));
				}
			}
			</#if>
		}
	}

}

<#-- @formatter:on -->