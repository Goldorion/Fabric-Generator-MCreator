<#-- @formatter:off -->
package ${package}.world.biome;

import net.fabricmc.fabric.api.biomes.v1.OverworldClimate;
import net.fabricmc.api.EnvType;
import net.fabricmc.api.Environment;

public class ${name} extends Biome{

  public static final int WEIGHT = ${data.biomeWeight};

  public ${name}(){
            super(new Biome.Settings().configureSurfaceBuilder(SurfaceBuilder.DEFAULT, SurfaceBuilder.GRASS_CONFIG)
            .precipitation(Biome.Precipitation.<#if (data.rainingPossibility > 0)><#if (data.temperature > 0.15)>RAIN<#else>SNOW</#if><#else>NONE</#if>)
            .category(Biome.Category.PLAINS)
            .depth(${data.baseHeight}f)
            .scale(${data.heightVariation}f)
            .temperature(${data.temperature}f)
            .precipitation(Precipitation.<#if (data.rainingPossibility > 0)><#if (data.temperature > 0.15)>RAIN<#else>SNOW</#if><#else>NONE</#if>)
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
            DefaultBiomeFeatures.addDefaultOres(this);
            DefaultBiomeFeatures.addDefaultDisks(this);
            DefaultBiomeFeatures.addDefaultVegetation(this);
            DefaultBiomeFeatures.addSprings(this);
            DefaultBiomeFeatures.addFrozenTopLayer(this);
            <#if (data.flowersPerChunk > 0)>
            DefaultBiomeFeatures.addDefaultFlowers(this);
            </#if>
            <#if (data.grassPerChunk > 0)>
            DefaultBiomeFeatures.addDefaultGrass(this);
            </#if>
            <#if (data.flowersPerChunk > 0)>
            DefaultBiomeFeatures.addForestFlowers(this);
            </#if>
            <#if data.generateLakes>
            DefaultBiomeFeatures.addDefaultLakes(this);
            </#if>
            <#if (data.mushroomsPerChunk > 0)>
            DefaultBiomeFeatures.addDefaultMushrooms(this);
            </#if>
            <#if (data.treesPerChunk > 0)>
              <#if data.vanillaTreeType == "Big trees">
                DefaultBiomeFeatures.addTallBirchTrees(this);
                DefaultBiomeFeatures.addForestTrees(this);
              <#elseif data.vanillaTreeType == "Savanna trees">
                DefaultBiomeFeatures.addSavannaTrees(this);
              <#elseif data.vanillaTreeType == "Mega pine trees">
                DefaultBiomeFeatures.addGiantTreeTaigaTrees(this);
              <#elseif data.vanillaTreeType == "Mega spruce trees">
                DefaultBiomeFeatures.addGiantSpruceTaigaTrees(this);
              <#elseif data.vanillaTreeType == "Birch trees">
                DefaultBiomeFeatures.addBirchTrees(this);
              <#else>
                DefaultBiomeFeatures.addBirchTrees(this);
                DefaultBiomeFeatures.addForestTrees(this);
              </#if>
            </#if>
            <#if (data.bigMushroomsChunk > 0)>
              DefaultBiomeFeatures.addMushroomFieldsFeatures(this);
            </#if>
            <#if (data.reedsPerChunk > 0)>
              DefaultBiomeFeatures.addBamboo(this);
            </#if>
            <#if (data.cactiPerChunk > 0)>
              DefaultBiomeFeatures.addDesertFeatures(this);
            </#if>

            this.addSpawn(EntityCategory.CREATURE, new Biome.SpawnEntry(EntityType.SHEEP, 12, 4, 4));
            this.addSpawn(EntityCategory.CREATURE, new Biome.SpawnEntry(EntityType.PIG, 10, 4, 4));
            this.addSpawn(EntityCategory.CREATURE, new Biome.SpawnEntry(EntityType.CHICKEN, 10, 4, 4));
            this.addSpawn(EntityCategory.CREATURE, new Biome.SpawnEntry(EntityType.COW, 8, 4, 4));
            this.addSpawn(EntityCategory.AMBIENT, new Biome.SpawnEntry(EntityType.BAT, 10, 8, 8));
            this.addSpawn(EntityCategory.MONSTER, new Biome.SpawnEntry(EntityType.SPIDER, 100, 4, 4));
            this.addSpawn(EntityCategory.MONSTER, new Biome.SpawnEntry(EntityType.ZOMBIE, 95, 4, 4));
            this.addSpawn(EntityCategory.MONSTER, new Biome.SpawnEntry(EntityType.ZOMBIE_VILLAGER, 5, 1, 1));
            this.addSpawn(EntityCategory.MONSTER, new Biome.SpawnEntry(EntityType.SKELETON, 100, 4, 4));
            this.addSpawn(EntityCategory.MONSTER, new Biome.SpawnEntry(EntityType.CREEPER, 100, 4, 4));
            this.addSpawn(EntityCategory.MONSTER, new Biome.SpawnEntry(EntityType.SLIME, 100, 4, 4));
            this.addSpawn(EntityCategory.MONSTER, new Biome.SpawnEntry(EntityType.ENDERMAN, 10, 1, 4));
            this.addSpawn(EntityCategory.MONSTER, new Biome.SpawnEntry(EntityType.WITCH, 5, 1, 1));
  }
  <#if data.customColors>
  @Environment(EnvType.CLIENT)
  @Override
  public int getSkyColor() {
      return ${data.airColor.getRGB()};
  }

  @Environment(EnvType.CLIENT)
  @Override
  public int getGrassColorAt(double x, double z) {
      return ${data.grassColor.getRGB()};
  }

  @Environment(EnvType.CLIENT)
  @Override
  public int getFoliageColor() {
      return ${data.grassColor.getRGB()};
  }
  </#if>
}
<#-- @formatter:on -->
