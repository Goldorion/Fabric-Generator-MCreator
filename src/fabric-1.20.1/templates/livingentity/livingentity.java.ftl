<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2012-2020, Pylo
 # Copyright (C) 2020-2023, Pylo, opensource contributors
 # Copyright (C) 2020-2023, Goldorion, opensource contributors
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
<#compress>

package ${package}.entity;

import net.minecraft.world.entity.ai.attributes.Attribute;
import net.minecraft.world.entity.ai.attributes.Attributes;
import net.minecraft.world.level.material.Material;
import net.minecraft.nbt.Tag;
import net.minecraft.network.syncher.EntityDataAccessor;

<#assign extendsClass = "PathfinderMob">

<#if data.aiBase != "(none)" >
	<#assign extendsClass = data.aiBase?replace("Enderman", "EnderMan")>
<#else>
	<#assign extendsClass = data.mobBehaviourType?replace("Mob", "Monster")?replace("Creature", "PathfinderMob")>
</#if>

<#if data.breedable>
	<#assign extendsClass = "Animal">
</#if>

<#if (data.tameable && data.breedable)>
	<#assign extendsClass = "TamableAnimal">
</#if>

public class ${name}Entity extends ${extendsClass} <#if data.ranged>implements RangedAttackMob</#if> {

	<#list data.entityDataEntries as entry>
		<#if entry.value().getClass().getSimpleName() == "Integer">
			public static final EntityDataAccessor<Integer> DATA_${entry.property().getName()} = SynchedEntityData.defineId(${name}Entity.class, EntityDataSerializers.INT);
		<#elseif entry.value().getClass().getSimpleName() == "Boolean">
			public static final EntityDataAccessor<Boolean> DATA_${entry.property().getName()} = SynchedEntityData.defineId(${name}Entity.class, EntityDataSerializers.BOOLEAN);
		<#elseif entry.value().getClass().getSimpleName() == "String">
			public static final EntityDataAccessor<String> DATA_${entry.property().getName()} = SynchedEntityData.defineId(${name}Entity.class, EntityDataSerializers.STRING);
		</#if>
	</#list>
	
	<#if data.isBoss>
		private final ServerBossEvent bossInfo = new ServerBossEvent(this.getDisplayName(),
				ServerBossEvent.BossBarColor.${data.bossBarColor}, ServerBossEvent.BossBarOverlay.${data.bossBarType});
	</#if>

	public ${name}Entity(EntityType<${name}Entity> type, Level world) {
		super(type, world);
		setMaxUpStep(${data.stepHeight}f);
		xpReward = ${data.xpAmount};
		setNoAi(${(!data.hasAI)});

		<#if data.mobLabel?has_content >
			setCustomName(Component.literal("${data.mobLabel}"));
			setCustomNameVisible(true);
		</#if>

		<#if !data.doesDespawnWhenIdle>
			setPersistenceRequired();
		</#if>

		<#if !data.equipmentMainHand.isEmpty()>
			this.setItemSlot(EquipmentSlot.MAINHAND, ${mappedMCItemToItemStackCode(data.equipmentMainHand, 1)});
		</#if>
		<#if !data.equipmentOffHand.isEmpty()>
			this.setItemSlot(EquipmentSlot.OFFHAND, ${mappedMCItemToItemStackCode(data.equipmentOffHand, 1)});
		</#if>
		<#if !data.equipmentHelmet.isEmpty()>
			this.setItemSlot(EquipmentSlot.HEAD, ${mappedMCItemToItemStackCode(data.equipmentHelmet, 1)});
		</#if>
		<#if !data.equipmentBody.isEmpty()>
			this.setItemSlot(EquipmentSlot.CHEST, ${mappedMCItemToItemStackCode(data.equipmentBody, 1)});
		</#if>
		<#if !data.equipmentLeggings.isEmpty()>
			this.setItemSlot(EquipmentSlot.LEGS, ${mappedMCItemToItemStackCode(data.equipmentLeggings, 1)});
		</#if>
		<#if !data.equipmentBoots.isEmpty()>
			this.setItemSlot(EquipmentSlot.FEET, ${mappedMCItemToItemStackCode(data.equipmentBoots, 1)});
		</#if>

		<#if data.flyingMob>
		this.moveControl = new FlyingMoveControl(this, 10, true);
		<#elseif data.waterMob>
		this.setPathfindingMalus(BlockPathTypes.WATER, 0);
		this.moveControl = new MoveControl(this) {
			@Override public void tick() {
				if (${name}Entity.this.isInWater())
					${name}Entity.this.setDeltaMovement(${name}Entity.this.getDeltaMovement().add(0, 0.005, 0));

				if (this.operation == MoveControl.Operation.MOVE_TO && !${name}Entity.this.getNavigation().isDone()) {
					double dx = this.wantedX - ${name}Entity.this.getX();
					double dy = this.wantedY - ${name}Entity.this.getY();
					double dz = this.wantedZ - ${name}Entity.this.getZ();

					float f = (float) (Mth.atan2(dz, dx) * (double) (180 / Math.PI)) - 90;
					float f1 = (float) (this.speedModifier * ${name}Entity.this.getAttribute(Attributes.MOVEMENT_SPEED).getValue());

					${name}Entity.this.setYRot(this.rotlerp(${name}Entity.this.getYRot(), f, 10));
					${name}Entity.this.yBodyRot = ${name}Entity.this.getYRot();
					${name}Entity.this.yHeadRot = ${name}Entity.this.getYRot();

					if (${name}Entity.this.isInWater()) {
						${name}Entity.this.setSpeed((float) ${name}Entity.this.getAttribute(Attributes.MOVEMENT_SPEED).getValue());

						float f2 = - (float) (Mth.atan2(dy, (float) Math.sqrt(dx * dx + dz * dz)) * (180 / Math.PI));
						f2 = Mth.clamp(Mth.wrapDegrees(f2), -85, 85);
						${name}Entity.this.setXRot(this.rotlerp(${name}Entity.this.getXRot(), f2, 5));
						float f3 = Mth.cos(${name}Entity.this.getXRot() * (float) (Math.PI / 180.0));

						${name}Entity.this.setZza(f3 * f1);
						${name}Entity.this.setYya((float) (f1 * dy));
					} else {
						${name}Entity.this.setSpeed(f1 * 0.05F);
					}
				} else {
					${name}Entity.this.setSpeed(0);
					${name}Entity.this.setYya(0);
					${name}Entity.this.setZza(0);
				}
			}
		};
		</#if>
	}
	
	<#if data.entityDataEntries?has_content>
		@Override protected void defineSynchedData() {
			super.defineSynchedData();
			<#list data.entityDataEntries as entry>
				this.entityData.define(DATA_${entry.property().getName()}, ${entry.value()?is_string?then("\"" + entry.value() + "\"", entry.value())});
			</#list>
		}
	</#if>

	<#if data.flyingMob>
		@Override protected PathNavigation createNavigation(Level world) {
			return new FlyingPathNavigation(this, world);
		}
	<#elseif data.waterMob>
		@Override protected PathNavigation createNavigation(Level world) {
			return new WaterBoundPathNavigation(this, world);
		}
	</#if>

	<#if data.hasAI>
		@Override protected void registerGoals() {
			super.registerGoals();

			<#if aicode??>
				${aicode}
			</#if>
			<#if data.ranged>
				this.goalSelector.addGoal(1, new RangedAttackGoal(this, 1.25, ${data.rangedAttackInterval}, ${data.rangedAttackRadius}f) {
					@Override public boolean canContinueToUse() {
						return this.canUse();
					}
				});
			</#if>
		}
	</#if>

	@Override public MobType getMobType() {
		return MobType.${data.mobCreatureType};
	}

	<#if !data.doesDespawnWhenIdle>
		@Override public boolean removeWhenFarAway(double distanceToClosestPlayer) {
			return false;
		}
	</#if>

	<#if data.mobModelName == "Biped">
		@Override public double getMyRidingOffset() {
			return -0.35D;
		}
	<#elseif data.mobModelName == "Silverfish">
		@Override public double getMyRidingOffset() {
			return 0.1D;
		}
	</#if>

	<#if data.mountedYOffset != 0>
		@Override public double getPassengersRidingOffset() {
			return super.getPassengersRidingOffset() + ${data.mountedYOffset};
		}
	</#if>

	<#if !data.mobDrop.isEmpty()>
		protected void dropCustomDeathLoot(DamageSource source, int looting, boolean recentlyHitIn) {
			super.dropCustomDeathLoot(source, looting, recentlyHitIn);
			this.spawnAtLocation(${mappedMCItemToItemStackCode(data.mobDrop, 1)});
		}
	</#if>

   	<#if data.livingSound.getMappedValue()?has_content>
		@Override public SoundEvent getAmbientSound() {
			<#assign s=data.livingSound>
			<#if s.getUnmappedValue().startsWith("CUSTOM:")>
			return ${JavaModName}Sounds.${s?replace(modid + ":", "")?upper_case};
			<#else>
			return BuiltInRegistries.SOUND_EVENT.get(new ResourceLocation("${s}"));
			</#if>
		}
	</#if>

   	<#if data.stepSound?has_content && data.stepSound.getMappedValue()?has_content>
		@Override public void playStepSound(BlockPos pos, BlockState blockIn) {
			this.playSound(
			<#assign s=data.stepSound>
			<#if s.getUnmappedValue().startsWith("CUSTOM:")>
			${JavaModName}Sounds.${s?replace(modid + ":", "")?upper_case}
			<#else>
			BuiltInRegistries.SOUND_EVENT.get(new ResourceLocation("${s}"))
			</#if>
			, 0.15f, 1);
		}
	</#if>

	@Override public SoundEvent getHurtSound(DamageSource ds) {
		<#assign s=data.hurtSound>
		<#if s.getUnmappedValue().startsWith("CUSTOM:")>
		return ${JavaModName}Sounds.${s?replace(modid + ":", "")?upper_case};
		<#else>
		return BuiltInRegistries.SOUND_EVENT.get(new ResourceLocation("${s}"));
		</#if>
	}

	@Override public SoundEvent getDeathSound() {
		<#assign s=data.deathSound>
		<#if s.getUnmappedValue().startsWith("CUSTOM:")>
		return ${JavaModName}Sounds.${s?replace(modid + ":", "")?upper_case};
		<#else>
		return BuiltInRegistries.SOUND_EVENT.get(new ResourceLocation("${s}"));
		</#if>
	}

	<#if hasProcedure(data.onStruckByLightning)>
		@Override public void thunderHit(ServerLevel serverWorld, LightningBolt lightningBolt) {
			super.thunderHit(serverWorld, lightningBolt);
			double x = this.getX();
			double y = this.getY();
			double z = this.getZ();
			Entity entity = this;
			Level world = this.level();
			<@procedureOBJToCode data.onStruckByLightning/>
		}
	</#if>

	<#if hasProcedure(data.whenMobFalls) || data.flyingMob>
		@Override public boolean causeFallDamage(float l, float d, DamageSource source) {
			<#if hasProcedure(data.whenMobFalls) >
				double x = this.getX();
				double y = this.getY();
				double z = this.getZ();
				Entity entity = this;
				Level world = this.level();
				<@procedureOBJToCode data.whenMobFalls/>
			</#if>

			<#if data.flyingMob >
				return false;
			<#else>
				return super.causeFallDamage(l, d, source);
			</#if>
		}
	</#if>

	<#if hasProcedure(data.whenMobIsHurt) || data.immuneToArrows || data.immuneToFallDamage
		|| data.immuneToCactus || data.immuneToDrowning || data.immuneToLightning || data.immuneToPotions
		|| data.immuneToPlayer || data.immuneToExplosion || data.immuneToTrident || data.immuneToAnvil
		|| data.immuneToDragonBreath || data.immuneToWither>
		@Override public boolean hurt(DamageSource damagesource, float amount) {
			double x = this.getX();
			double y = this.getY();
			double z = this.getZ();
			Level world = this.level();
			Entity entity = this;
			Entity sourceentity = damagesource.getEntity();
			Entity immediatesourceentity = damagesource.getDirectEntity();
			
			<#if hasReturnValueOf(data.whenMobIsHurt, "logic")>
				if (<@procedureOBJToConditionCode data.whenMobIsHurt false true/>)
					return false;
			<#else>
				<@procedureOBJToCode data.whenMobIsHurt/>
			</#if>
			
			<#if data.immuneToArrows>
				if (damagesource.getDirectEntity() instanceof AbstractArrow)
					return false;
			</#if>
			<#if data.immuneToPlayer>
				if (damagesource.getDirectEntity() instanceof Player)
					return false;
			</#if>
			<#if data.immuneToPotions>
				if (damagesource.getDirectEntity() instanceof ThrownPotion || damagesource.getDirectEntity() instanceof AreaEffectCloud)
					return false;
			</#if>
			<#if data.immuneToFallDamage>
				if (damagesource.is(DamageTypes.FALL))
					return false;
			</#if>
			<#if data.immuneToCactus>
				if (damagesource.is(DamageTypes.CACTUS))
					return false;
			</#if>
			<#if data.immuneToDrowning>
				if (damagesource.is(DamageTypes.DROWN))
					return false;
			</#if>
			<#if data.immuneToLightning>
				if (damagesource.is(DamageTypes.LIGHTNING_BOLT))
					return false;
			</#if>
			<#if data.immuneToExplosion>
				if (damagesource.is(DamageTypes.EXPLOSION))
					return false;
			</#if>
			<#if data.immuneToTrident>
				if (damagesource.is(DamageTypes.TRIDENT))
					return false;
			</#if>
			<#if data.immuneToAnvil>
				if (damagesource.is(DamageTypes.FALLING_ANVIL))
					return false;
			</#if>
			<#if data.immuneToDragonBreath>
				if (damagesource.is(DamageTypes.DRAGON_BREATH))
					return false;
			</#if>
			<#if data.immuneToWither>
				if (damagesource.is(DamageTypes.WITHER))
					return false;
				if (damagesource.is(DamageTypes.WITHER_SKULL))
					return false;
			</#if>
			return super.hurt(damagesource, amount);
		}
	</#if>

	<#if hasProcedure(data.whenMobDies)>
		@Override public void die(DamageSource source) {
			super.die(source);
			<@procedureCode data.whenMobDies, {
				"x": "this.getX()",
				"y": "this.getY()",
				"z": "this.getZ()",
				"sourceentity": "source.getEntity()",
				"immediatesourceentity": "source.getDirectEntity()",
				"entity": "this",
				"world": "this.level",
				"damagesource": "source"
			}/>
		}
	</#if>

		<#if hasProcedure(data.onInitialSpawn)>
			@Override public SpawnGroupData finalizeSpawn(ServerLevelAccessor world, DifficultyInstance difficulty,
					MobSpawnType reason, @Nullable SpawnGroupData livingdata, @Nullable CompoundTag tag) {
				SpawnGroupData retval = super.finalizeSpawn(world, difficulty, reason, livingdata, tag);
				<@procedureCode data.onInitialSpawn, {
					"x": "this.getX()",
					"y": "this.getY()",
					"z": "this.getZ()",
					"world": "world",
					"entity": "this"
				}/>
				return retval;
			}
		</#if>

	<#if data.guiBoundTo?has_content && data.guiBoundTo != "<NONE>">
		private final SimpleContainer inventory = new SimpleContainer(${data.inventorySize}) {
			@Override
			public int getMaxStackSize() {
				return ${data.inventoryStackSize};
			}
		};

		@Override protected void dropEquipment() {
			super.dropEquipment();
			for (int i = 0; i < inventory.getContainerSize(); ++i) {
				ItemStack itemstack = inventory.getItem(i);
				if (!itemstack.isEmpty() && !EnchantmentHelper.hasVanishingCurse(itemstack)) {
					this.spawnAtLocation(itemstack);
				}
			}
		}
	</#if>

	<#if data.entityDataEntries?has_content || (data.guiBoundTo?has_content && data.guiBoundTo != "<NONE>")>
		@Override public void addAdditionalSaveData(CompoundTag compound) {
		super.addAdditionalSaveData(compound);
			<#list data.entityDataEntries as entry>
				<#if entry.value().getClass().getSimpleName() == "Integer">
					compound.putInt("Data${entry.property().getName()}", this.entityData.get(DATA_${entry.property().getName()}));
				<#elseif entry.value().getClass().getSimpleName() == "Boolean">
					compound.putBoolean("Data${entry.property().getName()}", this.entityData.get(DATA_${entry.property().getName()}));
				<#elseif entry.value().getClass().getSimpleName() == "String">
					compound.putString("Data${entry.property().getName()}", this.entityData.get(DATA_${entry.property().getName()}));
				</#if>
			</#list>
			<#if data.guiBoundTo?has_content && data.guiBoundTo != "<NONE>">
				compound.put("InventoryCustom", serializeNBT());
			</#if>
		}
		
		private CompoundTag serializeNBT() {
			ListTag nbtTagList = new ListTag();
			for (int i = 0; i < inventory.items.size(); i++) {
				if (!inventory.items.get(i).isEmpty()) {
					CompoundTag itemTag = new CompoundTag();
					itemTag.putInt("Slot", i);
					inventory.items.get(i).save(itemTag);
					nbtTagList.add(itemTag);
				}
			}
			CompoundTag nbt = new CompoundTag();
			nbt.put("Items", nbtTagList);
			nbt.putInt("Size", inventory.items.size());

			return nbt;
		}
		
		private void deserializeNBT(CompoundTag nbt) {
			ListTag tagList = nbt.getList("Items", Tag.TAG_COMPOUND);
			for (int i = 0; i < tagList.size(); i++) {
				CompoundTag itemTags = tagList.getCompound(i);
				int slot = itemTags.getInt("Slot");
				if (slot >= 0 && slot < inventory.items.size())
					inventory.items.set(slot, ItemStack.of(itemTags));
			}
		}

		@Override public void readAdditionalSaveData(CompoundTag compound) {
			super.readAdditionalSaveData(compound);
			<#list data.entityDataEntries as entry>
				if (compound.contains("Data${entry.property().getName()}"))
					<#if entry.value().getClass().getSimpleName() == "Integer">
						this.entityData.set(DATA_${entry.property().getName()}, compound.getInt("Data${entry.property().getName()}"));
					<#elseif entry.value().getClass().getSimpleName() == "Boolean">
						this.entityData.set(DATA_${entry.property().getName()}, compound.getBoolean("Data${entry.property().getName()}"));
					<#elseif entry.value().getClass().getSimpleName() == "String">
						this.entityData.set(DATA_${entry.property().getName()}, compound.getString("Data${entry.property().getName()}"));
					</#if>
			</#list>
			<#if data.guiBoundTo?has_content && data.guiBoundTo != "<NONE>">
				if (compound.get("InventoryCustom") instanceof CompoundTag inventoryTag)
					deserializeNBT(inventoryTag);
			</#if>
		}
	</#if>

	<#if hasProcedure(data.onRightClickedOn) || data.ridable || (data.tameable && data.breedable) || (data.guiBoundTo?has_content && data.guiBoundTo != "<NONE>")>
		@Override public InteractionResult mobInteract(Player sourceentity, InteractionHand hand) {
			ItemStack itemstack = sourceentity.getItemInHand(hand);
			InteractionResult retval = InteractionResult.sidedSuccess(this.level().isClientSide());

			<#if data.guiBoundTo?has_content && data.guiBoundTo != "<NONE>">
				<#if data.ridable>
					if (sourceentity.isSecondaryUseActive()) {
				</#if>
					if(sourceentity instanceof ServerPlayer serverPlayer) {
						serverPlayer.openMenu(new ExtendedScreenHandlerFactory() {

							@Override
							public void writeScreenOpeningData(ServerPlayer player, FriendlyByteBuf packetBuffer) {
								packetBuffer.writeBlockPos(sourceentity.blockPosition());
								packetBuffer.writeByte(0);
								packetBuffer.writeVarInt(${name}Entity.this.getId());
							}

							@Override
							public Component getDisplayName() {
								return Component.literal("${data.mobName}");
							}

							@Override
							public AbstractContainerMenu createMenu(int syncId, Inventory inv, Player player) {
								return new ${data.guiBoundTo}Menu(syncId, inv, inventory);
							}
						});
					}
				<#if data.ridable>
						return InteractionResult.sidedSuccess(this.level().isClientSide());
					}
				</#if>
			</#if>

			<#if (data.tameable && data.breedable)>
				Item item = itemstack.getItem();
				if (itemstack.getItem() instanceof SpawnEggItem) {
					retval = super.mobInteract(sourceentity, hand);
				} else if (this.level().isClientSide()) {
					retval = (this.isTame() && this.isOwnedBy(sourceentity) || this.isFood(itemstack))
							? InteractionResult.sidedSuccess(this.level().isClientSide()) : InteractionResult.PASS;
				} else {
					if (this.isTame()) {
						if (this.isOwnedBy(sourceentity)) {
							if (item.isEdible() && this.isFood(itemstack) && this.getHealth() < this.getMaxHealth()) {
								this.usePlayerItem(sourceentity, hand, itemstack);
								this.heal((float)item.getFoodProperties().getNutrition());
								retval = InteractionResult.sidedSuccess(this.level().isClientSide());
							} else if (this.isFood(itemstack) && this.getHealth() < this.getMaxHealth()) {
								this.usePlayerItem(sourceentity, hand, itemstack);
								this.heal(4);
								retval = InteractionResult.sidedSuccess(this.level().isClientSide());
							} else {
								retval = super.mobInteract(sourceentity, hand);
							}
						}
					} else if (this.isFood(itemstack)) {
						this.usePlayerItem(sourceentity, hand, itemstack);
						if (this.random.nextInt(3) == 0) {
							this.tame(sourceentity);
							this.level().broadcastEntityEvent(this, (byte) 7);
						} else {
							this.level().broadcastEntityEvent(this, (byte) 6);
						}

						this.setPersistenceRequired();
						retval = InteractionResult.sidedSuccess(this.level().isClientSide());
					} else {
						retval = super.mobInteract(sourceentity, hand);
						if (retval == InteractionResult.SUCCESS || retval == InteractionResult.CONSUME)
							this.setPersistenceRequired();
					}
				}
			<#else>
				super.mobInteract(sourceentity, hand);
			</#if>

			<#if data.ridable>
				sourceentity.startRiding(this);
			</#if>

			<#if hasProcedure(data.onRightClickedOn)>
				double x = this.getX();
				double y = this.getY();
				double z = this.getZ();
				Entity entity = this;
				Level world = this.level();
				<#if hasReturnValueOf(data.onRightClickedOn, "actionresulttype")>
					return <@procedureOBJToInteractionResultCode data.onRightClickedOn/>;
				<#else>
					<@procedureOBJToCode data.onRightClickedOn/>
					return retval;
				</#if>
			<#else>
				return retval;
			</#if>
		}
	</#if>

	<#if hasProcedure(data.whenThisMobKillsAnother)>
		@Override public void awardKillScore(Entity entity, int score, DamageSource damageSource) {
			super.awardKillScore(entity, score, damageSource);
			<@procedureCode data.whenThisMobKillsAnother, {
				"x": "this.getX()",
				"y": "this.getY()",
				"z": "this.getZ()",
				"entity": "entity",
				"sourceentity": "this",
				"immediatesourceentity": "damageSource.getDirectEntity()",
				"world": "this.level",
				"damagesource": "damageSource"
			}/>
		}
	</#if>

	<#if hasProcedure(data.onMobTickUpdate)>
		@Override public void baseTick() {
			super.baseTick();
			double x = this.getX();
			double y = this.getY();
			double z = this.getZ();
			Entity entity = this;
			Level world = this.level();
			<@procedureOBJToCode data.onMobTickUpdate/>
		}
	</#if>

	<#if hasProcedure(data.onPlayerCollidesWith)>
		@Override public void playerTouch(Player sourceentity) {
			super.playerTouch(sourceentity);
			Entity entity = this;
			Level world = this.level();
			double x = this.getX();
			double y = this.getY();
			double z = this.getZ();
			<@procedureOBJToCode data.onPlayerCollidesWith/>
		}
	</#if>
	
	<#if data.ranged>
		@Override public void performRangedAttack(LivingEntity target, float flval) {
			<#if data.rangedItemType == "Default item">
				Arrow entityarrow = new Arrow(this.level(), this);
				double d0 = target.getY() + target.getEyeHeight() - 1.1;
				double d1 = target.getX() - this.getX();
				double d3 = target.getZ() - this.getZ();
				entityarrow.shoot(d1, d0 - entityarrow.getY() + Math.sqrt(d1 * d1 + d3 * d3) * 0.2F, d3, 1.6F, 12.0F);
				level.addFreshEntity(entityarrow);
			<#else>
				${data.rangedItemType}Entity.shoot(this, target);
			</#if>
		}
   	</#if>

	<#if data.breedable>
		@Override public AgeableMob getBreedOffspring(ServerLevel serverWorld, AgeableMob ageable) {
			${name}Entity retval = ${JavaModName}Entities.${data.getModElement().getRegistryNameUpper()}.create(serverWorld);
			retval.finalizeSpawn(serverWorld, serverWorld.getCurrentDifficultyAt(retval.blockPosition()), MobSpawnType.BREEDING, null, null);
			return retval;
		}

		@Override public boolean isFood(ItemStack stack) {
			return ${mappedMCItemsToIngredient(data.breedTriggerItems)}.test(stack);
		}
	</#if>

	<#if data.waterMob>
	@Override public boolean checkSpawnObstruction(LevelReader world) {
		return world.isUnobstructed(this);
	}
	</#if>

	<#if data.breatheUnderwater?? && (hasProcedure(data.breatheUnderwater) || data.breatheUnderwater.getFixedValue())>
	@Override public boolean canBreatheUnderwater() {
		double x = this.getX();
		double y = this.getY();
		double z = this.getZ();
		Level world = this.level();
		Entity entity = this;
		return <@procedureOBJToConditionCode data.breatheUnderwater true false/>;
	}
	</#if>

	<#if data.pushedByFluids?? && (hasProcedure(data.pushedByFluids) || !data.pushedByFluids.getFixedValue())>
	@Override public boolean isPushedByFluid() {
		double x = this.getX();
		double y = this.getY();
		double z = this.getZ();
		Level world = this.level();
		Entity entity = this;
		return <@procedureOBJToConditionCode data.pushedByFluids false false/>;
	}
	</#if>

	<#if data.disableCollisions>
	@Override public boolean isPushable() {
		return false;
	}

   	@Override protected void doPush(Entity entityIn) {
   	}

   	@Override protected void pushEntities() {
   	}
	</#if>
	
	<#if hasProcedure(data.solidBoundingBox) || data.solidBoundingBox.getFixedValue()>
		@Override
		public boolean canCollideWith(Entity entity) {
			return true;
		}
	
		@Override
		public boolean canBeCollidedWith() {
			<#if hasProcedure(data.solidBoundingBox)>
			Entity entity = this;
			Level world = entity.level;
			double x = entity.getX();
			double y = entity.getY();
			double z = entity.getZ();
			</#if>
			return <@procedureOBJToConditionCode data.solidBoundingBox true false/>;
		}
	</#if>

	<#if data.isBoss>
	@Override public boolean canChangeDimensions() {
		return false;
	}

	@Override public void startSeenByPlayer(ServerPlayer player) {
		super.startSeenByPlayer(player);
		this.bossInfo.addPlayer(player);
	}

	@Override public void stopSeenByPlayer(ServerPlayer player) {
		super.stopSeenByPlayer(player);
		this.bossInfo.removePlayer(player);
	}

	@Override public void customServerAiStep() {
		super.customServerAiStep();
		this.bossInfo.setProgress(this.getHealth() / this.getMaxHealth());
	}
	</#if>

	<#if hasProcedure(data.solidBoundingBox) || data.solidBoundingBox.getFixedValue()>
		@Override
		public boolean canCollideWith(Entity entity) {
			return true;
		}

		@Override
		public boolean canBeCollidedWith() {
			<#if hasProcedure(data.solidBoundingBox)>
				Entity entity = this;
				Level world = entity.level();
				double x = entity.getX();
				double y = entity.getY();
				double z = entity.getZ();
			</#if>
			return <@procedureOBJToConditionCode data.solidBoundingBox true false/>;
		}
	</#if>

	<#if data.ridable && (data.canControlForward || data.canControlStrafe)>
		@Override public void travel(Vec3 dir) {
			<#if data.canControlForward || data.canControlStrafe>
			Entity entity = this.getPassengers().isEmpty() ? null : (Entity) this.getPassengers().get(0);
			if (this.isVehicle()) {
				this.setYRot(entity.getYRot());
				this.yRotO = this.getYRot();
				this.setXRot(entity.getXRot() * 0.5F);
				this.setRot(this.getYRot(), this.getXRot());
				this.flyingSpeed = this.getSpeed() * 0.15F;
				this.yBodyRot = entity.getYRot();
				this.yHeadRot = entity.getYRot();

				if (entity instanceof LivingEntity passenger) {
					this.setSpeed((float) this.getAttributeValue(Attributes.MOVEMENT_SPEED));

					<#if data.canControlForward>
						float forward = passenger.zza;
					<#else>
						float forward = 0;
					</#if>

					<#if data.canControlStrafe>
						float strafe = passenger.xxa;
					<#else>
						float strafe = 0;
					</#if>

					super.travel(new Vec3(strafe, 0, forward));
				}

				this.animationSpeedOld = this.animationSpeed;
				double d1 = this.getX() - this.xo;
				double d0 = this.getZ() - this.zo;
				float f1 = (float) Math.sqrt(d1 * d1 + d0 * d0) * 4;
				if (f1 > 1.0F) f1 = 1.0F;
				this.animationSpeed += (f1 - this.animationSpeed) * 0.4F;
				this.animationPosition += this.animationSpeed;
				return;
			}
			this.flyingSpeed = 0.02F;
			</#if>

			super.travel(dir);
		}
	</#if>

	<#if data.flyingMob>
		@Override protected void checkFallDamage(double y, boolean onGroundIn, BlockState state, BlockPos pos) {
		}

		@Override public void setNoGravity(boolean ignored) {
			super.setNoGravity(true);
		}
	</#if>

	<#if data.flyingMob>
		public void aiStep() {
			super.aiStep();
			this.setNoGravity(true);
		}
	</#if>

	public static void init() {
		<#if data.spawnThisMob>BiomeModifications.create(new ResourceLocation(${JavaModName}.MODID, "${name?lower_case}_entity_spawn"))
			.add(ModificationPhase.ADDITIONS, BiomeSelectors.
				<#if data.restrictionBiomes?has_content>
					includeByKey(
						<#list data.restrictionBiomes as restrictionBiome>
							ResourceKey.create(Registries.BIOME, new ResourceLocation("${restrictionBiome}"))<#if restrictionBiome?has_next>,</#if>
						</#list>
					)
				<#else>
					all()
				</#if>, ctx -> ctx.getSpawnSettings().addSpawn(${generator.map(data.mobSpawningType, "mobspawntypes")},
					new MobSpawnSettings.SpawnerData(${JavaModName}Entities.${data.getModElement().getRegistryNameUpper()}, ${data.spawningProbability}, ${data.minNumberOfMobsPerGroup}, ${data.maxNumberOfMobsPerGroup})));
		</#if>
	}

	public static AttributeSupplier.Builder createAttributes() {
		AttributeSupplier.Builder builder = Mob.createMobAttributes();
		builder = builder.add(Attributes.MOVEMENT_SPEED, ${data.movementSpeed});
		builder = builder.add(Attributes.MAX_HEALTH, ${data.health});
		builder = builder.add(Attributes.ARMOR, ${data.armorBaseValue});
		builder = builder.add(Attributes.ATTACK_DAMAGE, ${data.attackStrength});
		builder = builder.add(Attributes.FOLLOW_RANGE, ${data.followRange});

		<#if (data.knockbackResistance > 0)>
		builder = builder.add(Attributes.KNOCKBACK_RESISTANCE, ${data.knockbackResistance});
		</#if>

		<#if (data.attackKnockback > 0)>
		builder = builder.add(Attributes.ATTACK_KNOCKBACK, ${data.attackKnockback});
		</#if>

		<#if data.flyingMob>
		builder = builder.add(Attributes.FLYING_SPEED, ${data.movementSpeed});
		</#if>

		<#if data.aiBase == "Zombie">
		builder = builder.add(Attributes.SPAWN_REINFORCEMENTS_CHANCE);
		</#if>

		return builder;
	}

}
</#compress>
<#-- @formatter:on -->
