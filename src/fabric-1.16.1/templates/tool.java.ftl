<#-- @formatter:off -->
<#include "procedures.java.ftl">

package ${package}.item;

import net.fabricmc.api.EnvType;
import net.fabricmc.api.Environment;

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
					return Ingredient.ofStacks(
							<#list data.repairItems as repairItem>
                                ${mappedMCItemToItemStackCode(repairItem,1)}<#if repairItem?has_next>,</#if>
                            </#list>
                    );
            <#else>
					return Ingredient.EMPTY;
            </#if>
        }
    }

</#if>

<#if data.toolType=="Special">
    public static class CustomToolItem extends Item {
        public CustomToolItem() {
            super(new Item.Settings().group(${data.creativeTab}).maxDamage(${data.usageCount}));
        }

        @Override
        public float getMiningSpeedMultiplier(ItemStack stack, BlockState state) {
			 <#list data.blocksAffected as restrictionBlock>
                 if (blockstate.getBlock() == ${mappedBlockToBlockStateCode(restrictionBlock)}.getBlock())
                 	return ${data.efficiency}f;
             </#list>
            return 0;
        }

        @Override
        public int getEnchantability() {
            return ${data.enchantability};
        }

        @Override
        public Multimap<EntityAttribute, EntityAttributeModifier> getAttributeModifiers(EquipmentSlot slot) {
            Multimap<String, EntityAttributeModifier> multimap = super.getAttributeModifiers(slot);
            if (slot == EquipmentSlotType.MAINHAND) {
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
            stack.damageItem(1, miner, i -> i.sendBreakAnimation(EquipmentSlotType.MAINHAND));
            return true;
        }
    }
<#elseif data.toolType=="MultiTool">
    public static class CustomToolItem extends Item {
        public CustomToolItem() {
            super(new Item.Settings().group(${data.creativeTab}).maxDamage(${data.usageCount}));
        }

        @Override
        public Multimap<EntityAttribute, EntityAttributeModifier> getAttributeModifiers(EquipmentSlot slot) {
            Multimap<String, EntityAttributeModifier> multimap = super.getAttributeModifiers(slot);
            if (slot == EquipmentSlotType.MAINHAND) {
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
        public float getDestroySpeed(ItemStack itemstack, BlockState blockstate) {
            return ${data.efficiency}F;
        }

        @Override
        public boolean postHit(ItemStack stack, LivingEntity target, LivingEntity attacker) {
            stack.damageItem(1, attacker, i -> i.sendToolBreakStatus(EquipmentSlot.MAINHAND));
            return true;
        }

        @Override
        public boolean postMine(ItemStack stack, World world, BlockState state, BlockPos pos, LivingEntity miner) {
            stack.damageItem(1, miner, i -> i.sendBreakAnimation(EquipmentSlotType.MAINHAND));
            return true;
        }

        @Override
        public int getEnchantability() {
            return ${data.enchantability};
        }
    }
</#if>

    public static final Item INSTANCE = new
<#if data.toolType == "Pickaxe" || data.toolType == "Axe" || data.toolType == "Sword" || data.toolType == "Spade" || data.toolType == "Hoe">${data.toolType.toString().replace("Spade", "Shovel")}Item(${name?upper_case}_TOOL_MATERIAL, ${data.attackSpeed - 4}, ${data.attackSpeed - 4}, (new Item.Settings().group(${ge.creativeTab})))
<#elseif data.toolType == "Shears">ShearsItem((new Item.Settings().group(${ge.creativeTab})))
<#else>CustomToolItem()</#if>{

        <#if data.toolType == "Shears">
            @Override
            public int getEnchantability() {
                return ${data.enchantability};
            }

            @Override
            public float getMiningSpeedMultiplier(ItemStack stack, BlockState state) {
                return ${data.efficiency}f;
            }
        </#if>

        <#if data.specialInfo?has_content>
        @Override
        @Environment(EnvType.CLIENT)
        public void appendTooltip(ItemStack stack, @Nullable World world, List<Text> tooltip, TooltipContext context) {
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
        @Environment(Envtype.CLIENT)
        @Override
        public boolean hasGlint(ItemStack stack) {
            return true;
        }
        </#if>

    };
}
<#-- @formatter:on -->