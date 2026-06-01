<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2012-2020, Pylo
 # Copyright (C) 2020-2025, Pylo, opensource contributors
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

<#assign hasStructureFeatureClass = w.getElementsOfType("feature")?filter(e -> e.getMetadata("has_nbt_structure")??)?size != 0>

package ${package}.init;

public class ${JavaModName}Features {

	public static void load() {
        <#list features as feature>
            <#if feature.getModElement().getTypeString() == "feature">
			register("${feature.getModElement().getRegistryName()}", new ${feature.getModElement().getName()}Feature()<#if feature.hasPlacedFeature()>,
				${feature.getModElement().getName()}Feature.GENERATE_BIOMES, GenerationStep.Decoration.${generator.map(feature.generationStep, "generationsteps")?upper_case}</#if>);
            <#elseif feature.getModElement().getTypeString() == "block">
			register("${feature.getModElement().getRegistryName()}", new OreFeature(OreConfiguration.CODEC),
				${feature.getModElement().getName()}Block.GENERATE_BIOMES, GenerationStep.Decoration.UNDERGROUND_ORES);
            <#elseif feature.getModElement().getTypeString() == "plant">
			register("${feature.getModElement().getRegistryName()}", new VegetationPatchFeature(VegetationPatchConfiguration.CODEC),
				${feature.getModElement().getName()}Block.GENERATE_BIOMES, GenerationStep.Decoration.VEGETAL_DECORATION);
            </#if>
        </#list>

		<#if hasStructureFeatureClass>
			register("structure_feature", new StructureFeature(StructureFeatureConfiguration.CODEC));
		</#if>
	}

	private static void register(String registryname, Feature feature, Predicate<BiomeSelectionContext> biomes, GenerationStep.Decoration stage) {
		register(registryname, feature);
	 	BiomeModifications.addFeature(biomes, stage, ResourceKey.create(Registries.PLACED_FEATURE, Identifier.fromNamespaceAndPath(${JavaModName}.MODID, registryname)));
	}

	private static void register(String registryname, Feature feature) {
		Registry.register(BuiltInRegistries.FEATURE, Identifier.fromNamespaceAndPath(${JavaModName}.MODID, registryname), feature);
	}
}
<#-- @formatter:on -->