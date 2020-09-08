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

<#include "procedures.java.ftl">
<#include "mcitems.ftl">

package ${package}.block;

import net.fabricmc.fabric.api.object.builder.v1.block.FabricBlockSettings;
import net.fabricmc.fabric.api.tools.FabricToolTags;
import net.fabricmc.api.EnvType;
import net.fabricmc.api.Environment;
import net.fabricmc.fabric.api.registry.*;
import net.fabricmc.fabric.api.tool.attribute.v1.*;
import ${package}.*;

public class ${name}Block extends <#if data.hasGravity> FallingBlock <#else> Block </#if>{

    <#if data.rotationMode == 1 || data.rotationMode == 3>
		public static final DirectionProperty FACING = HorizontalFacingBlock.FACING;
    <#elseif data.rotationMode == 2 || data.rotationMode == 4 || data.rotationMode == 5>
		public static final DirectionProperty FACING = FacingBlock.FACING;
    </#if>
	
	<#if data.emissiveRendering>
        private static boolean always(BlockState state, BlockView world, BlockPos pos) {
            return true;
        }
    </#if>

    public ${name}Block() {
        super(FabricBlockSettings.of(Material.${data.material})
        <#if data.unbreakable>
                .strength(-1, 3600000)
        <#else>
                .strength(${data.hardness}F, ${data.resistance}F)
        </#if>
                .lightLevel(${(data.luminance * 15)?round})
        <#if data.destroyTool != "Not specified">
			    .breakByTool(FabricToolTags.${data.destroyTool?upper_case}S, ${data.breakHarvestLevel})
        </#if>
        <#if data.isNotColidable>
                .noCollision()
        </#if>
        <#if data.slipperiness != 0.6>
                .slipperiness(${data.slipperiness}F)
        </#if>
        <#if data.hasTransparency || (data.blockBase?has_content && data.blockBase == "Leaves")>
                .nonOpaque()
        </#if>
		<#if data.emissiveRendering>
                .emissiveLighting(${name}Block::always)
        </#if>
        <#if data.tickRandomly>
                .ticksRandomly()
        </#if>
        );

        <#if data.rotationMode == 1 || data.rotationMode == 3>
			this.setDefaultState(this.stateManager.getDefaultState().with(FACING, Direction.NORTH));
        <#elseif data.rotationMode == 2 || data.rotationMode == 4>
			this.setDefaultState(this.stateManager.getDefaultState().with(FACING, Direction.NORTH));
        <#elseif data.rotationMode == 5>
			this.setDefaultState(this.stateManager.getDefaultState().with(FACING, Direction.SOUTH));
        </#if>

        <#if data.flammability != 0 && data.fireSpreadSpeed != 0>
            FlammableBlockRegistry.getDefaultInstance().add(this, ${data.flammability}, ${data.fireSpreadSpeed});
        </#if>
    }

    <#if data.specialInfo?has_content>
		@Override
        @Environment(EnvType.CLIENT)
        public void appendTooltip(ItemStack stack, BlockView world, List<Text> tooltip, TooltipContext options) {
			<#list data.specialInfo as entry>
			tooltip.add(new LiteralText("${JavaConventions.escapeStringForJava(entry)}"));
            </#list>
        }
    </#if>

    <#if data.hasTransparency || data.lightOpacity == 0>
        @Override
        public boolean isTranslucent(BlockState state, BlockView world, BlockPos pos) {
            return true;
        }
    </#if>

    <#if data.connectedSides>
        @Environment(Envtype.CLIENT)
        public boolean isSideInvisible(BlockState state, BlockState adjacentBlockState, Direction side) {
            return adjacentBlockState.getBlock() == this ? true : super.isSideInvisible(state, adjacentBlockState, side);
        }
    </#if>

    <#if data.mx != 0 || data.my != 0 || data.mz != 0 || data.Mx != 1 || data.My != 1 || data.Mz != 1>
		@Override
        public VoxelShape getOutlineShape(BlockState state, BlockView world, BlockPos pos, ShapeContext context) {
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

    <#if data.rotationMode != 0>
		@Override
        public void appendProperties(StateManager.Builder<Block, BlockState> builder) {
            builder.add(FACING);
        }

        <#if data.rotationMode != 5>
			public BlockState rotate(BlockState state, BlockRotation rot) {
                return state.with(FACING, rot.rotate(state.get(FACING)));
            }

   			public BlockState mirror(BlockState state, BlockMirror mirror) {
                return state.rotate(mirror.getRotation(state.get(FACING)));
            }
        <#else>
			@Override
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

		@Override
        public BlockState getPlacementState(ItemPlacementContext context) {
			<#if data.rotationMode == 1>
			return this.getDefaultState().with(FACING, context.getPlayerFacing().getOpposite());
            <#elseif data.rotationMode == 2>
			return this.getDefaultState().with(FACING, context.getPlayerLookDirection().getOpposite());
            <#elseif data.rotationMode == 3>
			if (context.getFace() == Direction.UP || context.getSide() == Direction.DOWN)
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

    <#if data.isReplaceable>
        @Override
        public boolean canReplace(BlockState state, ItemPlacementContext context) {
            return true;
        }
    </#if>

    <#if data.reactionToPushing != "NORMAL">
		@Override public PistonBehavior getPistonBehavior(BlockState state) {
            return PistonBehavior.${data.reactionToPushing};
        }
    </#if>

    <#if data.creativePickItem?? && !data.creativePickItem.isEmpty()>
        @Environment(EnvType.CLIENT)
        public ItemStack getPickStack(BlockView world, BlockPos pos, BlockState state) {
            return new ItemStack(${mappedMCItemToItemStackCode(data.creativePickItem, 1)});
        }
    </#if>

    <#if generator.map(data.colorOnMap, "mapcolors") != "DEFAULT">
		@Override
        public MaterialColor getDefaultMaterialColor() {
            return MaterialColor.${generator.map(data.colorOnMap, "mapcolors")};
        }
    </#if>

    <#if data.offsetType != "NONE">
		@Override
        public AbstractBlock.OffsetType getOffsetType() {
            return AbstractBlock.OffsetType.${data.offsetType};
        }
    </#if>

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

    <#if (hasProcedure(data.onBlockAdded)) >
		@Override
        public void onBlockAdded(BlockState state, World world, BlockPos pos, BlockState oldState, boolean notify) {
            super.onBlockAdded(state, world, pos, oldState, moving);
            int x = pos.getX();
            int y = pos.getY();
            int z = pos.getZ();

			<@procedureOBJToCode data.onBlockAdded/>
        }
    </#if>

    <#if hasProcedure(data.onRedstoneOn) || hasProcedure(data.onRedstoneOff) || hasProcedure(data.onNeighbourBlockChanges)>
		@Override
        public void neighborUpdate(World world, BlockPos pos, Block block, BlockPos posFrom, boolean notify) {
            super.neighborUpdate(world, pos, neighborBlock, posFrom, notify);
            int x = pos.getX();
            int y = pos.getY();
            int z = pos.getZ();
            if (world.getReceivedRedstonePower(new BlockPos(x, y, z)) > 0) {
				<@procedureOBJToCode data.onRedstoneOn/>
            } else {
				<@procedureOBJToCode data.onRedstoneOff/>
            }
			<@procedureOBJToCode data.onNeighbourBlockChanges/>
        }
    </#if>

    <#if hasProcedure(data.onDestroyedByPlayer)>
		@Override
        public void onBreak(World world, BlockPos pos, BlockState state, PlayerEntity player) {
            int x = pos.getX();
            int y = pos.getY();
            int z = pos.getZ();
			<@procedureOBJToCode data.onDestroyedByPlayer/>
        }
    </#if>

    <#if hasProcedure(data.onDestroyedByExplosion)>
		@Override
        public void onDestroyedByExplosion(World world, BlockPos pos, Explosion explosion) {
            super.onDestroyedByExplosion(world, pos, e);
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

    <#if hasProcedure(data.onEntityWalksOn)>
		@Override
        public void onSteppedOn(World world, BlockPos pos, Entity entity) {
            super.onSteppedOn(world, pos, entity);
            int x = pos.getX();
            int y = pos.getY();
            int z = pos.getZ();
			<@procedureOBJToCode data.onEntityWalksOn/>
        }
    </#if>
}

<#-- @formatter:on -->
