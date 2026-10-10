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

<#macro biomeSelector restrictionBiomes>
	<#assign biomeSelector = "includeByKey">
	<#assign resourceKey = "ResourceKey">
	<#if restrictionBiomes?has_content>
		<#list w.filterBrokenReferences(restrictionBiomes) as restrictionBiome>
			<#if restrictionBiome?contains("#")>
				<#assign biomeSelector = "tag">
				<#assign resourceKey = "TagKey">
				<#break>
			</#if>
		</#list>
		BiomeSelectors.${biomeSelector}(
		<#list w.filterBrokenReferences(restrictionBiomes) as restrictionBiome>
			${resourceKey}.create(Registries.BIOME, Identifier.parse("${restrictionBiome?replace("#", "")}"))<#sep>,
		</#list>
		)
	<#else>
		BiomeSelectors.all()
	</#if>
</#macro>

package ${package}.init;

public class ${JavaModName}Features {

	public static void load() {
        <#list features as feature>
            <#if feature.getModElement().getTypeString() == "feature">
                <#if feature.hasGenerationConditions()>
			registerType("${feature.getModElement().getRegistryName()}", ${feature.getModElement().getName()}Feature.CODEC);
                </#if>
                <#if feature.hasPlacedFeature()>
			addToBiomes("${feature.getModElement().getRegistryName()}", <@biomeSelector feature.restrictionBiomes/>, GenerationStep.Decoration.${generator.map(feature.generationStep, "generationsteps")?upper_case});
                </#if>
            <#elseif feature.getModElement().getTypeString() == "block">
			addToBiomes("${feature.getModElement().getRegistryName()}", ${feature.getModElement().getName()}Block.GENERATE_BIOMES, GenerationStep.Decoration.UNDERGROUND_ORES);
            <#elseif feature.getModElement().getTypeString() == "plant">
			addToBiomes("${feature.getModElement().getRegistryName()}", ${feature.getModElement().getName()}Block.GENERATE_BIOMES, GenerationStep.Decoration.VEGETAL_DECORATION);
            </#if>
        </#list>

		<#if hasStructureFeatureClass>
			registerType("structure_feature", StructureFeature.CODEC);
		</#if>
	}

	private static void addToBiomes(String registryname, Predicate<BiomeSelectionContext> biomes, GenerationStep.Decoration stage) {
	 	BiomeModifications.addFeature(biomes, stage, ResourceKey.create(Registries.PLACED_FEATURE, Identifier.fromNamespaceAndPath(${JavaModName}.MODID, registryname)));
	}

	private static void registerType(String registryname, MapCodec<? extends Feature> codec) {
		Registry.register(BuiltInRegistries.FEATURE_TYPE, Identifier.fromNamespaceAndPath(${JavaModName}.MODID, registryname), codec);
	}
}
<#-- @formatter:on -->