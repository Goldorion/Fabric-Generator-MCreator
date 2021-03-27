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

package ${package}.world.biomes;

public class ${name}Biome {
    private static Biome theBiome;
    private static final ConfiguredSurfaceBuilder<TernarySurfaceConfig> SURFACE_BUILDER = SurfaceBuilder.DEFAULT.withConfig(new TernarySurfaceConfig(${mappedBlockToBlockStateCode(data.groundBlock)}, ${mappedBlockToBlockStateCode(data.undergroundBlock)}, ${mappedBlockToBlockStateCode(data.undergroundBlock)}));
    public static final RegistryKey<Biome> BIOME_KEY = RegistryKey.of(Registry.BIOME_KEY, new Identifier("${modid}", "${registryname}"));

    public static void init() {
        Registry.register(BuiltinRegistries.CONFIGURED_SURFACE_BUILDER, BIOME_KEY.getValue(), SURFACE_BUILDER);
        BiomeEffects effects = new BiomeEffects.Builder()
            .fogColor(${data.airColor?has_content?then(data.airColor.getRGB(), 12638463)})
            .waterColor(${data.waterColor?has_content?then(data.waterColor.getRGB(), 4159204)})
            .waterFogColor(${data.waterFogColor?has_content?then(data.waterFogColor.getRGB(), 329011)})
            .skyColor(${data.airColor?has_content?then(data.airColor.getRGB(), 12638463)})
            .grassColor(${data.grassColor?has_content?then(data.grassColor.getRGB(), 9470285)})
            .foliageColor(${data.foliageColor?has_content?then(data.foliageColor.getRGB(), 10387789)})
            <#if data.ambientSound?has_content && data.ambientSound.getMappedValue()?has_content>
            .loopSound((net.minecraft.sound.SoundEvent) <#if data.ambientSound?contains(modid)>${JavaModName}.${data.ambientSound?remove_beginning(modid + ":")}Event<#else>SoundEvents.${data.ambientSound}</#if>)
            </#if>
            <#if data.moodSound?has_content && data.moodSound.getMappedValue()?has_content>
            .moodSound(new BiomeModdSound((net.minecraft.sound.SoundEvent) <#if data.moodSound?contains(modid)>${JavaModName}.${data.moodSound?remove_beginning(modid + ":")}Event<#else>SoundEvents.${data.moodSound}</#if>, ${data.moodSoundDelay}, 8, 2))
            </#if>
            <#if data.additionsSound?has_content && data.additionsSound.getMappedValue()?has_content>
            .additionsSound(new BiomeAdditionsSound((net.minecraft.sound.SoundEvent) <#if data.additionsSound?contains(modid)>${JavaModName}.${data.additionsSound?remove_beginning(modid + ":")}Event<#else>SoundEvents.${data.additionsSound}</#if>, 0.0111D))
            </#if>
            <#if data.music?has_content && data.music.getMappedValue()?has_content>
            .music(new MusicSound((net.minecraft.sound.SoundEvent) <#if data.music?contains(modid)>${JavaModName}.${data.music?remove_beginning(modid + ":")}Event<#else>SoundEvents.${data.music}</#if>, 12000, 24000, true))
            </#if>
            <#if data.spawnParticles>
            .particleConfig(new BiomeParticleConfig(${data.particleToSpawn}, ${data.particlesProbability / 100}f))
            </#if>
            .build();

        GenerationSettings.Builder genSettingsBuilder = new GenerationSettings.Builder();
		<#if (data.treesPerChunk > 0)>
		    <#assign ct = data.treeType == data.TREES_CUSTOM>
			<#if ct>
			</#if>

			<#if data.vanillaTreeType == "Big trees">
			genSettingsBuilder.feature(GenerationStep.Feature.VEGETAL_DECORATION, Feature.TREE.configure((new TreeFeatureConfig.Builder(
                            new SimpleBlockStateProvider(${ct?then(mappedBlockToBlockStateCode(data.treeStem), "Blocks.JUNGLE_LOG.getDefaultState()")}),
                            new SimpleBlockStateProvider(${ct?then(mappedBlockToBlockStateCode(data.treeBranch), "Blocks.JUNGLE_LEAVES.getDefaultState()")}),
                            new JungleFoliagePlacer(UniformIntDistribution.of(2), UniformIntDistribution.of(0), 2),
                            new MegaJungleTrunkPlacer(${ct?then(data.minHeight, 10)}, 2, 19),
                            new TwoLayersFeatureSize(1, 1, 2)
                    ).build())).decorate(ConfiguredFeatures.Decorators.SQUARE_HEIGHTMAP)
                    .decorate(Decorator.COUNT_EXTRA.configure(new CountExtraDecoratorConfig(${data.treesPerChunk}, 0.1f, 1))));
            <#elseif data.vanillaTreeType == "Savanna trees">
			genSettingsBuilder.feature(GenerationStep.Feature.VEGETAL_DECORATION, Feature.TREE.configure((new TreeFeatureConfig.Builder(
                            new SimpleBlockStateProvider(${ct?then(mappedBlockToBlockStateCode(data.treeStem), "Blocks.ACACIA_LOG.getDefaultState()")}),
                            new SimpleBlockStateProvider(${ct?then(mappedBlockToBlockStateCode(data.treeBranch), "Blocks.ACACIA_LEAVES.getDefaultState()")}),
                            new AcaciaFoliagePlacer(UniformIntDistribution.of(2), UniformIntDistribution.of(0)),
                            new ForkingTrunkPlacer(${ct?then(data.minHeight, 5)}, 2, 2),
                            new TwoLayersFeatureSize(1, 0, 2)
                    ).ignoreVines().build())).decorate(ConfiguredFeatures.Decorators.SQUARE_HEIGHTMAP)
                    .decorate(Decorator.COUNT_EXTRA.configure(new CountExtraDecoratorConfig(${data.treesPerChunk}, 0.1f, 1))));
           <#elseif data.vanillaTreeType == "Mega pine trees">
			genSettingsBuilder.feature(GenerationStep.Feature.VEGETAL_DECORATION, Feature.TREE.configure((new TreeFeatureConfig.Builder(
                            new SimpleBlockStateProvider(${ct?then(mappedBlockToBlockStateCode(data.treeStem), "Blocks.SPRUCE_LOG.getDefaultState()")}),
                            new SimpleBlockStateProvider(${ct?then(mappedBlockToBlockStateCode(data.treeBranch), "Blocks.SPRUCE_LEAVES.getDefaultState()")}),
                            new MegaPineFoliagePlacer(UniformIntDistribution.of(0), UniformIntDistribution.of(0), UniformIntDistribution.of(3, 4)),
                            new GiantTrunkPlacer(${ct?then(data.minHeight, 13)}, 2, 14),
                            new TwoLayersFeatureSize(1, 1, 2)
                    ).build())).decorate(ConfiguredFeatures.Decorators.SQUARE_HEIGHTMAP)
                    .decorate(Decorator.COUNT_EXTRA.configure(new CountExtraDecoratorConfig(${data.treesPerChunk}, 0.1f, 1))));
           <#elseif data.vanillaTreeType == "Mega spruce trees">
			genSettingsBuilder.feature(GenerationStep.Feature.VEGETAL_DECORATION, Feature.TREE.configure((new TreeFeatureConfig.Builder(
                            new SimpleBlockStateProvider(${ct?then(mappedBlockToBlockStateCode(data.treeStem), "Blocks.SPRUCE_LOG.getDefaultState()")}),
                            new SimpleBlockStateProvider(${ct?then(mappedBlockToBlockStateCode(data.treeBranch), "Blocks.SPRUCE_LEAVES.getDefaultState()")}),
                            new MegaPineFoliagePlacer(UniformIntDistribution.of(0), UniformIntDistribution.of(0), UniformIntDistribution.of(13, 4)),
                            new GiantTrunkPlacer(${ct?then(data.minHeight, 13)}, 2, 14),
                            new TwoLayersFeatureSize(1, 1, 2)
                    ).build())).decorate(ConfiguredFeatures.Decorators.SQUARE_HEIGHTMAP)
                    .decorate(Decorator.COUNT_EXTRA.configure(new CountExtraDecoratorConfig(${data.treesPerChunk}, 0.1f, 1))));
           <#elseif data.vanillaTreeType == "Birch trees">
			genSettingsBuilder.feature(GenerationStep.Feature.VEGETAL_DECORATION, Feature.TREE.configure((new TreeFeatureConfig.Builder(
                            new SimpleBlockStateProvider(${ct?then(mappedBlockToBlockStateCode(data.treeStem), "Blocks.BIRCH_LOG.getDefaultState()")}),
                            new SimpleBlockStateProvider(${ct?then(mappedBlockToBlockStateCode(data.treeBranch), "Blocks.BIRCH_LEAVES.getDefaultState()")}),
                            new BlobFoliagePlacer(UniformIntDistribution.of(2), UniformIntDistribution.of(0), 3),
                            new StraightTrunkPlacer(${ct?then(data.minHeight, 5)}, 2, 0),
                            new TwoLayersFeatureSize(1, 0, 1)
                    ).ignoreVines().build())).decorate(ConfiguredFeatures.Decorators.SQUARE_HEIGHTMAP)
                    .decorate(Decorator.COUNT_EXTRA.configure(new CountExtraDecoratorConfig(${data.treesPerChunk}, 0.1f, 1))));
           <#else>
			genSettingsBuilder.feature(GenerationStep.Feature.VEGETAL_DECORATION, Feature.TREE.configure((new TreeFeatureConfig.Builder(
                            new SimpleBlockStateProvider(${ct?then(mappedBlockToBlockStateCode(data.treeStem), "Blocks.OAK_LOG.getDefaultState()")}),
                            new SimpleBlockStateProvider(${ct?then(mappedBlockToBlockStateCode(data.treeBranch), "Blocks.OAK_LEAVES.getDefaultState()")}),
                            new BlobFoliagePlacer(UniformIntDistribution.of(2), UniformIntDistribution.of(0), 3),
                            new StraightTrunkPlacer(${ct?then(data.minHeight, 4)}, 2, 0),
                            new TwoLayersFeatureSize(1, 0, 1)
                    ).ignoreVines().build())).decorate(ConfiguredFeatures.Decorators.SQUARE_HEIGHTMAP)
                    .decorate(Decorator.COUNT_EXTRA.configure(new CountExtraDecoratorConfig(${data.treesPerChunk}, 0.1f, 1))));
		    </#if>
		</#if>

        <#list data.defaultFeatures as defaultFeature>
        <#assign mfeat = generator.map(defaultFeature, "defaultfeatures")>
            <#if mfeat != "null">
        DefaultBiomeFeatures.add${mfeat}(genSettingsBuilder);
            </#if>
        </#list>
        <#if (data.seagrassPerChunk > 0)>
            genSettingsBuilder.feature(GenerationStep.Feature.VEGETAL_DECORATION, ConfiguredFeatures.SEAGRASS_NORMAL);
        </#if>
        <#if (data.flowersPerChunk > 0)>
            DefaultBiomeFeatures.addDefaultFlowers(genSettingsBuilder);
        </#if>
        <#if (data.grassPerChunk > 0)>
            DefaultBiomeFeatures.addDefaultGrass(genSettingsBuilder);
        </#if>
        <#if (data.mushroomsPerChunk > 0)>
      		DefaultBiomeFeatures.addDefaultMushrooms(genSettingsBuilder);
        </#if>
        <#if (data.bigMushroomsChunk > 0)>
			DefaultBiomeFeatures.addMushroomFieldsFeatures(genSettingsBuilder);
        </#if>
        <#if (data.reedsPerChunk > 0)>
			DefaultBiomeFeatures.addDefaultVegetation(genSettingsBuilder);
        <#elseif (data.cactiPerChunk > 0)>
            DefaultBiomeFeatures.addDesertVegetation(genSettingsBuilder);
        </#if>
        <#if (data.sandPatchesPerChunk > 0)>
			genSettingsBuilder.feature(GenerationStep.Feature.UNDERGROUND_ORES, ConfiguredFeatures.DISK_SAND);
        </#if>
        <#if (data.gravelPatchesPerChunk > 0)>
			genSettingsBuilder.feature(GenerationStep.Feature.UNDERGROUND_ORES, ConfiguredFeatures.DISK_GRAVEL);
        </#if>

        <#if data.spawnStronghold>
            genSettingsBuilder.structureFeature(ConfiguredStructureFeatures.STRONGHOLD);
        </#if>

        <#if data.spawnMineshaft>
            genSettingsBuilder.structureFeature(ConfiguredStructureFeatures.MINESHAFT);
        </#if>

        <#if data.spawnPillagerOutpost>
            genSettingsBuilder.structureFeature(ConfiguredStructureFeatures.PILLAGER_OUTPOST);
        </#if>

        <#if data.villageType != "none">
            genSettingsBuilder.structureFeature(ConfiguredStructureFeatures.VILLAGE_${data.villageType?upper_case});
        </#if>

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

        <#if data.oceanRuinType != "NONE">
            genSettingsBuilder.structureFeature(ConfiguredStructureFeatures.OCEAN_RUIN_${data.oceanRuinType});
        </#if>

        <#if (data.treesPerChunk > 0)>
            <#if data.treeType == data.TREES_CUSTOM>
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
        biomeBuilder.effects(effects);
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
        OverworldBiomes.addContinentalBiome(BIOME_KEY, OverworldClimate.${data.biomeType?replace("WARM", "TEMPERATE")?replace("DESERT", "DRY")}, ${data.biomeWeight}d);
    }

    private static int getSkyColor(float temperature) {
        float f = temperature / 3.0F;
        f = MathHelper.clamp(f, -1.0F, 1.0F);
        return MathHelper.hsvToRgb(0.62222224F - f * 0.05F, 0.5F + f * 0.1F, 1.0F);
    }
}
<#-- @formatter:on -->