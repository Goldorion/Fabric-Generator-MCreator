<#--
This file is part of MCreatorFabricGenerator.

MCreatorFabricGenerator is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

MCreatorFabricGenerator is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with MCreatorFabricGenerator.  If not, see <https://www.gnu.org/licenses/>.
-->

<#-- @formatter:off -->
<#include "mcitems.ftl">

package ${package}.world;

import net.fabricmc.fabric.api.biome.v1.*;

public class ${name}Biome {
    private static Biome theBiome;
    private static final ConfiguredSurfaceBuilder<TernarySurfaceConfig> SURFACE_BUILDER = SurfaceBuilder.DEFAULT.method_30478(new TernarySurfaceConfig(${mappedBlockToBlockStateCode(data.groundBlock)}, ${mappedBlockToBlockStateCode(data.undergroundBlock)}, ${mappedBlockToBlockStateCode(data.undergroundBlock)}));
    public static final RegistryKey<Biome> BIOME_KEY = RegistryKey.of(Registry.BIOME_KEY, new Identifier("${modid}", "${registryname}"));

    public static void init() {
        Registry.register(BuiltinRegistries.CONFIGURED_SURFACE_BUILDER, BIOME_KEY.getValue(), SURFACE_BUILDER);
        BiomeEffects.Builder effectsBuilder = new BiomeEffects.Builder();
        <#if data.waterColor?has_content>
            effectsBuilder.waterColor(${data.waterColor.getRGB()});
				<#else>
				    effectsBuilder.waterColor(4159204);
				</#if>
				<#if data.waterFogColor?has_content>
				effectsBuilder.waterFogColor(${data.waterFogColor.getRGB()});
				<#else>
				effectsBuilder.waterFogColor(329011);
				</#if>
        <#if data.airColor?has_content>
            effectsBuilder.skyColor(${data.airColor.getRGB()}).fogColor(${data.airColor.getRGB()});
        <#else>
            effectsBuilder.skyColor(getSkyColor(${data.temperature}F)).fogColor(12638463);
        </#if>
        <#if data.grassColor?has_content>
            effectsBuilder.grassColor(${data.grassColor.getRGB()}).foliageColor(${data.grassColor.getRGB()});
        </#if>

        GenerationSettings.Builder genSettingsBuilder = new GenerationSettings.Builder();
        <#list data.defaultFeatures as defaultFeature>
			DefaultBiomeFeatures.add${generator.map(defaultFeature, "defaultfeatures")}(genSettingsBuilder);
        </#list>

            <#if data.spawnStronghold>
			genSettingsBuilder.structureFeature(ConfiguredStructureFeatures.STRONGHOLD);
			</#if>

			<#if data.spawnMineshaft>
			genSettingsBuilder.structureFeature(ConfiguredStructureFeatures.MINESHAFT);
            </#if>

			<#if data.spawnPillagerOutpost>
			genSettingsBuilder.structureFeature(ConfiguredStructureFeatures.PILLAGER_OUTPOST);
            </#if>

        <#--TODO: Add villages
        -->
<#--			<#if data.villageType != "none">-->
<#--			genSettingsBuilder.structureFeature(ConfiguredStructureFeatures.VILLAGE.withConfiguration(new VillageConfig("village/${data.villageType}/town_centers", 6)));-->
<#--            </#if>-->

			<#if data.spawnWoodlandMansion>
			genSettingsBuilder.structureFeature(ConfiguredStructureFeatures.MANSION);
            </#if>

			<#if data.spawnJungleTemple>
			genSettingsBuilder.structureFeature(ConfiguredStructureFeatures.JUNGLE_PYRAMID);
            </#if>

			<#if data.spawnDesertPyramid>
			genSettingsBuilder.structureFeature(ConfiguredStructureFeatures.DESERT_PYRAMID);
            </#if>

			<#if data.spawnIgloo>
			genSettingsBuilder.structureFeature(ConfiguredStructureFeatures.IGLOO);
            </#if>

			<#if data.spawnOceanMonument>
			genSettingsBuilder.structureFeature(ConfiguredStructureFeatures.MONUMENT);
            </#if>

			<#if data.spawnShipwreck>
			genSettingsBuilder.structureFeature(ConfiguredStructureFeatures.SHIPWRECK);
            </#if>

        <#--TODO: Add ocean ruins
        -->
<#--			<#if data.oceanRuinType != "NONE">-->
<#--			genSettingsBuilder.structureFeature(ConfiguredStructureFeatures.OCEAN_RUIN.withConfiguration(new OceanRuinConfig(OceanRuinStructure.Type.${data.oceanRuinType}, 0.3F, 0.9F)));-->
<#--            </#if>-->

        <#if (data.treesPerChunk > 0)>
            <#if data.treeType == data.TREES_CUSTOM>
				System.err.println("Custom Trees are not supported yet by MCreatorFabricGenerator! Please consider changing the tree type in the biome \"${modid}:${registryname}\"");
            <#elseif data.vanillaTreeType == "Big trees">
				genSettingsBuilder.feature(GenerationStep.Feature.VEGETAL_DECORATION, ConfiguredFeatures.FANCY_OAK);
            <#elseif data.vanillaTreeType == "Savanna trees">
				genSettingsBuilder.feature(GenerationStep.Feature.VEGETAL_DECORATION, ConfiguredFeatures.TREES_SAVANNA);
            <#elseif data.vanillaTreeType == "Mega pine trees">
				genSettingsBuilder.feature(GenerationStep.Feature.VEGETAL_DECORATION, ConfiguredFeatures.TREES_GIANT);
            <#elseif data.vanillaTreeType == "Mega spruce trees">
				genSettingsBuilder.feature(GenerationStep.Feature.VEGETAL_DECORATION, ConfiguredFeatures.TREES_GIANT_SPRUCE);
            <#elseif data.vanillaTreeType == "Birch trees">
				genSettingsBuilder.feature(GenerationStep.Feature.VEGETAL_DECORATION, ConfiguredFeatures.BIRCH);
            <#else>
				genSettingsBuilder.feature(GenerationStep.Feature.VEGETAL_DECORATION, ConfiguredFeatures.PLAIN_VEGETATION);
            </#if>
        </#if>
        genSettingsBuilder.surfaceBuilder(SURFACE_BUILDER);

        SpawnSettings.Builder spawnBuilder = new SpawnSettings.Builder();
        <#list data.spawnEntries as spawnEntry>
            <#assign entity = generator.map(spawnEntry.entity.getUnmappedValue(), "entities", 1)!"null">
            <#if entity != "null">
                <#if !entity.toString().contains(".CustomEntity")>
						spawnBuilder.spawn(${generator.map(spawnEntry.spawnType, "mobspawntypes")}, new SpawnSettings.SpawnEntry(EntityType.${entity}, ${spawnEntry.weight}, ${spawnEntry.minGroup}, ${spawnEntry.maxGroup}));
                <#else>
						spawnBuilder.spawn(${generator.map(spawnEntry.spawnType, "mobspawntypes")}, new SpawnSettings.SpawnEntry((${entity.toString().replace(".CustomEntity", "")}.entity, ${spawnEntry.weight}, ${spawnEntry.minGroup}, ${spawnEntry.maxGroup}));
                </#if>
            </#if>
        </#list>

        Biome.Builder biomeBuilder = new Biome.Builder();
        biomeBuilder.effects(effectsBuilder.build());
        biomeBuilder.generationSettings(genSettingsBuilder.build());
        biomeBuilder.spawnSettings(spawnBuilder.build());
        biomeBuilder.temperatureModifier(Biome.TemperatureModifier.NONE);
        biomeBuilder.temperature(${data.temperature}F);
        biomeBuilder.downfall(${data.rainingPossibility}F);
        biomeBuilder.depth(${data.baseHeight}F);
        biomeBuilder.scale(${data.heightVariation}F);
        biomeBuilder.category(Biome.Category.${data.biomeCategory});
        biomeBuilder.precipitation(Biome.Precipitation.<#if (data.rainingPossibility > 0)><#if (data.temperature > 0.15)>RAIN<#else>SNOW</#if><#else>NONE</#if>);
        theBiome = biomeBuilder.build();
        Registry.register(BuiltinRegistries.BIOME, BIOME_KEY.getValue(), theBiome);
        OverworldBiomes.addContinentalBiome(BIOME_KEY, OverworldClimate.<#if (data.temperature < 0.5)>SNOWY<#elseif (data.temperature > 0.5 && data.temperature < 1.0)>COOL<#elseif (data.temperature > 3)>DRY<#else>TEMPERATE</#if>, ${data.biomeWeight});
    }

    private static int getSkyColor(float temperature) {
        float f = temperature / 3.0F;
        f = MathHelper.clamp(f, -1.0F, 1.0F);
        return MathHelper.hsvToRgb(0.62222224F - f * 0.05F, 0.5F + f * 0.1F, 1.0F);
    }
}
<#-- @formatter:on -->
