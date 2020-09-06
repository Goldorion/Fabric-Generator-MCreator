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

package ${package}.item;

import net.fabricmc.api.EnvType;
import net.fabricmc.api.Environment;
import net.fabricmc.fabric.api.object.builder.v1.entity.FabricEntityTypeBuilder;
import net.fabricmc.fabric.api.client.rendereregistry.v1.EntityRendererRegistry;
import net.fabricmc.loader.api.FabricLoader;

public class ${name}RangedItem extends Item {
    public static final EntityType<CustomProjectileEntity> ENTITY_TYPE = Registry.register(
            Registry.ENTITY_TYPE,
            new Identifier("${modid}", "${registryname}_projectile"),
            FabricEntityTypeBuilder.<CustomProjectileEntity>create(SpawnGroup.MISC, CustomProjectileEntity::new).dimensions(EntityDimensions.fixed(0.5F, 0.5F)).build()
    );

    public ${name}RangedItem() {
        super(new Item.Settings()
        .group(${data.creativeTab})
					<#if data.usageCount != 0>.maxDamage(${data.usageCount})
                    <#else>.maxCount(${data.stackSize})</#if>);
        if (FabricLoader.getInstance().getEnvironmentType() == EnvType.CLIENT) {
            EntityRendererRegistry.INSTANCE.register(ENTITY_TYPE, (dispatcher, context) -> {
                return new FlyingItemEntityRenderer(dispatcher, MinecraftClient.getInstance().getItemRenderer());
            });
        }
    }

    @Override
    public UseAction getUseAction(ItemStack stack) {
        return UseAction.BOW;
    }

    @Override
    public TypedActionResult<ItemStack> use(World world, PlayerEntity user, Hand hand) {
        user.setCurrentHand(hand);
        return TypedActionResult.success(user.getStackInHand(hand));
    }

    <#if data.specialInfo?has_content>
    @Override
    @Environment(EnvType.CLIENT)
    public void appendTooltip(ItemStack stack, World world, List<Text> tooltip, TooltipContext context) {
        <#list data.specialInfo as entry>
            tooltip.add(new LiteralText("${JavaConventions.escapeStringForJava(entry)}"));
        </#list>
    }
    </#if>

    public int getMaxUseTime(ItemStack stack) {
        return 72000;
    }

    <#if data.hasGlow>
    @Environment(EnvType.CLIENT)
    @Override
    public boolean hasGlint(ItemStack stack) {
        return true;
    }
    </#if>

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

    <#if data.shootConstantly>
	@Override
    public void usageTick(World world, LivingEntity entityLiving, ItemStack itemstack, int remainingUseTicks) {
	    if (!world.isClient() && entityLiving instanceof ServerPlayerEntity) {
	        ServerPlayerEntity entity = (ServerPlayerEntity) entityLiving;
	        double x = entity.getX();
	        double y = entity.getY();
	        double z = entity.getZ();
	        if (<@procedureOBJToConditionCode data.useCondition/>) {
	            <@arrowShootCode/>
                entity.stopUsingItem();
	        }
	    }
	}
    <#else>
    @Override
    public void onStoppedUsing(ItemStack itemstack, World world, LivingEntity entityLiving, int timeLeft) {
        if (!world.isClient() && entityLiving instanceof ServerPlayerEntity) {
            ServerPlayerEntity entity = (ServerPlayerEntity) entityLiving;
            double x = entity.getX();
            double y = entity.getY();
            double z = entity.getZ();
            if (<@procedureOBJToConditionCode data.useCondition/>) {
                <@arrowShootCode/>
            }
        }
    }
    </#if>

    public static class CustomProjectileEntity extends PersistentProjectileEntity implements FlyingItemEntity {
        public CustomProjectileEntity(EntityType<? extends CustomProjectileEntity> type, World world) {
            super(type, world);
        }

        public CustomProjectileEntity(EntityType<? extends CustomProjectileEntity> type, double x, double y, double z, World world) {
            super(type, x, y, z, world);
        }

        public CustomProjectileEntity(EntityType<? extends CustomProjectileEntity> type, LivingEntity entity, World world) {
            super(type, entity, world);
        }

        @Override
        @Environment(EnvType.CLIENT)
        public ItemStack getStack() {
			<#if !data.bulletItemTexture.isEmpty()>
			return new ItemStack(${mappedMCItemToItemStackCode(data.bulletItemTexture, 1)});
            <#else>
			return ItemStack.EMPTY;
            </#if>
        }

        @Override
        protected ItemStack asItemStack() {
			<#if !data.ammoItem.isEmpty()>
			return new ItemStack(${mappedMCItemToItemStackCode(data.ammoItem, 1)});
            <#else>
			return ItemStack.EMPTY;
            </#if>
        }

		<#if hasProcedure(data.onBulletHitsPlayer)>
		@Override
        public void onPlayerCollision(PlayerEntity entity) {
            super.onPlayerCollision(entity);
            Entity sourceentity = this.getOwner();
            double x = this.getX();
            double y = this.getY();
            double z = this.getZ();
            World world = this.world;
			<@procedureOBJToCode data.onBulletHitsPlayer/>
        }
        </#if>

        @Override
        protected void onHit(LivingEntity entity) {
            super.onHit(entity);
            entity.setStuckArrowCount(entity.getStuckArrowCount() - 1); <#-- #53957 -->
			<#if hasProcedure(data.onBulletHitsEntity)>
				Entity sourceentity = this.getOwner();
				double x = this.getX();
				double y = this.getY();
				double z = this.getZ();
				World world = this.world;
                <@procedureOBJToCode data.onBulletHitsEntity/>
            </#if>
        }

        @Override
        public void tick() {
            super.tick();
            double x = this.getX();
            double y = this.getY();
            double z = this.getZ();
            World world = this.world;
            Entity entity = this.getOwner();
			<@procedureOBJToCode data.onBulletFlyingTick/>
            if (this.inGround) {
			    <@procedureOBJToCode data.onBulletHitsBlock/>
                this.remove();
            }
        }
    }

    public static CustomProjectileEntity shoot(World world, LivingEntity entity, Random random, float power, double damage, int knockback) {
        CustomProjectileEntity arrow = new CustomProjectileEntity(ENTITY_TYPE, entity, world);
        arrow.setVelocity(entity.getRotationVector().x, entity.getRotationVector().y, entity.getRotationVector().z, power * 2, 0);
        arrow.setSilent(true);
        arrow.setCritical(${data.bulletParticles});
        arrow.setDamage(damage);
        arrow.setPunch(knockback);
		<#if data.bulletIgnitesFire>
			arrow.setOnFireFor(100);
        </#if>
        world.spawnEntity(arrow);

        double x = entity.getX();
        double y = entity.getY();
        double z = entity.getZ();
        world.playSound((PlayerEntity) null, (double) x, (double) y, (double) z, SoundEvents.ENTITY_ARROW_SHOOT, SoundCategory.PLAYERS, 1, 1F / (random.nextFloat() * 0.5F + 1) + (power / 2));

        return arrow;
    }

    public static CustomProjectileEntity shoot(LivingEntity entity, LivingEntity target) {
        CustomProjectileEntity arrow = new CustomProjectileEntity(ENTITY_TYPE, entity, entity.world);
        double d0 = target.getX() + (double) target.getStandingEyeHeight() - 1.1;
        double d1 = target.getY() - entity.getX();
        double d3 = target.getZ() - entity.getZ();
        arrow.setVelocity(d1, d0 - arrow.getY() + (double) MathHelper.sqrt(d1 * d1 + d3 * d3) * 0.2F, d3, ${data.bulletPower}f * 2, 12.0F);

        arrow.setSilent(true);
        arrow.setDamage(${data.bulletDamage});
        arrow.setPunch(${data.bulletKnockback});
        arrow.setCritical(${data.bulletParticles});
		<#if data.bulletIgnitesFire>
			arrow.setOnFireFor(100);
        </#if>
        entity.world.spawnEntity(arrow);

        double x = entity.getX();
        double y = entity.getY();
        double z = entity.getZ();
        entity.world.playSound((PlayerEntity) null, (double) x, (double) y, (double) z, SoundEvents.ENTITY_ARROW_SHOOT, SoundCategory.PLAYERS, 1, 1F / (new Random().nextFloat() * 0.5F + 1));

        return arrow;
    }
}

<#macro arrowShootCode>
    <#if !data.ammoItem.isEmpty()>
	ItemStack stack = RangedWeaponItem.getHeldProjectile(entity, e -> e.getItem() == new ItemStack(${mappedMCItemToItem(data.ammoItem)}).getItem());

	if(stack == ItemStack.EMPTY) {
            for (int i = 0; i < entity.inventory.main.size(); i++) {
			ItemStack teststack = entity.inventory.main.get(i);
			if(teststack != null && teststack.getItem() == new ItemStack(${mappedMCItemToItem(data.ammoItem)}).getItem()) {
				stack = teststack;
				break;
			}
		}
	}

	if (entity.abilities.creativeMode || stack != ItemStack.EMPTY) {
    </#if>

	CustomProjectileEntity entityarrow = shoot(world, entity, new Random(31100L), ${data.bulletPower}f, ${data.bulletDamage}, ${data.bulletKnockback});

	itemstack.damage(1, entity, e -> e.sendToolBreakStatus(entity.getActiveHand()));

    <#if !data.ammoItem.isEmpty()>
	if (entity.abilities.creativeMode) {
		entityarrow.pickupType = PersistentProjectileEntity.PickupPermission.CREATIVE_ONLY;
	} else {
		if (new ItemStack(${mappedMCItemToItemStackCode(data.ammoItem, 1)}).isDamageable()){
			if (stack.damage(1, new Random(31100L), entity)) {
				stack.decrement(1);
				stack.setDamage(0);
            	if (stack.isEmpty())
               		entity.inventory.removeOne(stack);
			}
		} else{
			stack.decrement(1);
            if (stack.isEmpty())
               entity.inventory.removeOne(stack);
		}
	}
    <#else>
	eentityarrow.pickupType = PersistentProjectileEntity.PickupPermission.DISALLOWED;
    </#if>

    <#if hasProcedure(data.onRangedItemUsed)>
        <@procedureOBJToCode data.onRangedItemUsed/>
    </#if>

    <#if !data.ammoItem.isEmpty()>
	}
    </#if>
</#macro>

<#-- @formatter:on -->