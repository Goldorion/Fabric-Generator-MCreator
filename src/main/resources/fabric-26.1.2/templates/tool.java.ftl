<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2012-2020, Pylo
 # Copyright (C) 2020-2026, Pylo, opensource contributors
 # Copyright (C) 2020-2026, Goldorion, opensource contributors
 #
 # Fabric-Generator-MCreator is free software: you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
 # the Free Software Foundation, either version 3 of the License, or
 # (at your option) any later version.
 #
 # Fabric-Generator-MCreator is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
 # along with Fabric-Generator-MCreator. If not, see <https://www.gnu.org/licenses/>.
-->

<#-- @formatter:off -->
<#include "mcitems.ftl">
<#include "procedures.java.ftl">
<#include "triggers.java.ftl">

package ${package}.item;

<@javacompress>
<#if data.toolType == "Pickaxe" || data.toolType == "Axe" || data.toolType == "Sword" || data.toolType == "Spade"
		|| data.toolType == "Hoe"|| data.toolType == "Shears" || data.toolType == "Shield" || data.toolType == "MultiTool">
public class ${name}Item extends ${data.toolType?replace("Spade", "Shovel")?replace("MultiTool|Pickaxe|Sword", "", "r")}Item {

	<#if data.toolType == "Pickaxe" || data.toolType == "Axe" || data.toolType == "Sword" || data.toolType == "Spade" || data.toolType == "Hoe" || data.toolType == "MultiTool">
	private static final ToolMaterial TOOL_MATERIAL = new ToolMaterial(
		<#if data.blockDropsTier == "WOOD">BlockTags.INCORRECT_FOR_WOODEN_TOOL
		<#elseif data.blockDropsTier == "STONE">BlockTags.INCORRECT_FOR_STONE_TOOL
		<#elseif data.blockDropsTier == "IRON">BlockTags.INCORRECT_FOR_IRON_TOOL
		<#elseif data.blockDropsTier == "DIAMOND">BlockTags.INCORRECT_FOR_DIAMOND_TOOL
		<#elseif data.blockDropsTier == "GOLD">BlockTags.INCORRECT_FOR_GOLD_TOOL
		<#else>BlockTags.INCORRECT_FOR_NETHERITE_TOOL
		</#if>,
		${data.usageCount},
		${data.efficiency}f,
		0,
		${data.enchantability},
		TagKey.create(Registries.ITEM, Identifier.parse("${modid}:${registryname}_repair_items")) <#-- data.repairItems are put into a tag -->
	);
	</#if>

	public ${name}Item (Item.Properties properties) {
		super(
			<#if data.toolType == "Axe" || data.toolType == "Spade" || data.toolType == "Hoe">
			TOOL_MATERIAL, ${data.damageVsEntity - 1}f, ${data.attackSpeed - 4}f,
			</#if>
			<#if data.toolType == "MultiTool">
			TOOL_MATERIAL.applyToolProperties(properties, BlockTags.MINEABLE_WITH_PICKAXE, ${data.damageVsEntity - 1}f, ${data.attackSpeed - 4}f, 0)
			<#else>
			properties
			</#if>
			<#if data.toolType == "Pickaxe">
			.pickaxe(TOOL_MATERIAL, ${data.damageVsEntity - 1}f, ${data.attackSpeed - 4}f)
			<#elseif data.toolType == "Sword">
			.sword(TOOL_MATERIAL, ${data.damageVsEntity - 1}f, ${data.attackSpeed - 4}f)
			<#elseif data.toolType == "MultiTool">
			.attributes(<@itemAttributeModifiers true/>)
			<#elseif data.toolType == "Shield">
			.repairable(TagKey.create(Registries.ITEM, Identifier.parse("${modid}:${registryname}_repair_items")))
			.component(DataComponents.BREAK_SOUND, SoundEvents.SHIELD_BREAK)
			.equippableUnswappable(EquipmentSlot.OFFHAND)
			.delayedComponent(DataComponents.BLOCKS_ATTACKS, context -> new BlocksAttacks(
				0.25f,
				1,
				List.of(new BlocksAttacks.DamageReduction(90.0f, Optional.empty(), 0, 1)),
				new BlocksAttacks.ItemDamageFunction(3, 1, 1),
				Optional.of(context.getOrThrow(DamageTypeTags.BYPASSES_SHIELD)),
				Optional.of(SoundEvents.SHIELD_BLOCK),
				Optional.of(SoundEvents.SHIELD_BREAK)
			))
			<#elseif data.toolType == "Shears">
			.component(DataComponents.TOOL, ShearsItem.createToolProperties())
				<#if data.repairItems?has_content>
				.repairable(TagKey.create(Registries.ITEM, Identifier.parse("${modid}:${registryname}_repair_items")))
				</#if>
			</#if>
			<#if data.toolType == "Shears" || data.toolType == "Shield">
				<#if data.usageCount != 0>
				.durability(${data.usageCount})
				<#else>
				.stacksTo(1)
				</#if>
			</#if>
			<#if data.rarity != "COMMON">
			.rarity(Rarity.${data.rarity})
			</#if>
			<#if data.immuneToFire>
			.fireResistant()
			</#if>
			<#if data.enchantability != 0 && data.toolType=="Shears">
			.enchantable(${data.enchantability})
			</#if>
			<#if (data.attributeModifiers?size gt 0) && (data.toolType == "Pickaxe" || data.toolType == "Sword" || data.toolType == "Shears" || data.toolType == "Shield")>
			.attributes(<@itemAttributeModifiers (data.toolType == "Pickaxe" || data.toolType == "Sword")/>)
			</#if>
			<#if modifiesDefaultComponents(data.toolType)>
                <#if data.usageCount == 0>
                    .component(DataComponents.MAX_DAMAGE, null)
                </#if>
                <#if data.attributeModifiers?size gt 0 && (data.toolType == "Axe" || data.toolType == "Spade" || data.toolType == "Hoe")>
                    .component(DataComponents.ATTRIBUTE_MODIFIERS, <@itemAttributeModifiers true/>)
                </#if>
			</#if>
		);
	}

	<#if hasProcedure(data.additionalDropCondition) && data.toolType!="MultiTool">
	@Override public boolean isCorrectToolForDrops(ItemStack itemstack, BlockState blockstate) {
		return super.isCorrectToolForDrops(itemstack, blockstate) && <@procedureCode data.additionalDropCondition, {
		"itemstack": "itemstack",
		"blockstate": "blockstate"
		}, false/>;
	}
	</#if>

	<#if data.toolType=="Shears">
		@Override public float getDestroySpeed(ItemStack stack, BlockState blockstate) {
			return ${data.efficiency}f;
		}
	<#elseif data.toolType=="MultiTool">
		@Override public boolean isCorrectToolForDrops(ItemStack itemstack, BlockState blockstate) {
			<#if hasProcedure(data.additionalDropCondition)>
				if(!<@procedureCode data.additionalDropCondition, {
					"itemstack": "itemstack",
					"blockstate": "blockstate"
				}, false/>) return false;
			</#if>

			<#if data.blockDropsTier == "WOOD" || data.blockDropsTier == "GOLD">
			return !blockstate.is(BlockTags.NEEDS_STONE_TOOL) && !blockstate.is(BlockTags.NEEDS_IRON_TOOL) && !blockstate.is(BlockTags.NEEDS_DIAMOND_TOOL);
			<#elseif data.blockDropsTier == "STONE">
			return !blockstate.is(BlockTags.NEEDS_IRON_TOOL) && !blockstate.is(BlockTags.NEEDS_DIAMOND_TOOL);
			<#elseif data.blockDropsTier == "IRON">
			return !blockstate.is(BlockTags.NEEDS_DIAMOND_TOOL);
			<#else>
			return blockstate.is(BlockTags.MINEABLE_WITH_AXE) || blockstate.is(BlockTags.MINEABLE_WITH_HOE) || blockstate.is(BlockTags.MINEABLE_WITH_PICKAXE) || blockstate.is(BlockTags.MINEABLE_WITH_SHOVEL);
			</#if>
		}

		@Override public float getDestroySpeed(ItemStack itemstack, BlockState blockstate) {
			return ${data.efficiency}f;
		}
	</#if>

	<#if data.toolType=="MultiTool">
		<@onBlockDestroyedWith data.onBlockDestroyedWithTool, true/>

		<@onEntityHitWith data.onEntityHitWith, true/>
	<#else>
		<@onBlockDestroyedWith data.onBlockDestroyedWithTool/>

		<@onEntityHitWith data.onEntityHitWith/>
	</#if>

	<@onRightClickedInAir data.onRightClickedInAir/>

	<@commonMethods/>

}
<#elseif data.toolType=="Special">
public class ${name}Item extends Item {

	public ${name}Item(Item.Properties properties) {
		super(properties
			<#if data.usageCount != 0>
			.durability(${data.usageCount})
			<#else>
			.stacksTo(1)
			</#if>
			<#if data.rarity != "COMMON">
			.rarity(Rarity.${data.rarity})
			</#if>
			<#if data.immuneToFire>
			.fireResistant()
			</#if>
			<#if data.repairItems?has_content>
			.repairable(TagKey.create(Registries.ITEM, Identifier.parse("${modid}:${registryname}_repair_items")))
			</#if>
			.attributes(<@itemAttributeModifiers true/>)
			<#if data.enchantability != 0>
			.enchantable(${data.enchantability})
			</#if>
		);
	}

	@Override public float getDestroySpeed(ItemStack itemstack, BlockState blockstate) {
		return <#if data.blocksAffected?has_content>${containsAnyOfBlocks(data.blocksAffected "blockstate")} ? ${data.efficiency}f : </#if>1;
	}

	<@onBlockDestroyedWith data.onBlockDestroyedWithTool, true/>

	<@onEntityHitWith data.onEntityHitWith, true/>

	<@onRightClickedInAir data.onRightClickedInAir/>

	<@commonMethods/>
}
<#elseif data.toolType=="Fishing rod">
public class ${name}Item extends FishingRodItem {

	public ${name}Item(Item.Properties properties) {
		super(properties
			<#if data.usageCount != 0>
			.durability(${data.usageCount})
			<#else>
			.stacksTo(1)
			</#if>
			<#if data.rarity != "COMMON">
			.rarity(Rarity.${data.rarity})
			</#if>
			<#if data.immuneToFire>
			.fireResistant()
			</#if>
			.repairable(TagKey.create(Registries.ITEM, Identifier.parse("${modid}:${registryname}_repair_items")))
			<#if data.enchantability != 0>
			.enchantable(${data.enchantability})
			</#if>
			<#if data.attributeModifiers?size gt 0>
			.attributes(<@itemAttributeModifiers/>)
			</#if>
		);
	}

	<@onBlockDestroyedWith data.onBlockDestroyedWithTool/>

	<@onEntityHitWith data.onEntityHitWith/>

	@Override public InteractionResult use(Level world, Player entity, InteractionHand hand) {
        ItemStack itemStack = entity.getItemInHand(hand);
        if (entity.fishing != null) {
            if (!world.isClientSide()) {
                int dmg = entity.fishing.retrieve(itemStack);
                itemStack.hurtAndBreak(dmg, (LivingEntity) entity, hand.asEquipmentSlot());
            }
            world.playSound(null, entity.getX(), entity.getY(), entity.getZ(), SoundEvents.FISHING_BOBBER_RETRIEVE, SoundSource.NEUTRAL, 1.0f, 0.4f / (world.getRandom().nextFloat() * 0.4f + 0.8f));
            itemStack.causeUseVibration(entity, GameEvent.ITEM_INTERACT_FINISH);
        } else {
            world.playSound(null, entity.getX(), entity.getY(), entity.getZ(), SoundEvents.FISHING_BOBBER_THROW, SoundSource.NEUTRAL, 0.5f, 0.4f / (world.getRandom().nextFloat() * 0.4f + 0.8f));
            if (world instanceof ServerLevel) {
                ServerLevel serverLevel = (ServerLevel) world;
                int lureSpeed = (int)(EnchantmentHelper.getFishingTimeReduction(serverLevel, itemStack, entity) * 20.0f);
                int luck = EnchantmentHelper.getFishingLuckBonus(serverLevel, itemStack, entity);
                Projectile.spawnProjectile(new FishingHook(entity, world, luck, lureSpeed) {
                    @Override protected boolean shouldStopFishing(Player owner) {
                        if (owner.canInteractWithLevel() && this.distanceToSqr(owner) <= 1024 && (owner.getMainHandItem().is(${JavaModName}Items.${REGISTRYNAME}) || owner.getOffhandItem().is(${JavaModName}Items.${REGISTRYNAME})))
                            return false;

                        this.discard();
                        return true;
                    }
                }, serverLevel, itemStack);
            }
            entity.awardStat(Stats.ITEM_USED.get(this));
            itemStack.causeUseVibration(entity, GameEvent.ITEM_INTERACT_START);
        }

		<#if hasProcedure(data.onRightClickedInAir)>
			<@procedureCode data.onRightClickedInAir, {
				"x": "entity.getX()",
				"y": "entity.getY()",
				"z": "entity.getZ()",
				"world": "world",
				"entity": "entity",
				"itemstack": "itemstack"
			}/>
		</#if>

		return InteractionResult.SUCCESS;
	}

	<@commonMethods/>
}
</#if>
</@javacompress>

<#function modifiesDefaultComponents toolType>
	<#if data.usageCount == 0>
		<#return toolType == "Pickaxe" || toolType == "Axe" || toolType == "Sword" || toolType == "Spade" || toolType == "Hoe" || toolType == "MultiTool">
	<#elseif data.attributeModifiers?size gt 0>
		<#return toolType == "Axe" || toolType == "Spade" || toolType == "Hoe">
	<#else>
		<#return false>
	</#if>
</#function>

<#macro itemAttributeModifiers includeMeleeAttributes=false>
	ItemAttributeModifiers.builder()
	<#if includeMeleeAttributes>
	.add(Attributes.ATTACK_DAMAGE, new AttributeModifier(BASE_ATTACK_DAMAGE_ID, ${data.damageVsEntity - 1}, AttributeModifier.Operation.ADD_VALUE), EquipmentSlotGroup.MAINHAND)
	.add(Attributes.ATTACK_SPEED, new AttributeModifier(BASE_ATTACK_SPEED_ID, ${data.attackSpeed - 4}, AttributeModifier.Operation.ADD_VALUE), EquipmentSlotGroup.MAINHAND)
	</#if>
	<#list data.attributeModifiers as modifier>
	.add(${modifier.attribute}, new AttributeModifier(
			Identifier.fromNamespaceAndPath(${JavaModName}.MODID, "${registryname}_${modifier?index}"),
			${modifier.amount}, AttributeModifier.Operation.${modifier.operation}),
			<#if modifier.equipmentSlot == "default">EquipmentSlotGroup.MAINHAND<#else>${modifier.equipmentSlot}</#if>)
	</#list>
	.build()
</#macro>

<#macro commonMethods>
	<#if data.stayInGridWhenCrafting>
		<#if data.damageOnCrafting && data.usageCount != 0>
			@Override public ItemStackTemplate getCraftingRemainder(ItemStack itemstack) {
				ItemStack retval = new ItemStack(this);
				retval.setDamageValue(itemstack.getDamageValue() + 1);
				if(retval.getDamageValue() >= retval.getMaxDamage()) {
					return null;
				}
				return ItemStackTemplate.fromNonEmptyStack(retval);
			}
		<#else>
			@Override public ItemStackTemplate getCraftingRemainder(ItemStack itemstack) {
				return new ItemStackTemplate(this);
			}
		</#if>
	</#if>

	<@addSpecialInformation data.specialInformation, "item." + modid + "." + registryname/>

	<@onItemUsedOnBlock data.onRightClickedOnBlock/>

	<@onCrafted data.onCrafted/>

	<@onEntitySwing data.onEntitySwing/>

	<@onItemTick data.onItemInUseTick, data.onItemInInventoryTick/>

	<@onDroppedByPlayer data.onDroppedByPlayer/>

	<@onItemEntityDestroyed data.onItemEntityDestroyed/>

	<@hasGlow data.glowCondition/>

</#macro>
<#-- @formatter:on -->