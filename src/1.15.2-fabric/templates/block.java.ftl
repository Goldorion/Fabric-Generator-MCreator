<#-- @formatter:off -->
<#include "mcitems.ftl">

package ${package}.block;

import net.minecraft.block.material.Material;

public class ${name}Block extends Block {

	public ${name}Block (){
		super(new FabricBlockSettings.of(Material.${data.material}).
		<#if data.destroyTool != "Not Specified">
		breakByTool(FabricToolTags. ${data.destroyTool?upper_case})
		</#if>
		.sounds(BlocSoundGroup.${data.soundOnStep})
		.strength($data.hardness}, ${data.resistance}f)
		.build());
	}

    @Environment(EnvType.CLIENT)
    public BlockRenderLayer getRenderLayer() {
	<#if data.transparencyType == "CUTOUT">
        return BlockRenderLayer.CUTOUT;
	<#elseif data.transparencyType == "CUTOUT_MIPPED">
        return BlockRenderLayer.CUTOUT_MIPPED;
	<#elseif data.transparencyType == "TRANSLUCENT">
        return BlockRenderLayer.TRANSLUCENT;
	<#else>
        return BlockRenderLayer.SOLID;
</#if>
    }

<#if (data.spawnWorldTypes?size > 0)>
private void handleBiome(Biome biome) {
    				<#list data.spawnWorldTypes as worldType>
						<#if worldType=="Surface">
							if(biome.getCategory() == Biome.Category.OVERWORLD) {
						</#if>
						<#if worldType=="Nether">
							if(biome.getCategory() == Biome.Category.NETHER) {
						</#if>
						<#if worldType=="End">
							if(biome.getCategory() == Biome.Category.THEEND) {
						</#if>
					</#list>
		biome.addFeature(
        	    GenerationStep.Feature.UNDERGROUND_ORES,
        	    Feature.ORE.configure(
			new OreFeatureConfig(
			    OreFeatureConfig.Target.
					<#list data.blocksToReplace as replacementBlock>
					${mappedBlockToBlockStateCode(replacementBlock)}.getDefaultState(),
					</#list>
			    ${data.frequencyOnChunk}
		   )).createDecoratedFeature(
			Decorator.COUNT_RANGE.configure(new RangeDecoratorConfig(
			    ${data.frequencyPerChunks,
			    0, //Bottom Offset
			    ${data.minGenerateHeight},
			    ${data.minGenerateHeight}
		))));
    				<#list data.spawnWorldTypes as worldType>
						<#if worldType=="End">
					}
						</#if>
						<#if worldType=="Nether">
				}
						</#if>
						<#if worldType=="Surface">
			}
						</#if>
					</#list>
		}
	} </#if>
}

<#-- @formatter:on -->