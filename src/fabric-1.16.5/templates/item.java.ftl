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

package ${package}.item;

import com.google.common.collect.*;

public class ${name}Item extends Item {
    public ${name}Item() {
        super(new FabricItemSettings()
            .group(${data.creativeTab})
        <#if data.damageCount != 0>
            .maxDamage(${data.damageCount})
        <#else>.maxCount(${data.stackSize})
        </#if>
	<#if data.immuneToFire>
	    .fireproof()
	</#if>
        .rarity(Rarity.${data.rarity})
        <#if data.recipeRemainder?? && !data.recipeRemainder.isEmpty()>
            .recipeRemainder(${mappedMCItemToItemStackCodeNoItemStackValue(data.recipeRemainder)})
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
    <#if data.enableMeleeDamage>
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
	</#if>

<#if data.hasGlow>
    @Environment(EnvType.CLIENT)
    @Override
    public boolean hasGlint(ItemStack stack) {
    <#if hasProcedure(data.glowCondition)>
        PlayerEntity entity = MinecraftClient.getInstance().player;
        World world = entity.world;
        double x = entity.getPos().getX();
        double y = entity.getPos().getY();
        double z = entity.getPos().getZ();
        if (!(<@procedureOBJToConditionCode data.glowCondition/>)) {
            return false;
         }
    </#if>
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
        int x = (int) player.getPos().getX();
        int y = (int) player.getPos().getY();
        int z = (int) player.getPos().getZ();
			<@procedureOBJToCode data.onCrafted/>
    }
</#if>

<#if hasProcedure(data.onItemInUseTick) || hasProcedure(data.onItemInInventoryTick)>
    @Override
    public void inventoryTick(ItemStack stack, World world, Entity entity, int slot, boolean selected) {
        super.inventoryTick(itemstack, world, entity, slot, selected);
        int x = (int) entity.getPos().getX();
        int y = (int) entity.getPos().getY();
        int z = (int) entity.getPos().getZ();
    <#if hasProcedure(data.onItemInUseTick)>
        if (selected)
    </#if>
        <@procedureOBJToCode data.onItemInInventoryTick/>
    }
</#if>

<#if hasProcedure(data.onStoppedUsing)>
    @Override
    public void onStoppedUsing(ItemStack stack, World world, LivingEntity user, int remainingUseTicks) {
        int x = (int) entity.getPos().getX();
        int y = (int) entity.getPos().getY();
        int z = (int) entity.getPos().getZ();
			<@procedureOBJToCode data.onStoppedUsing/>
    }
</#if>

<#if hasProcedure(data.onEntityHitWith)>
    @Override
    public boolean postHit(ItemStack stack, LivingEntity target, LivingEntity attacker) {
        super.postHit(stack, target, attacker);
        int x = (int) target.getPos().getX();
        int y = (int) target.getPos().getY();
        int z = (int) target.getPos().getZ();
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

<#if hasProcedure(data.onRightClickedInAir)>
    @Override
    public TypedActionResult<ItemStack> use(World world, PlayerEntity entity, Hand hand) {
		TypedActionResult<ItemStack> retval = super.use(world, entity, hand);
		ItemStack itemstack = retval.getValue();
        int x = (int) entity.getPos().getX();
        int y = (int) entity.getPos().getY();
        int z = (int) entity.getPos().getZ();
            <@procedureOBJToCode data.onRightClickedInAir/>
        return super.use(world, entity, hand);
    }
</#if>
}
<#-- @formatter:on -->
