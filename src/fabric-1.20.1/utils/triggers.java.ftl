<#include "procedures.java.ftl">

<#-- Item-related triggers -->
<#macro addSpecialInformation procedure="" isBlock=false>
	<#if procedure?has_content || hasProcedure(procedure)>
		@Override public void appendHoverText(ItemStack itemstack, <#if isBlock>BlockGetter<#else>Level</#if> world, List<Component> list, TooltipFlag flag) {
		super.appendHoverText(itemstack, world, list, flag);
		<#if hasProcedure(procedure)>
			Entity entity = itemstack.getEntityRepresentation();
			double x = entity != null ? entity.getX() : 0.0;
			double y = entity != null ? entity.getY() : 0.0;
			double z = entity != null ? entity.getZ() : 0.0;
			list.add(Component.literal(<@procedureOBJToStringCode procedure/>));
		<#else>
			<#list procedure.getFixedValue() as entry>
				list.add(Component.literal("${JavaConventions.escapeStringForJava(entry)}"));
			</#list>
		</#if>
		}
	</#if>
</#macro>

<#macro onCrafted procedure="">
<#if hasProcedure(procedure)>
@Override public void onCraftedBy(ItemStack itemstack, Level world, Player entity) {
	super.onCraftedBy(itemstack, world, entity);
	<@procedureCode data.onCrafted, {
		"x": "entity.getX()",
		"y": "entity.getY()",
		"z": "entity.getZ()",
		"world": "world",
		"entity": "entity",
		"itemstack": "itemstack"
	}/>
}
</#if>
</#macro>

<#macro onStoppedUsing procedure="">
<#if hasProcedure(procedure)>
@Override public void releaseUsing(ItemStack itemstack, Level world, LivingEntity entity, int time) {
	<@procedureCode data.onStoppedUsing, {
		"x": "entity.getX()",
		"y": "entity.getY()",
		"z": "entity.getZ()",
		"world": "world",
		"entity": "entity",
		"itemstack": "itemstack",
		"time": "time"
	}/>
}
</#if>
</#macro>

<#macro onEntityHitWith procedure="">
<#if hasProcedure(procedure)>
@Override public boolean hurtEnemy(ItemStack itemstack, LivingEntity entity, LivingEntity sourceentity) {
	boolean retval = super.hurtEnemy(itemstack, entity, sourceentity);
	<@procedureCode procedure, {
		"x": "entity.getX()",
		"y": "entity.getY()",
		"z": "entity.getZ()",
		"world": "entity.level()",
		"entity": "entity",
		"sourceentity": "sourceentity",
		"itemstack": "itemstack"
	}/>
	return retval;
}
</#if>
</#macro>

<#macro onRightClickedInAir procedure="">
<#if hasProcedure(procedure)>
@Override public InteractionResultHolder<ItemStack> use(Level world, Player entity, InteractionHand hand) {
	InteractionResultHolder<ItemStack> ar = super.use(world, entity, hand);
	<@procedureCode procedure, {
		"x": "entity.getX()",
		"y": "entity.getY()",
		"z": "entity.getZ()",
		"world": "world",
		"entity": "entity",
		"itemstack": "ar.getObject()"
	}/>
	return ar;
}
</#if>
</#macro>

<#macro onItemTick inUseProcedure="" inInvProcedure="">
<#if hasProcedure(inUseProcedure) || hasProcedure(inInvProcedure)>
@Override public void inventoryTick(ItemStack itemstack, Level world, Entity entity, int slot, boolean selected) {
	super.inventoryTick(itemstack, world, entity, slot, selected);
	<#if hasProcedure(inUseProcedure)>
	if (selected)
		<@procedureCode inUseProcedure, {
			"x": "entity.getX()",
			"y": "entity.getY()",
			"z": "entity.getZ()",
			"world": "world",
			"entity": "entity",
			"itemstack": "itemstack",
			"slot": "slot"
		}/>
	</#if>
	<#if hasProcedure(inInvProcedure)>
		<@procedureCode inInvProcedure, {
			"x": "entity.getX()",
			"y": "entity.getY()",
			"z": "entity.getZ()",
			"world": "world",
			"entity": "entity",
			"itemstack": "itemstack",
			"slot": "slot"
		}/>
	</#if>
}
</#if>
</#macro>

<#macro onDroppedByPlayer procedure="">
<#if hasProcedure(procedure)>
@Override public boolean onDroppedByPlayer(ItemStack itemstack, Player entity) {
	<@procedureCode procedure, {
		"x": "entity.getX()",
		"y": "entity.getY()",
		"z": "entity.getZ()",
		"world": "entity.level()",
		"entity": "entity",
		"itemstack": "itemstack"
	}/>
	return true;
}
</#if>
</#macro>

<#macro onItemUsedOnBlock procedure="">
<#if hasProcedure(procedure)>
@Override public InteractionResult useOn(UseOnContext context) {
	InteractionResult retval = super.useOn(context);
	<@procedureCodeWithOptResult procedure, "actionresulttype", "retval", {
		"world": "context.getLevel()",
		"x": "context.getClickedPos().getX()",
		"y": "context.getClickedPos().getY()",
		"z": "context.getClickedPos().getZ()",
		"blockstate": "context.level().getBlockState(context.getClickedPos())",
		"entity": "context.getPlayer()",
		"direction": "context.getClickedFace()",
		"itemstack": "context.getItemInHand()"
	}/>
}
</#if>
</#macro>

<#macro onItemUseFirst procedure="">
<#if hasProcedure(procedure)>
@Override public InteractionResult onItemUseFirst(ItemStack itemstack, UseOnContext context) {
	<@procedureCodeWithOptResult procedure, "actionresulttype", "InteractionResult.PASS", {
		"world": "context.level()",
		"x": "context.getClickedPos().getX()",
		"y": "context.getClickedPos().getY()",
		"z": "context.getClickedPos().getZ()",
		"blockstate": "context.level().getBlockState(context.getClickedPos())",
		"entity": "context.getPlayer()",
		"direction": "context.getClickedFace()",
		"itemstack": "itemstack"
	}/>
}
</#if>
</#macro>

<#macro hasGlow procedure="">
<#if procedure?has_content && (hasProcedure(procedure) || procedure.getFixedValue())>
@Override @net.fabricmc.api.Environment(EnvType.CLIENT) public boolean isFoil(ItemStack itemstack) {
	<#if hasProcedure(procedure)>
		<#assign dependencies = procedure.getDependencies(generator.getWorkspace())>
		<#if !(dependencies.isEmpty() || (dependencies.size() == 1 && dependencies.get(0).getName() == "itemstack"))>
		Entity entity = Minecraft.getInstance().player;
		</#if>
		return <@procedureCode procedure, {
			"x": "entity.getX()",
			"y": "entity.getY()",
			"z": "entity.getZ()",
			"entity": "entity",
			"world": "entity.level()",
			"itemstack": "itemstack"
		}/>
	<#else>
		return true;
	</#if>
}
</#if>
</#macro>

<#-- Armor triggers -->
<#macro onArmorTick procedure="">
<#if hasProcedure(procedure)>
	<@procedureCode procedure, {
		"x": "entity.getX()",
		"y": "entity.getY()",
		"z": "entity.getZ()",
		"world": "world",
		"entity": "entity",
		"itemstack": "itemstack"
	}/>
</#if>
</#macro>

<#-- Block-related triggers -->
<#macro onDestroyedByPlayer procedure="">
<#if hasProcedure(procedure)>
@Override public void playerDestroy(Level world, Player entity, BlockPos pos, BlockState blockstate, BlockEntity blockEntity, ItemStack itemStack) {
	super.playerDestroy(world, entity, pos, blockstate, blockEntity, itemStack);
	<@procedureCode procedure, {
		"x": "pos.getX()",
		"y": "pos.getY()",
		"z": "pos.getZ()",
		"world": "world",
		"entity": "entity",
		"blockstate": "blockstate"
	}/>
}
</#if>
</#macro>

<#macro onDestroyedByExplosion procedure="">
<#if hasProcedure(procedure)>
@Override public void wasExploded(Level world, BlockPos pos, Explosion e) {
	super.wasExploded(world, pos, e);
	<@procedureCode procedure, {
		"x": "pos.getX()",
		"y": "pos.getY()",
		"z": "pos.getZ()",
		"world": "world"
	}/>
}
</#if>
</#macro>

<#macro onEntityCollides procedure="">
<#if hasProcedure(procedure)>
@Override public void entityInside(BlockState blockstate, Level world, BlockPos pos, Entity entity) {
	super.entityInside(blockstate, world, pos, entity);
	<@procedureCode procedure, {
		"x": "pos.getX()",
		"y": "pos.getY()",
		"z": "pos.getZ()",
		"world": "world",
		"entity": "entity",
		"blockstate": "blockstate"
	}/>
}
</#if>
</#macro>

<#macro onBlockAdded procedure="" scheduleTick=false tickRate=0>
<#if scheduleTick || hasProcedure(procedure)>
@Override public void onPlace(BlockState blockstate, Level world, BlockPos pos, BlockState oldState, boolean moving) {
	super.onPlace(blockstate, world, pos, oldState, moving);
	<#if scheduleTick>
		world.scheduleTick(pos, this, ${tickRate});
	</#if>
	<#if hasProcedure(procedure)>
		<@procedureCode procedure, {
			"x": "pos.getX()",
			"y": "pos.getY()",
			"z": "pos.getZ()",
			"world": "world",
			"blockstate": "blockstate",
			"oldState": "oldState",
			"moving": "moving"
		}/>
	</#if>
}
</#if>
</#macro>

<#macro onEntityWalksOn procedure="">
<#if hasProcedure(procedure)>
@Override public void stepOn(Level world, BlockPos pos, BlockState blockstate, Entity entity) {
	super.stepOn(world, pos, blockstate, entity);
	<@procedureCode procedure, {
		"x": "pos.getX()",
		"y": "pos.getY()",
		"z": "pos.getZ()",
		"world": "world",
		"entity": "entity",
		"blockstate": "blockstate"
	}/>
}
</#if>
</#macro>

<#macro onBlockPlacedBy procedure="">
<#if hasProcedure(procedure)>
@Override public void setPlacedBy(Level world, BlockPos pos, BlockState blockstate, LivingEntity entity, ItemStack itemstack) {
	super.setPlacedBy(world, pos, blockstate, entity, itemstack);
	<@procedureCode procedure, {
		"x": "pos.getX()",
		"y": "pos.getY()",
		"z": "pos.getZ()",
		"world": "world",
		"entity": "entity",
		"blockstate": "blockstate",
		"itemstack": "itemstack"
	}/>
}
</#if>
</#macro>

<#macro onStartToDestroy procedure="">
<#if hasProcedure(procedure)>
@Override public void attack(BlockState blockstate, Level world, BlockPos pos, Player entity) {
	super.attack(blockstate, world, pos, entity);
	<@procedureCode procedure, {
		"x": "pos.getX()",
		"y": "pos.getY()",
		"z": "pos.getZ()",
		"world": "world",
		"entity": "entity",
		"blockstate": "blockstate"
	}/>
}
</#if>
</#macro>

<#macro onRedstoneOrNeighborChanged onRedstoneOn="" onRedstoneOff="" onNeighborChanged="">
<#if hasProcedure(onRedstoneOn) || hasProcedure(onRedstoneOff) || hasProcedure(onNeighborChanged)>
@Override public void neighborChanged(BlockState blockstate, Level world, BlockPos pos, Block neighborBlock, BlockPos fromPos, boolean moving) {
	super.neighborChanged(blockstate, world, pos, neighborBlock, fromPos, moving);
	<#if hasProcedure(onRedstoneOn) || hasProcedure(onRedstoneOff)>
		if (world.getBestNeighborSignal(pos) > 0) {
			<#if hasProcedure(onRedstoneOn)>
			<@procedureCode onRedstoneOn, {
				"x": "pos.getX()",
				"y": "pos.getY()",
				"z": "pos.getZ()",
				"world": "world",
				"blockstate": "blockstate"
			}/>
			</#if>
		}
		<#if hasProcedure(onRedstoneOff)> else {
			<@procedureCode onRedstoneOff, {
				"x": "pos.getX()",
				"y": "pos.getY()",
				"z": "pos.getZ()",
				"world": "world",
				"blockstate": "blockstate"
			}/>
		}
		</#if>
	</#if>
	<#if hasProcedure(onNeighborChanged)>
	<@procedureCode onNeighborChanged, {
	   	"x": "pos.getX()",
	   	"y": "pos.getY()",
	   	"z": "pos.getZ()",
	   	"world": "world",
	   	"blockstate": "blockstate"
	}/>
	</#if>
}
</#if>
</#macro>

<#macro onAnimateTick procedure="">
<#if hasProcedure(procedure)>
@Override public void animateTick(BlockState blockstate, Level world, BlockPos pos, RandomSource random) {
	super.animateTick(blockstate, world, pos, random);
	<@procedureCode procedure, {
	   	"x": "pos.getX()",
	   	"y": "pos.getY()",
	   	"z": "pos.getZ()",
	   	"world": "world",
	   	"entity": "Minecraft.getInstance().player",
	   	"blockstate": "blockstate"
	}/>
}
</#if>
</#macro>

<#macro onBlockTick procedure="" scheduleTick=false tickRate=0>
<#if hasProcedure(procedure)>
@Override public void tick(BlockState blockstate, ServerLevel world, BlockPos pos, RandomSource random) {
	super.tick(blockstate, world, pos, random);
	<@procedureCode procedure, {
		"x": "pos.getX()",
		"y": "pos.getY()",
		"z": "pos.getZ()",
		"world": "world",
		"blockstate": "blockstate"
	}/>
	<#if scheduleTick>
		world.scheduleTick(pos, this, ${tickRate});
	</#if>
}
</#if>
</#macro>

<#macro onBlockRightClicked procedure="">
<#if hasProcedure(procedure)>
@Override public InteractionResult use(BlockState blockstate, Level world, BlockPos pos, Player entity, InteractionHand hand, BlockHitResult hit) {
	super.use(blockstate, world, pos, entity, hand, hit);
	<@procedureCodeWithOptResult procedure, "actionresulttype",  "InteractionResult.SUCCESS", {
		"x": "pos.getX()",
		"y": "pos.getY()",
		"z": "pos.getZ()",
		"world": "world",
		"blockstate": "blockstate",
		"entity": "entity",
		"direction": "hit.getDirection()",
		"hitX": "hit.getLocation().x()",
		"hitY": "hit.getLocation().y()",
		"hitZ": "hit.getLocation().z()"
	}/>
}
</#if>
</#macro>

<#macro onHitByProjectile procedure="">
	<#if hasProcedure(procedure)>
		@Override public void onProjectileHit(Level world, BlockState blockstate, BlockHitResult hit, Projectile entity) {
			<@procedureCode procedure, {
			"x": "hit.getBlockPos().getX()",
			"y": "hit.getBlockPos().getY()",
			"z": "hit.getBlockPos().getZ()",
			"world": "world",
			"blockstate": "blockstate",
			"entity": "entity",
			"direction": "hit.getDirection()",
			"hitX": "hit.getLocation().x()",
			"hitY": "hit.getLocation().y()",
			"hitZ": "hit.getLocation().z()"
			}/>
		}
	</#if>
</#macro>

<#macro bonemealEvents isBonemealTargetCondition="" bonemealSuccessCondition="" onBonemealSuccess="">
@Override public boolean isValidBonemealTarget(BlockGetter worldIn, BlockPos pos, BlockState blockstate, boolean clientSide) {
	<#if hasProcedure(isBonemealTargetCondition)>
	if (worldIn instanceof LevelAccessor world) {
		int x = pos.getX();
		int y = pos.getY();
		int z = pos.getZ();
		return <@procedureOBJToConditionCode isBonemealTargetCondition/>;
	}
	return false;
	<#else>
	return true;
	</#if>
}

@Override public boolean isBonemealSuccess(Level world, Random random, BlockPos pos, BlockState blockstate) {
	<#if hasProcedure(bonemealSuccessCondition)>
		int x = pos.getX();
		int y = pos.getY();
		int z = pos.getZ();
		return <@procedureOBJToConditionCode bonemealSuccessCondition/>;
	<#else>
	return true;
	</#if>
}

@Override public void performBonemeal(ServerLevel world, Random random, BlockPos pos, BlockState blockstate) {
	<#if hasProcedure(onBonemealSuccess)>
	<@procedureCode onBonemealSuccess, {
	"x": "pos.getX()",
	"y": "pos.getY()",
	"z": "pos.getZ()",
	"world": "world",
	"blockstate": "blockstate"
	}/>
	</#if>
}
</#macro>