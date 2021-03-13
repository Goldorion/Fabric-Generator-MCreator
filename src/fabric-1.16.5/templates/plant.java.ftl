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
<#include "procedures.java.ftl">

package ${package}.block;

import net.fabricmc.loader.api.FabricLoader;
import net.fabricmc.api.EnvType;
import net.fabricmc.api.Environment;

public class ${name}FlowerBlock extends <#if data.plantType == "normal">Flower<#elseif data.plantType == "growapable">SugarCane</#if>Block <#if data.hasTileEntity>implements BlockEntityProvider</#if>{
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
        .noCollision()
        <#if data.slipperiness != 0.6>
                .slipperiness(${data.slipperiness}F)
        </#if>
        .nonOpaque()
        <#if data.plantType == "growapable" || data.forceTicking>
                .ticksRandomly()
        </#if>
        );

        <#if data.flammability != 0 && data.fireSpreadSpeed != 0>
            FlammableBlockRegistry.getDefaultInstance().add(this, ${data.flammability}, ${data.fireSpreadSpeed});
        </#if>
    }

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

    <#if data.dropAmount != 1 && !(data.customDrop?? && !data.customDrop.isEmpty())>
		@Override
        public List<ItemStack> getDroppedStacks(BlockState state, LootContext.Builder builder) {
            List<ItemStack> dropsOriginal = super.getDrops(state, builder);
            if(!dropsOriginal.isEmpty()) {
                return dropsOriginal;
            }
            return Collections.singletonList(new ItemStack(this, ${data.dropAmount}));
        }
    <#elseif data.customDrop?? && !data.customDrop.isEmpty()>
		@Override
        public List<ItemStack> getDroppedStacks(BlockState state, LootContext.Builder builder) {
            List<ItemStack> dropsOriginal = super.getDroppedStacks(state, builder);
            if(!dropsOriginal.isEmpty()) {
                return dropsOriginal;
            }
            return Collections.singletonList(new ItemStack(${mappedMCItemToItemStackCode(data.customDrop, data.dropAmount)}));
        }
    <#else>
		@Override
        public List<ItemStack> getDroppedStacks(BlockState state, LootContext.Builder builder){
            List<ItemStack> dropsOriginal = super.getDroppedStacks(state, builder);
            if(!dropsOriginal.isEmpty()) {
                return dropsOriginal;
            }
            return Collections.singletonList(new ItemStack(this, 1));
        }
    </#if>

    <#if hasProcedure(data.onTickUpdate) || data.plantType == "growapable">
		@Override
        public void tick(BlockState state, ServerWorld world, BlockPos pos, Random random) {
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
}

<#-- @formatter:on -->