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

/*
 *	MCreator note: This file will be REGENERATED on each build.
 */

<#assign hasStructureFeatureClass = w.getElementsOfType("feature")?filter(e -> e.getMetadata("has_nbt_structure")??)?size != 0>

package ${package}.init;

public class ${JavaModName}Features {

	public static void load() {
		<#list w.getGElementsOfType("feature") as feature>
			register("${feature.getModElement().getRegistryName()}", new ${feature.getModElement().getName()}Feature()<#if feature.hasPlacedFeature()>,
				${feature.getModElement().getName()}Feature.GENERATE_BIOMES, GenerationStep.Decoration.${generator.map(feature.generationStep, "generationsteps")?upper_case}</#if>);
		</#list>

		<#list w.getGElementsOfType("block")?filter(e -> e.generateFeature) as feature>
			register("${feature.getModElement().getRegistryName()}", new OreFeature(OreConfiguration.CODEC),
				${feature.getModElement().getName()}Block.GENERATE_BIOMES, GenerationStep.Decoration.UNDERGROUND_ORES);

		</#list>

		<#list w.getGElementsOfType("plant")?filter(e -> e.generateFeature) as feature>
			register("${feature.getModElement().getRegistryName()}", new RandomPatchFeature(RandomPatchConfiguration.CODEC),
				${feature.getModElement().getName()}Block.GENERATE_BIOMES, GenerationStep.Decoration.VEGETAL_DECORATION);
		</#list>

		<#if hasStructureFeatureClass>
			register("structure_feature", new StructureFeature(StructureFeatureConfiguration.CODEC));
		</#if>
	}

	private static void register(String registryname, Feature feature, Predicate<BiomeSelectionContext> biomes, GenerationStep.Decoration stage) {
		register(registryname, feature);
	 	BiomeModifications.addFeature(biomes, stage, ResourceKey.create(Registries.PLACED_FEATURE, ResourceLocation.fromNamespaceAndPath(${JavaModName}.MODID, registryname)));
	}

	private static void register(String registryname, Feature feature) {
		Registry.register(BuiltInRegistries.FEATURE, ResourceLocation.fromNamespaceAndPath(${JavaModName}.MODID, registryname), feature);
	}
}
<#-- @formatter:on -->