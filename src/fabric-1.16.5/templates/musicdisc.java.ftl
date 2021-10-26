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

package ${package}.item;

public class ${name}MusicDisc extends MusicDiscItem {
    public ${name}MusicDisc() {
			super(0, new SoundEvent(new Identifier("${data.music}")),
                    new FabricItemSettings().group(${data.creativeTab}).maxCount(1).rarity(Rarity.RARE));
    }

    <#if data.hasGlow>
    @Environment(EnvType.CLIENT)
    @Override
    public boolean hasGlint(ItemStack stack) {
        return true;
    }
    </#if>

    <#if data.specialInfo?has_content>
    @Override
    @Environment(EnvType.CLIENT)
    public void appendTooltip(ItemStack stack, World world, List<Text> tooltip, TooltipContext context) {
        <#list data.specialInfo as entry>
            tooltip.add(new LiteralText("${JavaConventions.escapeStringForJava(entry)}"));
        </#list>
    }
    </#if>

    <#if hasProcedure(data.onRightClickedInAir)>
    @Override
    public TypedActionResult<ItemStack> use(World world, PlayerEntity user, Hand hand) {
        ItemStack itemstack = super.use(world, user, hand).getResult();
        int x = (int) entity.getPosX();
        int y = (int) entity.getPosY();
        int z = (int) entity.getPosZ();
            <@procedureOBJToCode data.onRightClickedInAir/>
        return super.use(world, user, hand);
    }
    </#if>

    <#if hasProcedure(data.onRightClickedOnBlock)>
    @Override
    public ActionResult useOnBlock(ItemUsageContext context) {
        ActionResult retval = super.useOnBlock(context);
        World world = context.getWorld();
        BlockPos pos = context.getBlockPos();
        PlayerEntity entity = context.getPlayer();
        Direction direction = context.getSide();
        BlockState state = world.getBlockState(pos);
        int x = pos.getX();
        int y = pos.getY();
        int z = pos.getZ();
        ItemStack itemstack = context.getItem();
		<#if hasReturnValue(data.onRightClickedOnBlock)>
            return <@procedureOBJToActionResultTypeCode data.onRightClickedOnBlock/>;
        <#else>
            <@procedureOBJToCode data.onRightClickedOnBlock/>
            return retval;
        </#if>
    }
    </#if>

    <#if hasProcedure(data.onEntityHitWith)>
    @Override
    public boolean postHit(ItemStack stack, LivingEntity target, LivingEntity attacker) {
        super.postHit(stack, target, attacker);
        int x = (int) target.getPosX();
        int y = (int) target.getPosY();
        int z = (int) target.getPosZ();
        World world = target.world;
			<@procedureOBJToCode data.onEntityHitWith/>
        return true;
    }
    </#if>

    <#if hasProcedure(data.onCrafted)>
    @Override
    public void onCraft(ItemStack stack, World world, PlayerEntity player) {
        super.onCraft(stack, world, player);
        int x = (int) player.getPosX();
        int y = (int) player.getPosY();
        int z = (int) player.getPosZ();
			<@procedureOBJToCode data.onCrafted/>
    }
    </#if>

<#if hasProcedure(data.onItemInUseTick) || hasProcedure(data.onItemInInventoryTick)>
    @Override
    public void inventoryTick(ItemStack stack, World world, Entity entity, int slot, boolean selected) {
        super.inventoryTick(itemstack, world, entity, slot, selected);
        int x = (int) entity.getPosX();
        int y = (int) entity.getPosY();
        int z = (int) entity.getPosZ();
    <#if hasProcedure(data.onItemInUseTick)>
        if (selected)
    </#if>
        <@procedureOBJToCode data.onItemInInventoryTick/>
    }
</#if>

<#if hasProcedure(data.onStoppedUsing)>
    @Override
    public void onStoppedUsing(ItemStack stack, World world, LivingEntity user, int remainingUseTicks) {
        int x = (int) entity.getPosX();
        int y = (int) entity.getPosY();
        int z = (int) entity.getPosZ();
			<@procedureOBJToCode data.onStoppedUsing/>
    }
</#if>

}

<#-- @formatter:on -->
