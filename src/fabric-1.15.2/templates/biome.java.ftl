<#-- @formatter:off -->
package ${package}.world.biome;

public class ${name}Biome extends Biome{

  public static void initialize(){
    OverworldBiomes.addContinentalBiome(OverworldClimate.${data.biomeType}, ${JavaModName.${name}Biome, 2D);
  }

  public ${name}Biome(){
            super(new Biome.Settings().configureSurfaceBuilder(SurfaceBuilder.DEFAULT, SurfaceBuilder.GRASS_CONFIG)
            .precipitation(Biome.Precipitation.<#if (data.rainingPossibility > 0)><#if (data.temperature > 0.15)>RAIN<#else>SNOW</#if><#else>NONE</#if>)
            .category(Biome.Category.PLAINS)
            .depth(${data.baseHeight}f)
            .scale(${data.heightVariation}f)
            .temperature(${data.temperature}f)
            .downfall(${data.rainingPossibility}f)
            <#if data.customColors>
            .waterColor(${data.waterColor.getRGB()}).waterFogColor(${data.waterColor.getRGB()})
            <#else>
            .waterColor(4159204).waterFogColor(329011)
            </#if>
            <#if data.parent?? && data.parent.getUnmappedValue() != "No parent">
            .parent("${data.parent}")
            <#else>
            .parent((String)null));
            </#if>

            this.addStructureFeature(Feature.MINESHAFT.configure(new MineshaftFeatureConfig(0.004D, MineshaftFeature.Type.NORMAL)));
            this.addStructureFeature(Feature.STRONGHOLD.configure(FeatureConfig.DEFAULT));
            DefaultBiomeFeatures.addLandCarvers(this);
            DefaultBiomeFeatures.addDefaultStructures(this);
            DefaultBiomeFeatures.addDungeons(this);
            DefaultBiomeFeatures.addDefaultFlowers(this);
            DefaultBiomeFeatures.addDefaultOres(this);
            DefaultBiomeFeatures.addDefaultDisks(this);
            DefaultBiomeFeatures.addDefaultVegetation(this);
            DefaultBiomeFeatures.addSprings(this);
            DefaultBiomeFeatures.addFrozenTopLayer(this);
            <#if data.generateLakes>
            DefaultBiomeFeatures.addLakes(this);
            </#if>
            <#if (data.grassPerChunk > 0)>
            .addGrassFeature(Blocks.GRASS.getDefaultState(), ${data.grassPerChunk});
            </#if>

            <#list data.spawnList as entityEntry>
            <#assign entity = generator.map(entityEntry.getUnmappedValue(), "entities", 1)!"null">
            <#if entity != "null">
            this.addSpawn(EntityClassification.CREATURE, new Biome.SpawnListEntry(EntityType.${entity}, 15, 1, 5));
            </#if>
            </#list>
  }
}
<#-- @formatter:on -->
