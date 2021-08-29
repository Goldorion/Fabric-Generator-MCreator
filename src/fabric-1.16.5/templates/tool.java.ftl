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

public class ${name}Tool {
<#if data.toolType == "Pickaxe" || data.toolType == "Axe" || data.toolType == "Sword" || data.toolType == "Spade" || data.toolType == "Hoe">
    public static final ToolMaterial ${name?upper_case}_TOOL_MATERIAL = new ToolMaterial() {
        @Override
        public int getDurability() {
            return ${data.usageCount};
        }

        @Override
        public float getMiningSpeedMultiplier() {
            return ${data.efficiency}F;
        }

        @Override
        public float getAttackDamage() {
            return ${data.damageVsEntity - 2}F;
        }

        @Override
        public int getMiningLevel() {
            return ${data.harvestLevel};
        }

        @Override
        public int getEnchantability() {
            return ${data.enchantability};
        }

        @Override
        public Ingredient getRepairIngredient() {
            <#if data.repairItems?has_content>
					return Ingredient.ofItems(
							<#list data.repairItems as repairItem>
                                ${mappedMCItemToItemStackCodeNoItemStackValue(repairItem)?replace("Blocks.", "Items.")}<#if repairItem?has_next>,</#if>
                            </#list>
                    );
            <#else>
					return Ingredient.EMPTY;
            </#if>
        }
    };

</#if>

<#macro itemProperties>
    protected CustomToolItem() {
        super(new FabricItemSettings()
            .group(${data.creativeTab})
            .maxDamage(${data.usageCount})
            <#if data.immuneToFire>.fireproof()</#if>
            );
    }

    @Override
    public int getEnchantability() {
        return ${data.enchantability};
    }

</#macro>

<#if data.toolType=="Special">
    private static class CustomToolItem extends Item {

        <@itemProperties/>

        @Override
        public float getMiningSpeedMultiplier(ItemStack stack, BlockState state) {
			 <#list data.blocksAffected as restrictionBlock>
                if (blockstate.getBlock() == ${mappedBlockToBlock(restrictionBlock)})
                    return ${data.efficiency}f;
             </#list>
            return 0;
        }

        @Override
        public Multimap<EntityAttribute, EntityAttributeModifier> getAttributeModifiers(EquipmentSlot slot) {
            Multimap<String, EntityAttributeModifier> multimap = super.getAttributeModifiers(slot);
            if (slot == EquipmentSlot.MAINHAND) {
                multimap.put(EntityAttributes.GENERIC_ATTACK_DAMAGE.getTranslationKey(), new EntityAttributeModifier(ATTACK_DAMAGE_MODIFIER_ID, "item_damage", (double) ${data.damageVsEntity - 2}, EntityAttributeModifier.Operation.ADDITION));
                multimap.put(EntityAttributes.GENERIC_ATTACK_SPEED.getTranslationKey(), new EntityAttributeModifier(ATTACK_SPEED_MODIFIER_ID, "item_attack_speed", -2.4, EntityAttributeModifier.Operation.ADDITION));
            }
            return multimap;
        }

        @Override
        public boolean postHit(ItemStack stack, LivingEntity target, LivingEntity attacker) {
            stack.damageItem(2, attacker, i -> i.sendToolBreakStatus(EquipmentSlot.MAINHAND));
            return true;
        }

        @Override
        public boolean postMine(ItemStack stack, World world, BlockState state, BlockPos pos, LivingEntity miner) {
            stack.damageItem(1, miner, i -> i.sendBreakAnimation(EquipmentSlot.MAINHAND));
            return true;
        }
    }
<#elseif data.toolType=="MultiTool">
    private static class CustomToolItem extends Item {
        <@itemProperties/>

        @Override
        public Multimap<EntityAttribute, EntityAttributeModifier> getAttributeModifiers(EquipmentSlot slot) {
            Multimap<String, EntityAttributeModifier> multimap = super.getAttributeModifiers(slot);
            if (slot == EquipmentSlot.MAINHAND) {
                multimap.put(EntityAttributes.GENERIC_ATTACK_DAMAGE.getTranslationKey(), new EntityAttributeModifier(ATTACK_DAMAGE_MODIFIER_ID, "item_damage", (double) ${data.damageVsEntity - 2}, EntityAttributeModifier.Operation.ADDITION));
                multimap.put(EntityAttributes.GENERIC_ATTACK_SPEED.getTranslationKey(), new EntityAttributeModifier(ATTACK_SPEED_MODIFIER_ID, "item_attack_speed", -2.4, EntityAttributeModifier.Operation.ADDITION));
            }
            return multimap;
        }

        @Override
        public boolean canHarvestBlock(BlockState state) {
            return ${data.harvestLevel} >= state.getHarvestLevel();
        }

        @Override
        public float getMiningSpeedMultiplier(ItemStack itemstack, BlockState blockstate) {
            return ${data.efficiency}f;
        }

        @Override
        public boolean postHit(ItemStack stack, LivingEntity target, LivingEntity attacker) {
            stack.damageItem(1, attacker, i -> i.sendEquipmentBreakStatus(EquipmentSlot.MAINHAND));
            return true;
        }

        @Override
        public boolean postMine(ItemStack stack, World world, BlockState state, BlockPos pos, LivingEntity miner) {
            stack.damageItem(1, miner, i -> i.sendBreakAnimation(EquipmentSlot.MAINHAND));
            return true;
        }
    }
<#elseif data.toolType == "Shears">
    private static class CustomToolItem extends ShearsItem {
        <@itemProperties/>

        @Override
        public float getMiningSpeedMultiplier(ItemStack stack, BlockState state) {
            return ${data.efficiency}f;
        }
        }
<#elseif (data.toolType == "Fishing rod")>
    private static class CustomToolItem extends FishingRodItem {
        <@itemProperties/>

		<#if data.repairItems?has_content>
		    @Override
            public boolean canRepair(ItemStack toRepair, ItemStack repair) {
                return
                <#list data.repairItems as repairItem>
                	repair.getItem() == ${mappedMCItemToItem(repairItem)}
                	<#if repairItem?has_next>||</#if>
                </#list>;
            }
        </#if>
	}
</#if>

    public static final Item INSTANCE = new
<#if data.toolType == "Pickaxe" || data.toolType == "Axe" || data.toolType == "Sword" || data.toolType == "Spade" || data.toolType == "Hoe">${data.toolType.toString().replace("Spade", "Shovel")}Item(${name?upper_case}_TOOL_MATERIAL, 0, (float) ${data.attackSpeed - 4}, (new FabricItemSettings().group(${data.creativeTab})<#if data.immuneToFire>.fireproof()</#if>))
<#else>CustomToolItem()</#if>{

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
        public TypedActionResult<ItemStack> use(World world, PlayerEntity entity, Hand hand) {
			TypedActionResult<ItemStack> retval = super.use(world, entity, hand);
			ItemStack itemstack = retval.getValue();
            int x = (int) entity.getX();
            int y = (int) entity.getY();
            int z = (int) entity.getZ();
                <@procedureOBJToCode data.onRightClickedInAir/>
            return super.use(world, entity, hand);
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

	<#if hasProcedure(data.onBlockDestroyedWithTool)>
		@Override
		public boolean postMine(ItemStack itemstack, World world, BlockState blockstate, BlockPos pos, LivingEntity entity){
			boolean retval = super.postMine(itemstack,world,blockstate,pos,entity);
			int x = pos.getX();
			int y = pos.getY();
			int z = pos.getZ();
			<@procedureOBJToCode data.onBlockDestroyedWithTool/>
			return retval;
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

    };
}
<#-- @formatter:on -->
