<#-- @formatter:off -->

package ${package}.block;

import net.fabricmc.fabric.api.tools.FabricToolTags;
import net.fabricmc.fabric.api.object.builder.v1.block.FabricBlockSettings;
import net.fabricmc.api.EnvType;
import net.fabricmc.api.Environment;
import net.minecraft.block.HorizontalFacingBlock;
import net.minecraft.util.math.Direction;

public class ${name} extends Block {

	public ${name}(){
		super(FabricBlockSettings.of(Material.${data.material})<#if data.destroyTool != "Not specified">.breakByTool(FabricToolTags.${data.destroyTool?upper_case}S, ${data.breakHarvestLevel})<#else>
.breakByHand(true)
</#if>
.sounds(BlockSoundGroup.${data.soundOnStep}).strength(${data.hardness}f, ${data.resistance}f));
	}
	<#if data.mx != 0 || data.my != 0 || data.mz != 0 || data.Mx != 1 || data.My != 1 || data.Mz != 1>
	@Override
 	public VoxelShape getOutlineShape(BlockState state, BlockView view, BlockPos pos, EntityContext ctx) {
     return VoxelShapes.cuboid(${data.mx}D, ${data.my}D, ${data.mz}D, ${data.Mx}D, ${data.My}D, ${data.Mz}D);
 	}
 	</#if>

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
    public BlockState rotate(BlockState state, BlockRotation rot) {
        return state.with(FACING, rot.rotate(state.get(FACING)));
    }

		public BlockState mirror(BlockState state, BlockMirror mirrorIn) {
        return state.rotate(mirrorIn.getRotation(state.get(FACING)));
    }

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

}

<#-- @formatter:on -->
