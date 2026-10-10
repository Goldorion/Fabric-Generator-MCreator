<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2012-2020, Pylo
 # Copyright (C) 2020-2026, Pylo, opensource contributors
 # Copyright (C) 2020-2026, Goldorion, opensource contributors
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

/*
 *	MCreator note: This file will be REGENERATED on each build.
 */

package ${package}.init;

import com.mojang.datafixers.util.Pair;

<#assign spawn_overworld = biomes?filter(biome -> biome.spawnBiome)>
<#assign spawn_overworld_caves = biomes?filter(biome -> biome.spawnInCaves)>
<#assign spawn_nether = biomes?filter(biome -> biome.spawnBiomeNether)>

public class ${JavaModName}Biomes {

	public static final Identifier OVERWORLD_BIOMESOURCE_PRESET_ID = Identifier.withDefaultNamespace("overworld");
	public static final Identifier NETHER_BIOMESOURCE_PRESET_ID = Identifier.withDefaultNamespace("nether");

	private static boolean BOOTSTRAP_VALIDATION_PASSED = false;

	public static void load() {
		<#-- At FMLCommonSetupEvent, bootstrap validation is already done -->
		BOOTSTRAP_VALIDATION_PASSED = true;

		ServerLifecycleEvents.SERVER_STARTING.register((server) -> {
			HolderGetter<MaterialRule> materialRules = server.registryAccess().lookupOrThrow(Registries.MATERIAL_RULE);
			Registry<LevelStem> levelStemTypeRegistry = server.registryAccess().lookupOrThrow(Registries.LEVEL_STEM);
			for (LevelStem levelStem : levelStemTypeRegistry.stream().toList()) {
				Holder<DimensionType> dimensionType = levelStem.type();
				if (dimensionType.is(BuiltinDimensionTypes.NETHER) || dimensionType.is(BuiltinDimensionTypes.OVERWORLD)) {
					if(levelStem.generator() instanceof NoiseBasedChunkGenerator noiseGenerator) {
						if ((Object) noiseGenerator.generatorSettings().value() instanceof ${JavaModName}NoiseGeneratorSettings settings) {
							settings.set${modid}References(dimensionType, materialRules);
						} else {
							${JavaModName}.LOGGER.error("NoiseGeneratorSettings mixin of ${modid} was not applied, custom biomes may not generate properly");
						}
					}
				}
			}
		});
	}

	public static MaterialRule adaptMaterialRule(MaterialRule currentRuleSource, Holder<DimensionType> dimensionType, HolderGetter<MaterialRule> materialRules) {
		List<MaterialRule> customMaterialRules = new ArrayList<>();

		<#if spawn_overworld?has_content || spawn_overworld_caves?has_content>
		if (dimensionType.is(BuiltinDimensionTypes.OVERWORLD)) {
			<#list spawn_overworld_caves as biome>
			customMaterialRules.add(MaterialRules.getRule(materialRules, ResourceKey.create(Registries.MATERIAL_RULE, Identifier.fromNamespaceAndPath("${modid}", "${biome.getModElement().getRegistryName()}_any_surface"))));
			</#list>
			<#list spawn_overworld as biome>
			customMaterialRules.add(MaterialRules.getRule(materialRules, ResourceKey.create(Registries.MATERIAL_RULE, Identifier.fromNamespaceAndPath("${modid}", "${biome.getModElement().getRegistryName()}_surface"))));
			</#list>
		}
		</#if>

		<#if spawn_nether?has_content>
		if (dimensionType.is(BuiltinDimensionTypes.NETHER)) {
			<#list spawn_nether as biome>
			customMaterialRules.add(MaterialRules.getRule(materialRules, ResourceKey.create(Registries.MATERIAL_RULE, Identifier.fromNamespaceAndPath("${modid}", "${biome.getModElement().getRegistryName()}_any_surface"))));
			</#list>
		}
		</#if>

		if (customMaterialRules.isEmpty())
			return currentRuleSource;

		customMaterialRules.add(currentRuleSource);
		return MaterialRules.sequence(customMaterialRules);
	}

	public static <T> Climate.ParameterList<T> adaptPresetParameterList(Identifier idArg, Climate.ParameterList<T> originalList, Function<ResourceKey<Biome>, T> lookup) {
		<#-- Skip adaptation during server bootstrap validation, as custom biomes are not available yet -->
		if (!BOOTSTRAP_VALIDATION_PASSED) return originalList;

		<#if spawn_overworld?has_content || spawn_overworld_caves?has_content>
		if (idArg.equals(OVERWORLD_BIOMESOURCE_PRESET_ID)) return ${JavaModName}Biomes.modifyOverworldParameterPoints(originalList, lookup);
		</#if>

		<#if spawn_nether?has_content>
		if (idArg.equals(NETHER_BIOMESOURCE_PRESET_ID)) return ${JavaModName}Biomes.modifyNetherParameterPoints(originalList, lookup);
		</#if>

		return originalList;
	}

	<#if spawn_overworld?has_content || spawn_overworld_caves?has_content>
	public static <T> Climate.ParameterList<T> modifyOverworldParameterPoints(Climate.ParameterList<T> originalList, Function<ResourceKey<Biome>, T> lookup) {
		List<Pair<Climate.ParameterPoint, T>> parameters = new ArrayList<>(originalList.values());

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
			lookup.apply(ResourceKey.create(Registries.BIOME, Identifier.fromNamespaceAndPath("${modid}", "${biome.getModElement().getRegistryName()}")))
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
			lookup.apply(ResourceKey.create(Registries.BIOME, Identifier.fromNamespaceAndPath("${modid}", "${biome.getModElement().getRegistryName()}")))
		));
		</#list>

		<#list spawn_overworld_caves as biome>
		parameters.add(new Pair<>(
			new Climate.ParameterPoint(
				Climate.Parameter.span(${biome.genTemperature.min}f, ${biome.genTemperature.max}f),
				Climate.Parameter.span(${biome.genHumidity.min}f, ${biome.genHumidity.max}f),
				Climate.Parameter.span(${biome.genContinentalness.min}f, ${biome.genContinentalness.max}f),
				Climate.Parameter.span(${biome.genErosion.min}f, ${biome.genErosion.max}f),
				Climate.Parameter.span(${biome.genDepth.min}f, ${biome.genDepth.max}f),
				Climate.Parameter.span(${biome.genWeirdness.min}f, ${biome.genWeirdness.max}f),
				0 <#-- offset -->
			),
			lookup.apply(ResourceKey.create(Registries.BIOME, Identifier.fromNamespaceAndPath("${modid}", "${biome.getModElement().getRegistryName()}")))
		));
		</#list>

		return new Climate.ParameterList<>(parameters);
	}
	</#if>

	<#if spawn_nether?has_content>
	public static <T> Climate.ParameterList<T> modifyNetherParameterPoints(Climate.ParameterList<T> originalList, Function<ResourceKey<Biome>, T> lookup) {
		List<Pair<Climate.ParameterPoint, T>> parameters = new ArrayList<>(originalList.values());

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
			lookup.apply(ResourceKey.create(Registries.BIOME, Identifier.fromNamespaceAndPath("${modid}", "${biome.getModElement().getRegistryName()}")))
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
			lookup.apply(ResourceKey.create(Registries.BIOME, Identifier.fromNamespaceAndPath("${modid}", "${biome.getModElement().getRegistryName()}")))
		));
		</#list>

		return new Climate.ParameterList<>(parameters);
	}
	</#if>

	public interface ${JavaModName}NoiseGeneratorSettings {
		void set${modid}References(Holder<DimensionType> dimensionType, HolderGetter<MaterialRule> materialRules);
	}

}

<#-- @formatter:on -->