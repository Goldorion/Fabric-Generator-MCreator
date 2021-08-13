<#--
This file is part of Fabric-Generator-MCreator.

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

<#include "boundingboxes.java.ftl">
<#include "mcitems.ftl">
<#include "procedures.java.ftl">

package ${package}.block;

import net.fabricmc.fabric.api.object.builder.v1.block.FabricBlockSettings;
import net.fabricmc.loader.api.FabricLoader;
import net.fabricmc.api.EnvType;
import net.fabricmc.api.Environment;

public class ${name}Block extends <#if data.plantType == "normal">Flower<#elseif data.plantType == "growapable">SugarCane</#if>Block <#if data.hasTileEntity>implements BlockEntityProvider</#if>{
    public ${name}Block() {
        super(<#if data.plantType == "normal">StatusEffects.SATURATION, 0,</#if>
        <#if generator.map(data.colorOnMap, "mapcolors") != "DEFAULT">
        FabricBlockSettings.of(Material.PLANT, MaterialColor.${generator.map(data.colorOnMap, "mapcolors")})
        <#else>
        FabricBlockSettings.of(Material.PLANT)
        </#if>
            .sounds(BlockSoundGroup.${data.soundOnStep})
        <#if data.unbreakable>
            .strength(-1, 3600000)
        <#else>
            .strength(${data.hardness}F, ${data.resistance}F)
        </#if>
            .luminance(${data.luminance})
            .noCollision()
            .nonOpaque()
            .breakInstantly()
        <#if data.speedFactor != 1.0>
            .velocityMultiplier(${data.speedFactor}f)
		</#if>
		<#if data.jumpFactor != 1.0>
		     .jumpVelocityMultiplier(${data.jumpFactor}f)
		</#if>
        <#if data.plantType == "growapable" || data.forceTicking>
            .ticksRandomly()
        </#if>
        );

        <#if data.flammability != 0 && data.fireSpreadSpeed != 0>
            FlammableBlockRegistry.getDefaultInstance().add(this, ${data.flammability}, ${data.fireSpreadSpeed});
        </#if>
    }

    <#if data.boundingBoxes?? && !data.blockBase?? && !data.isFullCube()>
		@Override
        public VoxelShape getOutlineShape(BlockState state, BlockView world, BlockPos pos, ShapeContext context) {
			<#if data.isBoundingBoxEmpty()>
            	return VoxelShapes.empty();
            <#else>
            	<#if !data.disableOffset>Vec3d offset = state.getModelOffset(world, pos);</#if>
                <@makeBoundingBox data.positiveBoundingBoxes() data.negativeBoundingBoxes() data.disableOffset "north"/>
            </#if>
        }
    </#if>

    <#if data.isReplaceable>
    @Override
    public boolean canReplace(BlockState state, ItemPlacementContext context) {
        return true;
    }
    </#if>

    <#if data.offsetType != "XZ">
    @Override
    public AbstractBlock.OffsetType getOffsetType() {
        return Block.OffsetType.${data.offsetType};
    }
    </#if>

    <#if data.emissiveRendering>
    @Override
    @Environment(EnvType.CLIENT)
    public boolean hasEmissiveLighting(BlockView world, BlockPos pos) {
        return true;
    }
    </#if>

    <#if data.specialInfo?has_content>
		@Override
        @Environment(EnvType.CLIENT)
        public void appendTooltip(ItemStack stack, BlockView world, List<Text> tooltip, TooltipContext options) {
			<#list data.specialInfo as entry>
			tooltip.add(new LiteralText("${JavaConventions.escapeStringForJava(entry)}"));
            </#list>
        }
    </#if>

    <#if !data.useLootTableForDrops>
        <#if data.dropAmount != 1 && !(data.customDrop?? && !data.customDrop.isEmpty())>
	    	@Override
            public List<ItemStack> getDroppedStacks(BlockState state, LootContext.Builder builder) {
                List<ItemStack> dropsOriginal = super.getDrops(state, builder);
                if(!dropsOriginal.isEmpty())
                    return dropsOriginal;
                return Collections.singletonList(new ItemStack(this, ${data.dropAmount}));
            }
        <#elseif data.customDrop?? && !data.customDrop.isEmpty()>
	    	@Override
            public List<ItemStack> getDroppedStacks(BlockState state, LootContext.Builder builder) {
                List<ItemStack> dropsOriginal = super.getDroppedStacks(state, builder);
                if(!dropsOriginal.isEmpty())
                    return dropsOriginal;
                return Collections.singletonList(new ItemStack(${mappedMCItemToItemStackCode(data.customDrop, data.dropAmount)}));
         }
        <#elseif data.blockBase?has_content && data.blockBase == "Slab">
	    	@Override
            public List<ItemStack> getDroppedStacks(BlockState state, LootContext.Builder builder) {
                List<ItemStack> dropsOriginal = super.getDroppedStacks(state, builder);
                if(!dropsOriginal.isEmpty())
                    return dropsOriginal;

                return Collections.singletonList(new ItemStack(this, state.get(TYPE) == SlabType.DOUBLE ? 2 : 1));
            }
        <#else>
	    	@Override
            public List<ItemStack> getDroppedStacks(BlockState state, LootContext.Builder builder){
                List<ItemStack> dropsOriginal = super.getDroppedStacks(state, builder);
                if(!dropsOriginal.isEmpty())
                    return dropsOriginal;
                return Collections.singletonList(new ItemStack(this, 1));
            }
        </#if>
    </#if>

    <#if hasProcedure(data.onTickUpdate) || data.plantType == "growapable">
		@Override
        public void randomTick(BlockState state, ServerWorld world, BlockPos pos, Random random) {
			<#if hasProcedure(data.onTickUpdate)>
                int x = pos.getX();
			    int y = pos.getY();
			    int z = pos.getZ();
                <@procedureOBJToCode data.onTickUpdate/>
            </#if>

            <#if data.plantType == "growapable">
			if (!state.canPlaceAt(world, pos)) {
                world.breakBlock(pos, true);
            } else if (world.isAir(pos.up())) {
                int i = 1;
                for(;world.getBlockState(pos.down(i)).getBlock() == this; ++i);
                if (i < ${data.growapableMaxHeight}) {
                    int j = state.get(AGE);
                    if (j == 15) {
                        world.setBlockState(pos.up(), this.getDefaultState());
                        world.setBlockState(pos, state.with(AGE, 0), 4);
                    } else {
                        world.setBlockState(pos, state.with(AGE, j + 1), 4);
                    }
                }
            }
            </#if>
        }
    </#if>

    <#if hasProcedure(data.onRandomUpdateEvent)>
		@Environment(EnvType.CLIENT)
		@Override
		public void randomDisplayTick(BlockState state, World world, BlockPos pos, Random random) {
			super.randomDisplayTick(state, world, pos, random);
			PlayerEntity entity = MinecraftClient.getInstance().player;
			int x = pos.getX();
			int y = pos.getY();
			int z = pos.getZ();
			<@procedureOBJToCode data.onRandomUpdateEvent/>
		}
    </#if>

    <#if hasProcedure(data.onNeighbourBlockChanges)>
		@Override
        public void neighborUpdate(World world, BlockPos pos, Block block, BlockPos posFrom, boolean notify) {
            super.neighborUpdate(world, pos, neighborBlock, posFrom, notify);
            int x = pos.getX();
            int y = pos.getY();
            int z = pos.getZ();
			<@procedureOBJToCode data.onNeighbourBlockChanges/>
        }
    </#if>

    <#if hasProcedure(data.onEntityCollides)>
		@Override
        public void onEntityCollision(BlockState state, World world, BlockPos pos, Entity entity) {
            super.onEntityCollision(state, world, pos, entity);
            int x = pos.getX();
            int y = pos.getY();
            int z = pos.getZ();
			<@procedureOBJToCode data.onEntityCollides/>
        }
    </#if>

    <#if hasProcedure(data.onDestroyedByPlayer)>
		@Override
        public void onBreak(World world, BlockPos pos, BlockState state, PlayerEntity player) {
            int x = pos.getX();
            int y = pos.getY();
            int z = pos.getZ();
            Entity entity = player;
			<@procedureOBJToCode data.onDestroyedByPlayer/>
        }
    </#if>

    <#if hasProcedure(data.onDestroyedByExplosion)>
		@Override
        public void onDestroyedByExplosion(World world, BlockPos pos, Explosion explosion) {
            super.onDestroyedByExplosion(world, pos, explosion);
            int x = pos.getX();
            int y = pos.getY();
            int z = pos.getZ();
			<@procedureOBJToCode data.onDestroyedByExplosion/>
        }
    </#if>

    <#if hasProcedure(data.onStartToDestroy)>
		@Override
        public void onBlockBreakStart(BlockState state, World world, BlockPos pos, PlayerEntity entity) {
            super.onBlockBreakStart(state, world, pos, entity);
            int x = pos.getX();
            int y = pos.getY();
            int z = pos.getZ();
			<@procedureOBJToCode data.onStartToDestroy/>
        }
    </#if>

    <#if hasProcedure(data.onRightClicked)>
		@Override
        public ActionResult onUse(World world, PlayerEntity entity, Hand hand, BlockHitResult hit){
            super.onBlockActivated(state, world, pos, entity, hand, hit);
            int x = pos.getX();
            int y = pos.getY();
            int z = pos.getZ();
            BlockPos pos = hit.getBlockPos();
            BlockState state = world.getBlockState(pos);
            Direction direction = hit.getFace();
			<@procedureOBJToCode data.onRightClicked/>
            return ActionResult.SUCCESS;
        }
    </#if>

    <#if data.hasTileEntity>

        public static final BlockEntityType<CustomBlockEntity> CUSTOM_BLOCK_ENTITY_TYPE = Registry.register(Registry.BLOCK_ENTITY_TYPE, new Identifier("${registryName()}"), BlockEntityType.Builder.create(CustomBlockEntity::new, ${JavaModName}.${name}_BLOCK));;

        public BlockEntity createBlockEntity(BlockView world) {
            return new CustomBlockEntity();
        }

        private static class CustomBlockEntity extends BlockEntity {
            public CustomTileEntity() {
                super(CUSTOM_BLOCK_ENTITY_TYPE);
            }
        }
    </#if>

    <#if (data.spawnWorldTypes?size > 0)>
        public static class Generation {
        private static Block block = ${JavaModName}.${name}_BLOCK;
        public static Feature<RandomPatchFeatureConfig> feature = Registry.register(Registry.FEATURE, new Identifier("${modid}", "${registryname}"),
             <#if data.plantType == "normal">
                <#if data.staticPlantGenerationType == "Flower">
                 new DefaultFlowerFeature(RandomPatchFeatureConfig.CODEC) {
                	@Override public BlockState getFlowerState(Random random, BlockPos bp, RandomPatchFeatureConfig fc) {
                		return block.getDefaultState();
                	}
                <#else>
                 public static Feature<RandomPatchFeatureConfig> feature = new RandomPatchFeature(RandomPatchFeatureConfig.CODEC) {
                </#if>

                @Override public boolean generate(StructureWorldAccess worldAccess, ChunkGenerator generator, Random random, BlockPos pos, RandomPatchFeatureConfig config) {
                	World world = worldAccess.toServerWorld();
                        RegistryKey<World> dimensionType = world.getRegistryKey();
                	boolean dimensionCriteria = false;

                	<#list data.spawnWorldTypes as worldType>
                		<#if worldType=="Surface">
                			if(dimensionType == World.OVERWORLD)
                				dimensionCriteria = true;
                		<#elseif worldType=="Nether">
                			if(dimensionType == World.THE_NETHER)
                				dimensionCriteria = true;
                		<#elseif worldType=="End">
                			if(dimensionType == World.THE_END)
                				dimensionCriteria = true;
                		<#else>
                			if(dimensionType == RegistryKey.of(Registry.DIMENSION, new Identifier("${generator.getResourceLocationForModElement(worldType.toString().replace("CUSTOM:", ""))}")))
                				dimensionCriteria = true;
                		</#if>
                	</#list>

                	if(!dimensionCriteria)
                		return false;

                	<#if hasCondition(data.generateCondition)>
                	int x = pos.getX();
                	int y = pos.getY();
                	int z = pos.getZ();
                	if (!<@procedureOBJToConditionCode data.generateCondition/>)
                		return false;
                	</#if>

                	return super.generate(worldAccess, generator, random, pos, config);
                }
                }
             <#elseif data.plantType == "growapable">
                new Feature<RandomPatchFeatureConfig>(RandomPatchFeatureConfig.CODEC) {
                @Override public boolean generate(StructureWorldAccess worldAccess, ChunkGenerator generator, Random random, BlockPos pos, RandomPatchFeatureConfig config) {
                        World world = worldAccess.toServerWorld();
                        RegistryKey<World> dimensionType = world.getRegistryKey();
                		boolean dimensionCriteria = false;

                		<#list data.spawnWorldTypes as worldType>
                			<#if worldType=="Surface">
                				if(dimensionType == World.OVERWORLD)
                					dimensionCriteria = true;
                			<#elseif worldType=="Nether">
                				if(dimensionType == World.THE_NETHER)
                					dimensionCriteria = true;
                			<#elseif worldType=="End">
                				if(dimensionType == World.THE_END)
                					dimensionCriteria = true;
                			<#else>
                				if(dimensionType == RegistryKey.of(Registry.DIMENSION, new Identifier("${generator.getResourceLocationForModElement(worldType.toString().replace("CUSTOM:", ""))}")))
                					dimensionCriteria = true;
                			</#if>
                		</#list>

                		if(!dimensionCriteria)
                			return false;

                		<#if hasCondition(data.generateCondition)>
                		int x = pos.getX();
                		int y = pos.getY();
                		int z = pos.getZ();
                		if (!<@procedureOBJToConditionCode data.generateCondition/>)
                			return false;
                		</#if>

                		int generated = 0;
                		for(int j = 0; j < ${data.frequencyOnChunks}; ++j) {
                			BlockPos blockpos = pos.add(random.nextInt(4) - random.nextInt(4), 0, random.nextInt(4) - random.nextInt(4));
                			if (world.isAir(blockpos)) {
                				BlockPos blockpos1 = blockpos.down();
                				int k = 1 + random.nextInt(random.nextInt(${data.growapableMaxHeight}) + 1);
                				k = Math.min(${data.growapableMaxHeight}, k);
                				for(int l = 0; l < k; ++l) {
                					if (block.getDefaultState().canPlaceAt(world, blockpos)) {
                						world.setBlockState(blockpos.up(l), block.getDefaultState(), 2);
                						generated++;
                					}
                				}
                			}
                		}
                		return generated > 0;
                	}
                }
             <#elseif data.plantType == "double">
                new RandomPatchFeature(RandomPatchFeatureConfig.CODEC) {
                	@Override public boolean generate(StructureWorldAccess worldAccess, ChunkGenerator generator, Random random, BlockPos pos, RandomPatchFeatureConfig config) {
                        World world = worldAccess.toServerWorld();
                        RegistryKey<World> dimensionType = world.getRegistryKey();
                		boolean dimensionCriteria = false;

                		<#list data.spawnWorldTypes as worldType>
                			<#if worldType=="Surface">
             			        if(dimensionType == World.OVERWORLD)
                					dimensionCriteria = true;
                			<#elseif worldType=="Nether">
             			    	if(dimensionType == World.THE_NETHER)
                					dimensionCriteria = true;
                			<#elseif worldType=="End">
             			    	if(dimensionType == World.THE_END)
                					dimensionCriteria = true;
                			<#else>
                    		    if(dimensionType == RegistryKey.of(Registry.DIMENSION,
                    		            new Identifier("${generator.getResourceLocationForModElement(worldType.toString().replace("CUSTOM:", ""))}")))
                    			    dimensionCriteria = true;
                			</#if>
                		</#list>

                		if(!dimensionCriteria)
                			return false;

                		<#if hasCondition(data.generateCondition)>
             			    int x = pos.getX();
             			    int y = pos.getY();
             			    int z = pos.getZ();
             			    if (!<@procedureOBJToConditionCode data.generateCondition/>)
                				return false;
                		</#if>

                		return super.generate(worldAccess, generator, random, pos, config);
                	}
                }
            </#if>
            );

            private static final ConfiguredFeature<?, ?> CONFIG_FEATURE = feature.configure((
                new RandomPatchFeatureConfig.Builder(new SimpleBlockStateProvider(block.getDefaultState()),
                    new <#if data.plantType == "double">DoublePlantPlacer<#else>SimpleBlockPlacer</#if>())).tries(64)
                        <#if data.plantType == "double" && data.doublePlantGenerationType == "Flower">.cannotProject()</#if>.build())
                        <#if (data.plantType == "normal" && data.staticPlantGenerationType == "Grass") || (data.plantType == "double" && data.doublePlantGenerationType == "Grass")>
                            .decorate(Decorator.COUNT_NOISE.configure(new CountNoiseDecoratorConfig(-0.8, 0, ${data.frequencyOnChunks})))
                        <#else>
                            <#if data.plantType == "normal" || data.plantType == "double">
                        	    .decorate(ConfiguredFeatures.Decorators.SPREAD_32_ABOVE).decorate(ConfiguredFeatures.Decorators.SQUARE_HEIGHTMAP).repeat(${data.frequencyOnChunks})
                        	<#else>
                        		.decorate(ConfiguredFeatures.Decorators.SQUARE_HEIGHTMAP_SPREAD_DOUBLE).repeat(${data.frequencyOnChunks})
                        	</#if>
                        </#if>;

            public static void init() {
                RegistryKey<ConfiguredFeature<?, ?>> configFeatKey = RegistryKey.of(Registry.CONFIGURED_FEATURE_WORLDGEN,
                        new Identifier("${modid}", "${registryname}"));
                Registry.register(BuiltinRegistries.CONFIGURED_FEATURE, configFeatKey.getValue(), CONFIG_FEATURE);
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
                            ),
                        <#else>
                            all(),
                        </#if> GenerationStep.Feature.VEGETAL_DECORATION, configFeatKey);
            }
        }
    </#if>
}

<#-- @formatter:on -->