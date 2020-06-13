<#-- @formatter:off -->
package ${package}.world.biome;

public class ${name} extends Biome{
  public ${name}(){
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
            <#if (data.grassPerChunk > 0)>
            DefaultBiomeFeatures.addDefaultGrass(this);
            </#if>
  }
}
<#-- @formatter:on -->
