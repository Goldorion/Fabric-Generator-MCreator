<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2012-2020, Pylo
 # Copyright (C) 2020-2021, Pylo, opensource contributors
 # Copyright (C) 2020-2022, Goldorion, opensource contributors
 #
 # Fabric-Generator-MCreator is free software: you can redistribute it and/or modify
 # it under the terms of the GNU Lesser General Public License as published by
 # the Free Software Foundation, either version 3 of the License, or
 # (at your option) any later version.

 # Fabric-Generator-MCreator is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 # GNU Lesser General Public License for more details.
 #
 # You should have received a copy of the GNU Lesser General Public License
 # along with Fabric-Generator-MCreator.  If not, see <https://www.gnu.org/licenses/>.
-->

<#-- @formatter:off -->
<#include "../mcitems.ftl">
<#include "../procedures.java.ftl">

package ${package}.entity;

import net.fabricmc.api.Environment;

<#compress>
public class ${name}Entity extends AbstractArrow implements ItemSupplier {

	public ${name}Entity(EntityType<? extends ${name}Entity> type, Level world) {
		super(type, world);
	}

	public ${name}Entity(EntityType<? extends ${name}Entity> type, double x, double y, double z, Level world) {
		super(type, x, y, z, world);
	}

	public ${name}Entity(EntityType<? extends ${name}Entity> type, LivingEntity entity, Level world) {
		super(type, entity, world);
	}

	@Override public ItemStack getItem() {
		<#if !data.bulletItemTexture.isEmpty()>
			return ${mappedMCItemToItemStackCode(data.bulletItemTexture, 1)};
		<#else>
			return null;
		</#if>
	}

	@Override protected ItemStack getPickupItem() {
		<#if !data.ammoItem.isEmpty()>
			return ${mappedMCItemToItemStackCode(data.ammoItem, 1)};
		<#else>
			return null;
		</#if>
	}

	@Override protected void doPostHurtEffects(LivingEntity entity) {
		super.doPostHurtEffects(entity);
		entity.setArrowCount(entity.getArrowCount() - 1); <#-- #53957 -->
	}

	<#if hasProcedure(data.onBulletHitsPlayer)>
		@Override public void playerTouch(Player entity) {
			super.playerTouch(entity);
			Entity sourceentity = this.getOwner();
			Entity immediatesourceentity = this;
			double x = this.getX();
			double y = this.getY();
			double z = this.getZ();
			Level world = this.level;
			<@procedureOBJToCode data.onBulletHitsPlayer/>
		}
	</#if>

	<#if hasProcedure(data.onBulletHitsEntity)>
		@Override public void onHitEntity(EntityHitResult entityHitResult) {
			super.onHitEntity(entityHitResult);
			Entity entity = entityHitResult.getEntity();
			Entity sourceentity = this.getOwner();
			Entity immediatesourceentity = this;
			double x = this.getX();
			double y = this.getY();
			double z = this.getZ();
			Level world = this.level;
			<@procedureOBJToCode data.onBulletHitsEntity/>
		}
	</#if>

	<#if hasProcedure(data.onBulletHitsBlock)>
		@Override public void onHitBlock(BlockHitResult blockHitResult) {
			super.onHitBlock(blockHitResult);
			double x = blockHitResult.getBlockPos().getX();
			double y = blockHitResult.getBlockPos().getY();
			double z = blockHitResult.getBlockPos().getZ();
			Level world = this.level;
			Entity entity = this.getOwner();
			Entity immediatesourceentity = this;
			<@procedureOBJToCode data.onBulletHitsBlock/>
		}
	</#if>

	@Override public void tick() {
		super.tick();

		<#if hasProcedure(data.onBulletFlyingTick)>
			double x = this.getX();
			double y = this.getY();
			double z = this.getZ();
			Level world = this.level;
			Entity entity = this.getOwner();
			Entity immediatesourceentity = this;
			<@procedureOBJToCode data.onBulletFlyingTick/>
		</#if>

		if (this.inGround)
			this.discard();
	}

	public static ${name}Entity shoot(Level world, LivingEntity entity, RandomSource random, float power, double damage, int knockback) {
		${name}Entity entityarrow = new ${name}Entity(${JavaModName}Entities.${data.getModElement().getRegistryNameUpper()}, entity, world);
		entityarrow.shoot(entity.getViewVector(1).x, entity.getViewVector(1).y, entity.getViewVector(1).z, power * 2, 0);
		entityarrow.setSilent(true);
		entityarrow.setCritArrow(${data.bulletParticles});
		entityarrow.setBaseDamage(damage);
		entityarrow.setKnockback(knockback);
		<#if data.bulletIgnitesFire>
			entityarrow.setSecondsOnFire(100);
		</#if>
		world.addFreshEntity(entityarrow);

		world.playSound((Player) null, entity.getX(), entity.getY(), entity.getZ(),
				<#assign s=data.actionSound>
				<#if s.getMappedValue()?has_content>
					<#if s.getUnmappedValue().startsWith("CUSTOM:")>
						${JavaModName}Sounds.${s?replace(modid + ":", "")?upper_case}
					<#else>
						SoundEvents.${(s?starts_with("ambient")||s?starts_with("music")||s?starts_with("ui")||s?starts_with("weather"))?string(s?upper_case?replace(".", "_"),s?keep_after(".")?upper_case?replace(".", "_"))}
					</#if>
				<#else>
					SoundEvents.ARROW_SHOOT
				</#if>,
				SoundSource.PLAYERS, 1, 1f / (random.nextFloat() * 0.5f + 1) + (power / 2));

		return entityarrow;
	}

	public static ${name}Entity shoot(LivingEntity entity, LivingEntity target) {
		${name}Entity entityarrow = new ${name}Entity(${JavaModName}Entities.${data.getModElement().getRegistryNameUpper()}, entity, entity.level);
		double d0 = target.getY() + (double) target.getEyeHeight() - 1.1;
		double d1 = target.getX() - entity.getX();
		double d3 = target.getZ() - entity.getZ();
		entityarrow.shoot(d1, d0 - entityarrow.getY() + Math.sqrt(d1 * d1 + d3 * d3) * 0.2F, d3, ${data.bulletPower}f * 2, 12.0F);

		entityarrow.setSilent(true);
		entityarrow.setBaseDamage(${data.bulletDamage});
		entityarrow.setKnockback(${data.bulletKnockback});
		entityarrow.setCritArrow(${data.bulletParticles});
		<#if data.bulletIgnitesFire>
			entityarrow.setSecondsOnFire(100);
		</#if>
		entity.level.addFreshEntity(entityarrow);

		double x = entity.getX();
		double y = entity.getY();
		double z = entity.getZ();
		entity.level.playSound((Player) null, (double) x, (double) y, (double) z,
				<#assign s=data.actionSound>
				<#if s.getMappedValue()?has_content>
					<#if s.getUnmappedValue().startsWith("CUSTOM:")>
						${JavaModName}Sounds.${s?replace(modid + ":", "")?upper_case}
					<#else>
						SoundEvents.${(s?starts_with("ambient")||s?starts_with("music")||s?starts_with("ui")||s?starts_with("weather"))?string(s?upper_case?replace(".", "_"),s?keep_after(".")?upper_case?replace(".", "_"))}
					</#if>
				<#else>
					SoundEvents.ARROW_SHOOT
				</#if>,
				SoundSource.PLAYERS, 1, 1f / (RandomSource.create().nextFloat() * 0.5f + 1));

		return entityarrow;
	}

}
</#compress>
<#-- @formatter:on -->
