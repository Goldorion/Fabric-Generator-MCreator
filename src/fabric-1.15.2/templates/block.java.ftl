<#-- @formatter:off -->

package ${package}.block;

import net.fabricmc.fabric.api.tools.FabricToolTags;
import net.fabricmc.fabric.api.object.builder.v1.block.FabricBlockSettings;
import net.fabricmc.api.EnvType;
import net.fabricmc.api.Environment;
import net.minecraft.block.HorizontalFacingBlock;
import net.minecraft.util.math.Direction;

public class ${name} extends
<#if data.hasInventory>BlockWithEntity<#else>
<#if data.hasGravity>FallingBlock<#else>Block</#if>
</#if>
{

	public ${name}(){
		super(FabricBlockSettings.of(Material.${data.material})<#if data.destroyTool != "Not specified">.breakByTool(FabricToolTags.${data.destroyTool?upper_case}S, ${data.breakHarvestLevel})<#else>
.breakByHand(true)
</#if>
<#if data.isNotColidable>
			.noCollision()
</#if>
.sounds(BlockSoundGroup.${data.soundOnStep}).strength(${data.hardness}f, ${data.resistance}f));
	}

		<#if data.rotationMode == 1 || data.rotationMode == 3>
		public static final DirectionProperty FACING = HorizontalFacingBlock.FACING;
		<#elseif data.rotationMode == 2 || data.rotationMode == 4 || data.rotationMode == 5>
		public static final DirectionProperty FACING = FacingBlock.FACING;
		</#if>

    @Override
    public int getLuminance(BlockState state) {
        return ${(data.luminance * 15)?round};
    }

		@Override
    public int getOpacity(BlockState state, BlockView view, BlockPos pos) {
        return ${data.lightOpacity};
    }

		<#if data.rotationMode != 5>
		<#if data.rotationMode != 0>
    public BlockState rotate(BlockState state, BlockRotation rot) {
        return state.with(FACING, rot.rotate(state.get(FACING)));
    }

		public BlockState mirror(BlockState state, BlockMirror mirrorIn) {
        return state.rotate(mirrorIn.getRotation(state.get(FACING)));
    }
		</#if>
		<#else>
		public BlockState rotate(BlockState state, BlockRotation rot) {
			if(rot == BlockRotation.CLOCKWISE_90 || rot == BlockRotation.COUNTERCLOCKWISE_90) {
					if((Direction) state.get(FACING) == Direction.WEST || (Direction) state.get(FACING) == Direction.EAST) {
							return state.with(FACING, Direction.UP);
					} else if((Direction) state.get(FACING) == Direction.UP || (Direction) state.get(FACING) == Direction.DOWN) {
							return state.with(FACING, Direction.WEST);
					}
			}
			return state;
	}
		</#if>


			<#if data.specialInfo?has_content>
			@Environment(EnvType.CLIENT)
			@Override
		   public void buildTooltip(ItemStack stack, BlockView view, List<Text> tooltip, TooltipContext options) {
				<#list data.specialInfo as entry>
					tooltip.add(new LiteralText("${JavaConventions.escapeStringForJava(entry)}"));
					</#list>
		   }
			</#if>


			<#if data.lightOpacity == 0>
			@Override
			public boolean isTranslucent(BlockState state, BlockView view, BlockPos pos) {
					return true;
			}
			</#if>

			<#if data.rotationMode != 0>
	    @Override
	    protected void appendProperties(StateManager.Builder<Block, BlockState> builder) {
	        builder.add(FACING);
	    }
			</#if>

			@Override
    	public int getTickRate(WorldView worldView) {
        	return ${data.tickRate};
    	}

			<#if data.dropAmount != 1 && !(data.customDrop?? && !data.customDrop.isEmpty())>
			@Override
    	public List<ItemStack> getDroppedStacks(BlockState state, LootContext.Builder builder) {
        	List<ItemStack> dropsOriginal = super.getDroppedStacks(state, builder);
        	if(!dropsOriginal.isEmpty())
            	return dropsOriginal;
        	return Collections.singletonList(new ItemStack(this, ${data.dropAmount}));
    	}
			<#else>
			@Override
    	public List<ItemStack> getDroppedStacks(BlockState state, LootContext.Builder builder) {
					List<ItemStack> dropsOriginal = super.getDroppedStacks(state, builder);
					if(!dropsOriginal.isEmpty())return dropsOriginal;
					return Collections.singletonList(new ItemStack(this, 1));
    	}
			</#if>


			<#if data.rotationMode != 0>
    @Override
    public BlockState getPlacementState(ItemPlacementContext context) {
			<#if data.rotationMode == 1>
        return this.getDefaultState().with(FACING, context.getPlayerFacing().getOpposite());
			<#elseif data.rotationMode == 2>
        return this.getDefaultState().with(FACING, context.getPlayerLookDirection().getOpposite());
            <#elseif data.rotationMode == 3>
        if (context.getSide() == Direction.UP || context.getSide() == Direction.DOWN)
            return this.getDefaultState().with(FACING, Direction.NORTH);
        return this.getDefaultState().with(FACING, context.getSide());
            <#elseif data.rotationMode == 4>
        return this.getDefaultState().with(FACING, context.getSide());
			<#elseif data.rotationMode == 5>
                Direction facing = context.getSide();
        if (facing == Direction.WEST || facing == Direction.EAST)
            facing = Direction.UP;
        else if (facing == Direction.NORTH || facing == Direction.SOUTH)
            facing = Direction.EAST;
        else
            facing = Direction.SOUTH;
        return this.getDefaultState().with(FACING, facing);
			</#if>
    }
		</#if>

		<#if data.mx != 0 || data.my != 0 || data.mz != 0 || data.Mx != 1 || data.My != 1 || data.Mz != 1>
@Override public VoxelShape getOutlineShape(BlockState state, BlockView view, BlockPos pos, EntityContext context) {
	<#if data.rotationMode == 1 || data.rotationMode == 3>
						switch ((Direction) state.get(FACING)) {
								case UP:
								case DOWN:
								case SOUTH:
								default:
										return VoxelShapes.cuboid(${1-data.mx}D, ${data.my}D, ${1-data.mz}D, ${1-data.Mx}D, ${data.My}D,
												${1-data.Mz}D);
								case NORTH:
										return VoxelShapes.cuboid(${data.mx}D, ${data.my}D, ${data.mz}D, ${data.Mx}D, ${data.My}D, ${data.Mz}D);
								case WEST:
										return VoxelShapes.cuboid(${data.mz}D, ${data.my}D, ${1-data.mx}D, ${data.Mz}D, ${data.My}D,
												${1-data.Mx}D);
								case EAST:
										return VoxelShapes.cuboid(${1-data.mz}D, ${data.my}D, ${data.mx}D, ${1-data.Mz}D, ${data.My}D,
												${data.Mx}D);
						}
						<#elseif data.rotationMode == 2 || data.rotationMode == 4>
						switch ((Direction) state.get(FACING)) {
								case SOUTH:
								default:
										return VoxelShapes.cuboid(${1-data.mx}D, ${data.my}D, ${1-data.mz}D, ${1-data.Mx}D, ${data.My}D,
												${1-data.Mz}D);
								case NORTH:
										return VoxelShapes.cuboid(${data.mx}D, ${data.my}D, ${data.mz}D, ${data.Mx}D, ${data.My}D, ${data.Mz}D);
								case WEST:
										return VoxelShapes.cuboid(${data.mz}D, ${data.my}D, ${1-data.mx}D, ${data.Mz}D, ${data.My}D,
												${1-data.Mx}D);
								case EAST:
										return VoxelShapes.cuboid(${1-data.mz}D, ${data.my}D, ${data.mx}D, ${1-data.Mz}D, ${data.My}D,
												${data.Mx}D);
								case UP:
										return VoxelShapes.cuboid(${data.mx}D, ${1-data.mz}D, ${data.my}D, ${data.Mx}D, ${1-data.Mz}D,
												${data.My}D);
								case DOWN:
										return VoxelShapes.cuboid(${data.mx}D, ${data.mz}D, ${1-data.my}D, ${data.Mx}D, ${data.Mz}D,
												${1-data.My}D);
						}
						<#elseif data.rotationMode == 5>
						switch ((Direction) state.get(FACING)) {
								case SOUTH:
								case NORTH:
								default:
										return VoxelShapes.cuboid(${data.mx}D, ${data.my}D, ${data.mz}D, ${data.Mx}D, ${data.My}D, ${data.Mz}D);
								case EAST:
								case WEST:
										return VoxelShapes.cuboid(${data.mx}D, ${1-data.mz}D, ${data.my}D, ${data.Mx}D, ${1-data.Mz}D,
												${data.My}D);
								case UP:
								case DOWN:
										return VoxelShapes.cuboid(${data.my}D, ${1-data.mx}D, ${1-data.mz}D, ${data.My}D, ${1-data.Mx}D,
												${1-data.Mz}D);
						}
						<#else>
		return VoxelShapes.cuboid(${data.mx}D, ${data.my}D, ${data.mz}D, ${data.Mx}D, ${data.My}D, ${data.Mz}D);
				</#if>
}
		</#if>

		<#if data.hasTransparency>
		@Override
    public boolean isSimpleFullBlock(BlockState state, BlockView view, BlockPos pos) {
        return false;
    }
		</#if>

		<#if data.connectedSides>
		@Environment(EnvType.CLIENT)
    @Override
    public boolean isSideInvisible(BlockState state, BlockState neighbor, Direction facing) {
        return true;
    }
		</#if>

		public void genBlock(Biome biome){
			<#list data.spawnWorldTypes as worldType>
			<#if worldType=="Surface">
			try{
				<#if (data.spawnWorldTypes?size > 0)>
				if(biome.getCategory() != Biome.Category.THEEND
				<#if data.restrictionBiomes?has_content>
					<#list data.restrictionBiomes as restrictionBiome>
					  && biome != Registry.BIOME.get(new Identifier("${restrictionBiome}"))
					</#list>
				</#if>
			){
					biome.addFeature(
									GenerationStep
									.Feature
									.UNDERGROUND_ORES,Feature
									.ORE
									.configure(
													new OreFeatureConfig(OreFeatureConfig
																	.Target
																	.NATURAL_STONE,
																	${JavaModName}
																	.${name}
																	.getDefaultState(),
																	${data.frequencyOnChunk}
													)).createDecoratedFeature(Decorator
													.COUNT_RANGE.
													configure(new RangeDecoratorConfig(
																	${data.frequencyPerChunks},
																	${data.minGenerateHeight},
																	${data.minGenerateHeight},
																	${data.maxGenerateHeight}
													))));
			}</#if>
		}catch(Throwable ignored){}
		</#if>

		<#if worldType == "Nether">
			try{
			<#if (data.spawnWorldTypes?size > 0)>
		if(biome.getCategory() != Biome.Category.THEEND
			<#if data.restrictionBiomes?has_content>
				<#list data.restrictionBiomes as restrictionBiome>
					&& biome != Registry.BIOME.get(new Identifier("${restrictionBiome}"))
				</#list>
			</#if>
		){
				biome.addFeature(
								GenerationStep
								.Feature
								.UNDERGROUND_ORES,Feature
								.ORE
								.configure(
												new OreFeatureConfig(OreFeatureConfig
																.Target
																.NETHERRACK,
																${JavaModName}
																.${name}
																.getDefaultState(),
																${data.frequencyOnChunk}
												)).createDecoratedFeature(Decorator
												.COUNT_RANGE.
												configure(new RangeDecoratorConfig(
																${data.frequencyPerChunks},
																${data.minGenerateHeight},
																${data.minGenerateHeight},
																${data.maxGenerateHeight}
												))));
											}</#if>
			}catch(Throwable ignored){}
			</#if>

			</#list>
			}

			@Override
	    public BlockRenderType getRenderType(BlockState state) {
	        return BlockRenderType.MODEL;
	    }

		public static boolean hasBE = <#if data.hasInventory>true<#else>false</#if>;

		<#if data.hasInventory>
		@Override
    public BlockEntity createBlockEntity(BlockView view) {
        return new ${name}BlockEntity();
    }
		</#if>
		public static class ${name}BlockEntity extends BlockEntity{
        public ${name}BlockEntity() {
            super(${JavaModName}.${name}BE);
        }
    }


}


<#-- @formatter:on -->
