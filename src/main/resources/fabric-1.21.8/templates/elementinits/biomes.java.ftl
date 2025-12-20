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

/*
 *	MCreator note: This file will be REGENERATED on each build.
 */

package ${package}.init;

import com.mojang.datafixers.util.Pair;
import com.google.common.base.Suppliers;

<#assign spawn_overworld = biomes?filter(biome -> biome.spawnBiome)>
<#assign spawn_overworld_caves = biomes?filter(biome -> biome.spawnInCaves)>
<#assign spawn_nether = biomes?filter(biome -> biome.spawnBiomeNether)>
<#assign decoratedBiomes = biomes?filter(e -> e.hasVines() || e.hasFruits())>
<#assign spawnableBiomes = biomes?filter(e -> e.spawnBiome || e.spawnInCaves || e.spawnBiomeNether)>


public class ${JavaModName}Biomes {

	<#if decoratedBiomes?has_content>
	public static void load() {
		<#list decoratedBiomes as biome>
			<#assign biomeME = biome.getModElement()>
			<#if biome.hasFruits()>
				register("${biomeME.getRegistryName()}_tree_fruit_decorator", ${biomeME.getName()}FruitDecorator.DECORATOR_TYPE);
			</#if>
			<#if biome.hasVines()>
				register("${biomeME.getRegistryName()}_tree_leave_decorator", ${biomeME.getName()}LeaveDecorator.DECORATOR_TYPE);
				register("${biomeME.getRegistryName()}_tree_trunk_decorator", ${biomeME.getName()}TrunkDecorator.DECORATOR_TYPE);
			</#if>
		</#list>
	}

	private static void register(String registryname, TreeDecoratorType<?> treeDecoratorType) {
		Registry.register(BuiltInRegistries.TREE_DECORATOR_TYPE, ResourceLocation.fromNamespaceAndPath(${JavaModName}.MODID, registryname), treeDecoratorType);
	}
	</#if>

	<#if spawnableBiomes?has_content>
	public static void load(MinecraftServer server) {
		Registry<LevelStem> levelStemTypeRegistry = server.registryAccess().lookupOrThrow(Registries.LEVEL_STEM);
		Registry<Biome> biomeRegistry = server.registryAccess().lookupOrThrow(Registries.BIOME);

		for (LevelStem levelStem : levelStemTypeRegistry.stream().toList()) {
			Holder<DimensionType> dimensionType = levelStem.type();

			<#if spawn_overworld?has_content || spawn_overworld_caves?has_content>
			if (dimensionType.is(BuiltinDimensionTypes.OVERWORLD)) {
				ChunkGenerator chunkGenerator = levelStem.generator();

				// Inject biomes to biome source
				if(chunkGenerator.getBiomeSource() instanceof MultiNoiseBiomeSource noiseSource) {
					List<Pair<Climate.ParameterPoint, Holder<Biome>>> parameters = new ArrayList<>(noiseSource.parameters().values());

					<#list spawn_overworld as biome>
					addParameterPoint(parameters, new Pair<>(
						new Climate.ParameterPoint(
							Climate.Parameter.span(${biome.genTemperature.min}f, ${biome.genTemperature.max}f),
							Climate.Parameter.span(${biome.genHumidity.min}f, ${biome.genHumidity.max}f),
							Climate.Parameter.span(${biome.genContinentalness.min}f, ${biome.genContinentalness.max}f),
							Climate.Parameter.span(${biome.genErosion.min}f, ${biome.genErosion.max}f),
							Climate.Parameter.point(0.0f),
							Climate.Parameter.span(${biome.genWeirdness.min}f, ${biome.genWeirdness.max}f),
							0 <#-- offset -->
						),
						biomeRegistry.getOrThrow(ResourceKey.create(Registries.BIOME, ResourceLocation.fromNamespaceAndPath("${modid}", "${biome.getModElement().getRegistryName()}")))
					));
					addParameterPoint(parameters, new Pair<>(
						new Climate.ParameterPoint(
							Climate.Parameter.span(${biome.genTemperature.min}f, ${biome.genTemperature.max}f),
							Climate.Parameter.span(${biome.genHumidity.min}f, ${biome.genHumidity.max}f),
							Climate.Parameter.span(${biome.genContinentalness.min}f, ${biome.genContinentalness.max}f),
							Climate.Parameter.span(${biome.genErosion.min}f, ${biome.genErosion.max}f),
							Climate.Parameter.point(1.0f),
							Climate.Parameter.span(${biome.genWeirdness.min}f, ${biome.genWeirdness.max}f),
							0 <#-- offset -->
						),
						biomeRegistry.getOrThrow(ResourceKey.create(Registries.BIOME, ResourceLocation.fromNamespaceAndPath("${modid}", "${biome.getModElement().getRegistryName()}")))
					));
					</#list>

					<#list spawn_overworld_caves as biome>
					addParameterPoint(parameters, new Pair<>(
						new Climate.ParameterPoint(
							Climate.Parameter.span(${biome.genTemperature.min}f, ${biome.genTemperature.max}f),
							Climate.Parameter.span(${biome.genHumidity.min}f, ${biome.genHumidity.max}f),
							Climate.Parameter.span(${biome.genContinentalness.min}f, ${biome.genContinentalness.max}f),
							Climate.Parameter.span(${biome.genErosion.min}f, ${biome.genErosion.max}f),
							Climate.Parameter.span(${biome.genDepth.min}f, ${biome.genDepth.max}f),
							Climate.Parameter.span(${biome.genWeirdness.min}f, ${biome.genWeirdness.max}f),
							0 <#-- offset -->
						),
						biomeRegistry.getOrThrow(ResourceKey.create(Registries.BIOME, ResourceLocation.fromNamespaceAndPath("${modid}", "${biome.getModElement().getRegistryName()}")))
					));
					</#list>

					chunkGenerator.biomeSource = MultiNoiseBiomeSource.createFromList(new Climate.ParameterList<>(parameters));
					chunkGenerator.featuresPerStep = Suppliers.memoize(() ->
							FeatureSorter.buildFeaturesPerStep(List.copyOf(chunkGenerator.biomeSource.possibleBiomes()), biome ->
									chunkGenerator.generationSettingsGetter.apply(biome).features(), true));
				}

				if(chunkGenerator instanceof NoiseBasedChunkGenerator noiseGenerator) {
					((${JavaModName}NoiseGeneratorSettings)(Object)noiseGenerator.settings.value()).set${modid}DimensionTypeReference(dimensionType);
				}
			}
			</#if>

			<#if spawn_nether?has_content>
			if (dimensionType.is(BuiltinDimensionTypes.NETHER)) {
				ChunkGenerator chunkGenerator = levelStem.generator();

				// Inject biomes to biome source
				if(chunkGenerator.getBiomeSource() instanceof MultiNoiseBiomeSource noiseSource) {
					List<Pair<Climate.ParameterPoint, Holder<Biome>>> parameters = new ArrayList<>(noiseSource.parameters().values());

					<#list spawn_nether as biome>
					addParameterPoint(parameters, new Pair<>(
						new Climate.ParameterPoint(
							Climate.Parameter.span(${biome.genTemperature.min}f, ${biome.genTemperature.max}f),
							Climate.Parameter.span(${biome.genHumidity.min}f, ${biome.genHumidity.max}f),
							Climate.Parameter.span(${biome.genContinentalness.min}f, ${biome.genContinentalness.max}f),
							Climate.Parameter.span(${biome.genErosion.min}f, ${biome.genErosion.max}f),
							Climate.Parameter.point(0.0f),
							Climate.Parameter.span(${biome.genWeirdness.min}f, ${biome.genWeirdness.max}f),
							0 <#-- offset -->
						),
						biomeRegistry.getOrThrow(ResourceKey.create(Registries.BIOME, ResourceLocation.fromNamespaceAndPath("${modid}", "${biome.getModElement().getRegistryName()}")))
					));
					addParameterPoint(parameters, new Pair<>(
						new Climate.ParameterPoint(
							Climate.Parameter.span(${biome.genTemperature.min}f, ${biome.genTemperature.max}f),
							Climate.Parameter.span(${biome.genHumidity.min}f, ${biome.genHumidity.max}f),
							Climate.Parameter.span(${biome.genContinentalness.min}f, ${biome.genContinentalness.max}f),
							Climate.Parameter.span(${biome.genErosion.min}f, ${biome.genErosion.max}f),
							Climate.Parameter.point(1.0f),
							Climate.Parameter.span(${biome.genWeirdness.min}f, ${biome.genWeirdness.max}f),
							0 <#-- offset -->
						),
						biomeRegistry.getOrThrow(ResourceKey.create(Registries.BIOME, ResourceLocation.fromNamespaceAndPath("${modid}", "${biome.getModElement().getRegistryName()}")))
					));
					</#list>

					chunkGenerator.biomeSource = MultiNoiseBiomeSource.createFromList(new Climate.ParameterList<>(parameters));
					chunkGenerator.featuresPerStep = Suppliers.memoize(() ->
							FeatureSorter.buildFeaturesPerStep(List.copyOf(chunkGenerator.biomeSource.possibleBiomes()), biome ->
									chunkGenerator.generationSettingsGetter.apply(biome).features(), true));
				}

				if(chunkGenerator instanceof NoiseBasedChunkGenerator noiseGenerator) {
					((${JavaModName}NoiseGeneratorSettings)(Object)noiseGenerator.settings.value()).set${modid}DimensionTypeReference(dimensionType);
				}
			}
			</#if>
		}
	}

	public static SurfaceRules.RuleSource adaptSurfaceRule(SurfaceRules.RuleSource currentRuleSource, Holder<DimensionType> dimensionType) {
		<#if spawn_overworld?has_content || spawn_overworld_caves?has_content>
		if (dimensionType.is(BuiltinDimensionTypes.OVERWORLD)) return injectOverworldSurfaceRules(currentRuleSource);
		</#if>

		<#if spawn_nether?has_content>
		if (dimensionType.is(BuiltinDimensionTypes.NETHER)) return injectNetherSurfaceRules(currentRuleSource);
		</#if>

		return currentRuleSource;
	}

	<#if spawn_overworld?has_content || spawn_overworld_caves?has_content>
	private static SurfaceRules.RuleSource injectOverworldSurfaceRules(SurfaceRules.RuleSource currentRuleSource) {
		List<SurfaceRules.RuleSource> customSurfaceRules = new ArrayList<>();

		<#list spawn_overworld_caves as biome>
		customSurfaceRules.add(anySurfaceRule(
			ResourceKey.create(Registries.BIOME, ResourceLocation.fromNamespaceAndPath("${modid}", "${biome.getModElement().getRegistryName()}")),
			${mappedBlockToBlockStateCode(biome.groundBlock)},
			${mappedBlockToBlockStateCode(biome.undergroundBlock)},
			${mappedBlockToBlockStateCode(biome.getUnderwaterBlock())}
		));
		</#list>

		<#list spawn_overworld as biome>
		customSurfaceRules.add(preliminarySurfaceRule(
			ResourceKey.create(Registries.BIOME, ResourceLocation.fromNamespaceAndPath("${modid}", "${biome.getModElement().getRegistryName()}")),
			${mappedBlockToBlockStateCode(biome.groundBlock)},
			${mappedBlockToBlockStateCode(biome.undergroundBlock)},
			${mappedBlockToBlockStateCode(biome.getUnderwaterBlock())}
		));
		</#list>

		if (currentRuleSource instanceof SurfaceRules.SequenceRuleSource sequenceRuleSource) {
			customSurfaceRules.addAll(sequenceRuleSource.sequence());
			return SurfaceRules.sequence(customSurfaceRules.toArray(SurfaceRules.RuleSource[]::new));
		} else {
			customSurfaceRules.add(currentRuleSource);
			return SurfaceRules.sequence(customSurfaceRules.toArray(SurfaceRules.RuleSource[]::new));
		}
	}
	</#if>

	<#if spawn_nether?has_content>
	private static SurfaceRules.RuleSource injectNetherSurfaceRules(SurfaceRules.RuleSource currentRuleSource) {
		List<SurfaceRules.RuleSource> customSurfaceRules = new ArrayList<>();

		<#list spawn_nether as biome>
		customSurfaceRules.add(anySurfaceRule(
			ResourceKey.create(Registries.BIOME, ResourceLocation.fromNamespaceAndPath("${modid}", "${biome.getModElement().getRegistryName()}")),
			${mappedBlockToBlockStateCode(biome.groundBlock)},
			${mappedBlockToBlockStateCode(biome.undergroundBlock)},
			${mappedBlockToBlockStateCode(biome.getUnderwaterBlock())}
		));
		</#list>

		if (currentRuleSource instanceof SurfaceRules.SequenceRuleSource sequenceRuleSource) {
			customSurfaceRules.addAll(sequenceRuleSource.sequence());
			return SurfaceRules.sequence(customSurfaceRules.toArray(SurfaceRules.RuleSource[]::new));
		} else {
			customSurfaceRules.add(currentRuleSource);
			return SurfaceRules.sequence(customSurfaceRules.toArray(SurfaceRules.RuleSource[]::new));
		}
	}
	</#if>

	<#if spawn_overworld?has_content>
	private static SurfaceRules.RuleSource preliminarySurfaceRule(ResourceKey<Biome> biomeKey, BlockState groundBlock, BlockState undergroundBlock, BlockState underwaterBlock) {
		return SurfaceRules.ifTrue(SurfaceRules.isBiome(biomeKey),
			SurfaceRules.ifTrue(SurfaceRules.abovePreliminarySurface(),
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
			)
		);
	}
	</#if>

	<#if spawn_nether?has_content || spawn_overworld_caves?has_content>
	private static SurfaceRules.RuleSource anySurfaceRule(ResourceKey<Biome> biomeKey, BlockState groundBlock, BlockState undergroundBlock, BlockState underwaterBlock) {
		return SurfaceRules.ifTrue(SurfaceRules.isBiome(biomeKey),
			SurfaceRules.ifTrue(SurfaceRules.yBlockCheck(VerticalAnchor.aboveBottom(5), 0),
				SurfaceRules.ifTrue(SurfaceRules.not(SurfaceRules.yBlockCheck(VerticalAnchor.belowTop(5), 0)),
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
				)
			)
		);
	}
	</#if>

	private static void addParameterPoint(List<Pair<Climate.ParameterPoint, Holder<Biome>>> parameters, Pair<Climate.ParameterPoint, Holder<Biome>> point) {
		if (!parameters.contains(point))
			parameters.add(point);
	}

	public interface ${JavaModName}NoiseGeneratorSettings {
		void set${modid}DimensionTypeReference(Holder<DimensionType> dimensionType);
	}
	</#if>
}
<#-- @formatter:on -->