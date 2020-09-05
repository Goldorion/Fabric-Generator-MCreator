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

/*
*    MCreator note:
*
*    If you lock base mod element files, you can edit this file and the proxy files
*    and they won't get overwritten. If you change your mod package or modid, you
*    need to apply these changes to this file MANUALLY.
*
*
*    If you do not lock base mod element files in Workspace settings, this file
*    will be REGENERATED on each build.
*
*/

package ${package}.item;

import net.fabricmc.api.EnvType;
import net.fabricmc.api.Environment;
import com.google.common.collect.*;

public class ${name}Item extends Item {
    public ${name}Item() {
        super(new FabricItemSettings()
            .group(${data.creativeTab})
        <#if data.damageCount != 0>
            .maxDamage(${data.damageCount})
        <#else>.maxCount(${data.stackSize})
        </#if>
        );
    }

    @Override
    public int getMaxUseTime(ItemStack itemstack) {
        return ${data.useDuration};
    }

    @Override
    public float getMiningSpeedMultiplier(ItemStack stack, BlockState state) {
        return (float)(${data.toolType}F);
    }

    @Override
    public Multimap<EntityAttribute, EntityAttributeModifier> getAttributeModifiers(EquipmentSlot slot) {
        if (slot == EquipmentSlot.MAINHAND) {
            return ImmutableMultimap.of(
                    EntityAttributes.GENERIC_ATTACK_DAMAGE,
                    new EntityAttributeModifier(ATTACK_DAMAGE_MODIFIER_ID, "item_damage", (double) ${data.damageVsEntity - 2}, EntityAttributeModifier.Operation.ADDITION),

                    EntityAttributes.GENERIC_ATTACK_SPEED,
                    new EntityAttributeModifier(ATTACK_SPEED_MODIFIER_ID, "item_attack_speed", -2.4, EntityAttributeModifier.Operation.ADDITION)
            );
        }
        return super.getAttributeModifiers(slot);
    }

<#if data.hasGlow>
    @Environment(EnvType.CLIENT)
    @Override
    public boolean hasGlint(ItemStack stack) {
            return true;
    }
</#if>

<#if data.destroyAnyBlock>
    @Override
    public boolean isEffectiveOn(BlockState state) {
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

    @Override
    public int getEnchantability() {
        return ${data.enchantability};
    }

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

<#if hasProcedure(data.onRightClickedOnBlock)>
    @Override
    public ActionResult useOnBlock(ItemUsageContext context) {
        World world = context.getWorld();
        BlockPos pos = context.getBlockPos();
        PlayerEntity entity = context.getPlayer();
        Direction direction = context.getSide();
        int x = pos.getX();
        int y = pos.getY();
        int z = pos.getZ();
        ItemStack itemstack = context.getItem();
			<@procedureOBJToCode data.onRightClickedOnBlock/>
        return ActionResult.PASS;
    }
</#if>

<#if hasProcedure(data.onRightClickedInAir) || (data.guiBoundTo?has_content && data.guiBoundTo != "<NONE>")>
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
}
<#-- @formatter:on -->
