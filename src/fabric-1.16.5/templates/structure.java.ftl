<#--
This file is part of Fabric-Generator-MCreator.

Fabric-Generator-MCreator is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Fabric-Generator-MCreator is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with Fabric-Generator-MCreator.  If not, see <https://www.gnu.org/licenses/>.
-->

<#-- @formatter:off -->

<#include "procedures.java.ftl">
<#include "mcitems.ftl">

package ${package}.world.gen.feature;

public class ${name}Structure {
    private static final Feature<DefaultFeatureConfig> feature = new Feature<DefaultFeatureConfig>(DefaultFeatureConfig.CODEC) {
        @Override
        public boolean generate(StructureWorldAccess worldAccess, ChunkGenerator chunkGenerator, Random random, BlockPos pos, DefaultFeatureConfig config) {
            ServerWorld world = worldAccess.toServerWorld();
            int ci = (pos.getX() >> 4) << 4;
            int ck = (pos.getZ() >> 4) << 4;
            
            RegistryKey<World> dimensionType = world.getRegistryKey();
            boolean dimensionCriteria = false;
            <#list data.spawnWorldTypes as worldType>
                <#if worldType=="Surface">
            		if(dimensionType == World.OVERWORLD)
            			dimensionCriteria = true;
            	<#elseif worldType=="Nether">
            		if(dimensionType == World.NETHER)
            			dimensionCriteria = true;
            	<#elseif worldType=="End">
            		if(dimensionType == World.END)
            			dimensionCriteria = true;
            	<#else>
            		if(dimensionType == RegistryKey.of(Registry.WORLD_KEY,
            		        new Identifier("${generator.getResourceLocationForModElement(worldType.toString().replace("CUSTOM:", ""))}")))
            			dimensionCriteria = true;
                </#if>
            </#list>
            
            if (!dimensionCriteria)
                return false;
            if ((random.nextInt(1000000) + 1) <= ${data.spawnProbability}) {
            	int count = random.nextInt(${data.maxCountPerChunk - data.minCountPerChunk + 1}) + ${data.minCountPerChunk};
            	for(int a = 0; a < count; a++) {
            		int i = ci + random.nextInt(16);
            		int k = ck + random.nextInt(16);
            		int j = worldAccess.getTopY(Heightmap.Type.<#if data.surfaceDetectionType=="First block">WORLD_SURFACE_WG<#elseif data.surfaceDetectionType=="First motion blocking block">OCEAN_FLOOR_WG</#if>, i, k);
            
            		<#if data.spawnLocation=="Ground">
            			j -= 1;
            		<#elseif data.spawnLocation=="Air">
            			j += random.nextInt(50) + 16;
            		<#elseif data.spawnLocation=="Underground">
            			j = Math.abs(random.nextInt(Math.max(1, j)) - 24);
            		</#if>
            
            		<#if data.restrictionBlocks?has_content>
            			BlockState blockAt = world.getBlockState(new BlockPos(i, j, k));
            			boolean blockCriteria = false;
            			<#list data.restrictionBlocks as restrictionBlock>
            				if (blockAt.getBlock() == ${mappedBlockToBlock(restrictionBlock)})
            					blockCriteria = true;
            			</#list>
            			if (!blockCriteria)
            				continue;
            		</#if>
            
            		BlockPos spawnTo = new BlockPos(i + ${data.spawnXOffset}, j + ${data.spawnHeightOffset}, k + ${data.spawnZOffset});
            
            		int x = spawnTo.getX();
            		int y = spawnTo.getY();
            		int z = spawnTo.getZ();
            
            		<#if hasProcedure(data.generateCondition)>
            		if (!<@procedureOBJToConditionCode data.generateCondition/>)
            			continue;
            		</#if>
            
                    Structure structure = world.getStructureManager().getStructureOrBlank(new Identifier("${modid}" ,"${data.structure}"));
            		if (structure == null)
            			return false;
            			
                    <#if data.randomlyRotateStructure>
                        BlockRotation rotation = BlockRotation.values()[random.nextInt(3)];
                        BlockMirror mirror = BlockMirror.values()[random.nextInt(2)];
                    <#else>
                        BlockRotation rotation = BlockRotation.NONE;
                        BlockMirror mirror = BlockMirror.NONE;
                    </#if>
                    structure.place(worldAccess, spawnTo,
                    new StructurePlacementData()
                        .setRotation(rotation)
                        .setMirror(mirror)
                        .setRandom(random)
                        .addProcessor(BlockIgnoreStructureProcessor.IGNORE_${data.ignoreBlocks}<#if data.ignoreBlocks?ends_with("BLOCK")>S</#if>)
                        .setChunkPosition(null)
                        .setIgnoreEntities(false), random);
                                            
                    <#if hasProcedure(data.onStructureGenerated)>
                        <@procedureOBJToCode data.onStructureGenerated/>
                    </#if>
            	}
            }
            return true;
        }
    };
    private static final ConfiguredFeature<?, ?> configFeature = feature.configure(DefaultFeatureConfig.DEFAULT).decorate(Decorator.NOPE.configure(DecoratorConfig.DEFAULT));
        
    public static void init() {
        Registry.register(Registry.FEATURE, new Identifier("${modid}", "${registryname}"), feature);
        RegistryKey<ConfiguredFeature<?, ?>> configFeatKey = RegistryKey.of(Registry.CONFIGURED_FEATURE_WORLDGEN,
                        new Identifier("${modid}", "${registryname}"));
                Registry.register(BuiltinRegistries.CONFIGURED_FEATURE, configFeatKey.getValue(), configFeature);
                 
        BiomeModifications.addFeature(BiomeSelectors.
        <#if data.restrictionBiomes?has_content>
            includeByKey(
             <#list data.restrictionBiomes as restrictionBiome>
                <#if restrictionBiome?starts_with(modid)>
                    ${JavaModName}.${restrictionBiome.getUnmappedValue().replace("CUSTOM:", "")}_KEY<#if restrictionBiome?has_next>,</#if>
                <#else>
                    BiomeKeys.${restrictionBiome}<#if restrictionBiome?has_next>,</#if>
                </#if>
             </#list>
             )
            <#else>
            all()
        </#if>, GenerationStep.Feature.<#if data.spawnLocation=="Ground">SURFACE_STRUCTURES
                <#elseif data.spawnLocation=="Air">RAW_GENERATION
                <#elseif data.spawnLocation=="Underground">UNDERGROUND_STRUCTURES</#if>, configFeatKey);
    }
}
<#-- @formatter:on -->