<#--
This file is part of Fabric-Generator-MCreator.

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
<#include "../biomes.java.ftl">
<#include "../mcitems.ftl">
<#include "../procedures.java.ftl">
<#include "../particles.java.ftl">

package ${package}.entity;

import net.fabricmc.fabric.api.object.builder.v1.entity.FabricDefaultAttributeRegistry;
import net.fabricmc.fabric.api.object.builder.v1.entity.FabricEntityTypeBuilder;

@SuppressWarnings("deprecation")
<#assign extendsClass = "Passive">
	<#if data.aiBase != "(none)" >
	    <#assign extendsClass = data.aiBase>
	<#else>
	    <#assign extendsClass = data.mobBehaviourType.replace("Mob", "Hostile").replace("Creature", "Passive")>
	</#if>

	<#if data.breedable>
	    <#assign extendsClass = "Animal">
	</#if>

	<#if data.tameable>
		<#assign extendsClass = "Tameable">
	</#if>
public class ${name}Entity extends ${extendsClass}Entity {

    public static final EntityType<${name}Entity> ENTITY = Registry.register(
            Registry.ENTITY_TYPE,
            ${JavaModName}.id("${registryname}"),
            FabricEntityTypeBuilder.create(${generator.map(data.mobSpawningType, "mobspawntypes")}, ${name}Entity::new)
            .dimensions(EntityDimensions.fixed(${data.modelWidth}f, ${data.modelHeight}f))
            <#if data.immuneToFire>.fireImmune()</#if>
            .trackRangeBlocks(${data.trackingRange})
            .forceTrackedVelocityUpdates(true).trackedUpdateRate(3)
            .build()
    );

    <#if data.isBoss>
        private final ServerBossBar bossBar;
    </#if>

    protected ${name}Entity(EntityType<? extends ${name}Entity> entityType, World world) {
        super(entityType, world);
		this.setAiDisabled(${(!data.hasAI)});
		this.experiencePoints = ${data.xpAmount};

        <#if data.isBoss>
            this.bossBar = new ServerBossBar(this.getDisplayName(), BossBar.Color.${data.bossBarColor}, BossBar.Style.${data.bossBarType});
        </#if>

		<#if data.mobLabel?has_content >
            setCustomName(new StringTextComponent("${data.mobLabel}"));
            setCustomNameVisible(true);
        </#if>

		<#if !data.doesDespawnWhenIdle>
            setPersistent();
        </#if>

		<#if !data.equipmentMainHand.isEmpty()>
            this.equipLootStack(EquipmentSlot.MAINHAND, ${mappedMCItemToItemStackCode(data.equipmentMainHand, 1)});
        </#if>
        <#if !data.equipmentOffHand.isEmpty()>
            this.equipLootStack(EquipmentSlot.OFFHAND, ${mappedMCItemToItemStackCode(data.equipmentOffHand, 1)});
            </#if>
        <#if !data.equipmentHelmet.isEmpty()>
            this.equipLootStack(EquipmentSlot.HEAD, ${mappedMCItemToItemStackCode(data.equipmentHelmet, 1)});
        </#if>
        <#if !data.equipmentBody.isEmpty()>
            this.equipLootStack(EquipmentSlot.CHEST, ${mappedMCItemToItemStackCode(data.equipmentBody, 1)});
        </#if>
        <#if !data.equipmentLeggings.isEmpty()>
            this.equipLootStack(
		EquipmentSlot.LEGS, ${mappedMCItemToItemStackCode(data.equipmentLeggings, 1)});
        </#if>
        <#if !data.equipmentBoots.isEmpty()>
            this.equipLootStack(EquipmentSlot.FEET, ${mappedMCItemToItemStackCode(data.equipmentBoots, 1)});
        </#if>
        <#if data.flyingMob>
            this.moveControl = new FlightMoveControl(this, 10, true);
            this.navigation = new BirdNavigation(this, this.world);
        </#if>

        <#if data.waterMob>
        this.moveControl = new MoveControl(this) {
            @Override
            public void tick() {
                if (this.entity.isSubmergedIn(FluidTags.WATER))
                    this.entity.setVelocity(this.entity.getVelocity().add(0, 0.005d, 0));

                if (this.state == MoveControl.State.MOVE_TO && !this.entity.getNavigation().isIdle()) {
                    double dx = this.targetX - this.entity.getX();
                    double dy = this.targetY - this.entity.getY();
                    double dz = this.targetZ - this.entity.getZ();
                    dy = dy / (double) MathHelper.sqrt(dx * dx + dy * dy + dz * dz);
                    this.entity.yaw = this.changeAngle(this.entity.yaw,
                        (float)(MathHelper.atan2(dz, dx) * (double) (180 / (float) Math.PI)) - 90, 90);
                    this.entity.bodyYaw = this.entity.yaw;
                    this.entity.setMovementSpeed(MathHelper.lerp(0.125f, this.entity.getMovementSpeed(),
                        (float)(this.speed * this.entity.getAttributeValue(EntityAttributes.GENERIC_MOVEMENT_SPEED))));
                    this.entity.setVelocity(this.entity.getVelocity().add(0, this.entity.getMovementSpeed() * dy * 0.1, 0));
                    } else {
                        this.entity.setMovementSpeed(0);
                    }
            }
        };
        this.navigation = new SwimNavigation(this, this.world);
        </#if>
    }

    public static void init() {
        FabricDefaultAttributeRegistry.register(ENTITY, ${name}Entity.createMobAttributes().add(EntityAttributes.GENERIC_MAX_HEALTH, ${data.health})
                .add(EntityAttributes.GENERIC_MOVEMENT_SPEED, ${data.movementSpeed})
                .add(EntityAttributes.GENERIC_ARMOR, ${data.armorBaseValue})
                .add(EntityAttributes.GENERIC_ATTACK_DAMAGE, ${data.attackStrength})

            <#if (data.knockbackResistance > 0)>
                .add(EntityAttributes.GENERIC_KNOCKBACK_RESISTANCE, ${data.knockbackResistance})
            </#if>

            <#if (data.attackKnockback > 0)>
                .add(EntityAttributes.GENERIC_ATTACK_KNOCKBACK, ${data.attackKnockback})
            </#if>

            <#if data.flyingMob>
                .add(EntityAttributes.GENERIC_FLYING_SPEED, 10)
            </#if>

            <#if data.aiBase == "Zombie">
                .add(EntityAttributes.ZOMBIE_SPAWN_REINFORCEMENTS)
            </#if>
        );

	<#if data.hasSpawnEgg>
        Registry.register(Registry.ITEM, ${JavaModName}.id("${registryname}_spawn_egg"),
                new SpawnEggItem(ENTITY, ${data.spawnEggBaseColor.getRGB()}, ${data.spawnEggDotColor.getRGB()}, new FabricItemSettings()<#if data.creativeTab??>.group(${data.creativeTab})<#else>.group(ItemGroup.MISC)</#if>));
        </#if>

        <#if data.spawnThisMob>
        BiomeModifications.create(new Identifier("${modid}", "${name?lower_case}_entity_spawn")).add(ModificationPhase.ADDITIONS,
                BiomeSelectors.<#if data.restrictionBiomes?has_content>includeByKey(<@biomeKeys data.restrictionBiomes/>)<#else>all()</#if>, ctx -> ctx.getSpawnSettings().addSpawn(${generator.map(data.mobSpawningType, "mobspawntypes")},
                        new SpawnSettings.SpawnEntry(ENTITY, ${data.spawningProbability}, ${data.minNumberOfMobsPerGroup}, ${data.maxNumberOfMobsPerGroup})));
        </#if>
    }

	<#if data.hasAI>
		@Override
        protected void initGoals() {
            super.initGoals();
			<#if aicode??>
                ${aicode}
            </#if>
		}
	</#if>

	<#if data.waterMob>
	    @Override
    	    public boolean canBreatheInWater() {
    		    return true;
    	    }
	</#if>

    <#if data.stepSound?has_content && data.stepSound.getMappedValue()?has_content>
        @Override
        public void playStepSound(BlockPos pos, BlockState state) {
            this.playSound(<#if data.stepSound?contains(modid)>${JavaModName}.${data.stepSound?remove_beginning(modid + ":")}Event<#elseif (data.stepSound?length > 0)>
                               SoundEvents.${data.stepSound}<#else>null</#if>, 0.15f, 1);
     	}
    </#if>

    <#if !data.mobDrop.isEmpty()>
        @Override
    	protected void dropLoot(DamageSource source, boolean causedByPlayer) {
    	    super.dropLoot(source, causedByPlayer);
    	    this.dropStack((${mappedMCItemToItemStackCode(data.mobDrop, 1)});
    	}
    </#if>

    @Nullable
    @Override
    protected SoundEvent getAmbientSound() {
        return <#if data.livingSound?contains(modid)>${JavaModName}.${data.livingSound?remove_beginning(modid + ":")}Event<#elseif (data.livingSound?length > 0)>
               SoundEvents.${data.livingSound}<#else>null</#if>;
    }

    @Nullable
	@Override
	protected SoundEvent getHurtSound(DamageSource source) {
		return <#if data.hurtSound?contains(modid)>${JavaModName}.${data.hurtSound?remove_beginning(modid + ":")}Event<#elseif (data.hurtSound?length > 0)>
                SoundEvents.${data.hurtSound}<#else>null</#if>;
	}

    @Nullable
	@Override
	protected SoundEvent getDeathSound() {
		return <#if data.deathSound?contains(modid)>${JavaModName}.${data.deathSound?remove_beginning(modid + ":")}Event<#elseif (data.deathSound?length > 0)>
                 SoundEvents.${data.deathSound}<#else>null</#if>;
	}

    <#if data.stepSound?has_content && data.stepSound.getMappedValue()?has_content>
	@Override
	public void playStepSound(BlockPos pos, BlockState blockIn) {
	    this.playSound(<#if data.stepSound?contains(modid)>${JavaModName}.${data.stepSound?remove_beginning(modid + ":")}Event
	        <#elseif (data.stepSound?length > 0)>SoundEvents.${data.stepSound}<#else>null</#if>, 0.15f, 1);
	}
	</#if>

    <#if data.isBoss>
        @Override
        public void readCustomDataFromTag(CompoundTag tag) {
            super.readCustomDataFromTag(tag);
            if (this.hasCustomName()) {
             this.bossBar.setName(this.getDisplayName());
            }
        }

        @Override
        public void setCustomName(@Nullable Text name) {
            super.setCustomName(name);
            this.bossBar.setName(this.getDisplayName());
        }

        @Override
        protected void mobTick() {
            super.mobTick();
            this.bossBar.setPercent(this.getHealth() / this.getMaxHealth());
        }

        @Override
        public void onStartedTrackingBy(ServerPlayerEntity player) {
            super.onStartedTrackingBy(player);
            this.bossBar.addPlayer(player);
        }

	    @Override
	    public void onStoppedTrackingBy(ServerPlayerEntity player) {
		    super.onStoppedTrackingBy(player);
		    this.bossBar.removePlayer(player);
	    }
    </#if>

    <#if data.spawnParticles>
        @Override
        public void tick() {
            super.tick();
	        double x = this.getX();
	    	double y = this.getY();
	    	double z = this.getZ();
            Random random = this.random;
            Entity entity = this;
            <@particles data.particleSpawningShape data.particleToSpawn data.particleSpawningRadious data.particleAmount data.particleCondition/>
        }
    </#if>

    <#if data.ridable && (data.canControlForward || data.canControlStrafe)>
        @Override
        public void travel(Vec3d dir) {
        <#if data.canControlForward || data.canControlStrafe>
		    Entity entity = this.getPassengerList().isEmpty() ? null : (Entity) this.getPassengerList().get(0);
			if (this.hasPlayerRider()) {
			    this.yaw = entity.yaw;
				this.prevYaw = this.yaw;
				this.pitch = entity.pitch * 0.5F;
				this.setRotation(this.yaw, this.pitch);
				this.flyingSpeed = this.getMovementSpeed() * 0.15F;
				this.bodyYaw = entity.yaw;
				this.headYaw = entity.yaw;
				this.stepHeight = 1.0F;

			    if (entity instanceof LivingEntity) {
				    this.setMovementSpeed((float) this.getAttributeValue(EntityAttributes.GENERIC_MOVEMENT_SPEED));

			    <#if data.canControlForward>
				    float forward = ((LivingEntity) entity).forwardSpeed;
			    <#else>
				    float forward = 0;
			    </#if>

			    <#if data.canControlStrafe>
			    	float strafe = ((LivingEntity) entity).sidewaysSpeed;
			    <#else>
			    	float strafe = 0;
			    </#if>

			        super.travel(new Vec3d(strafe, 0, forward));
		        }

			    this.prevHorizontalSpeed = this.horizontalSpeed;
			    double d1 = this.getX() - this.prevX;
			    double d0 = this.getZ() - this.prevZ;
			    float f1 = MathHelper.sqrt(d1 * d1 + d0 * d0) * 4.0F;
			    if (f1 > 1.0F) f1 = 1.0F;
			    this.horizontalSpeed += (f1 - this.horizontalSpeed) * 0.4F;
			    this.limbAngle += this.horizontalSpeed;
			    return;
			}
			this.stepHeight = 0.5F;
			this.flyingSpeed = 0.02F;
		</#if>

		super.travel(dir);
	}
    </#if>

	<#if hasProcedure(data.onStruckByLightning)>
	@Override public void onStruckByLightning(ServerWorld serverWorld, LightningEntity lightningEntity) {
		super.onStruckByLightning(serverWorld, lightningEntity);
		double x = this.getX();
		double y = this.getY();
		double z = this.getZ();
		Entity entity = this;
		<@procedureOBJToCode data.onStruckByLightning/>
	}
    </#if>

	<#if hasProcedure(data.whenMobFalls) || data.flyingMob>
		@Override
		public boolean handleFallDamage(float l, float d) {
		    double x = this.getX();
			double y = this.getY();
			double z = this.getZ();
			Entity entity = this;
			<@procedureOBJToCode data.whenMobFalls/>

			return super.handleFallDamage(l, d);
		}
    </#if>

    <#if hasProcedure(data.whenMobIsHurt) || data.immuneToArrows || data.immuneToFallDamage
    || data.immuneToCactus || data.immuneToDrowning || data.immuneToLightning || data.immuneToPotions
    || data.immuneToPlayer || data.immuneToExplosion || data.immuneToTrident || data.immuneToAnvil
    || data.immuneToDragonBreath || data.immuneToWither>
        @Override
        	public boolean damage(DamageSource source, float amount) {
        	    <#if hasProcedure(data.whenMobIsHurt)>
	            double x = this.getX();
	            double y = this.getY();
	            double z = this.getZ();
                	Entity entity = this;
                	Entity sourceentity = source.getAttacker();
                	<@procedureOBJToCode data.whenMobIsHurt/>
                </#if>
                
                <#if data.immuneToArrows>
                	if (source.getSource() instanceof ArrowEntity)
                	return false;
                </#if>
                <#if data.immuneToPlayer>
                	if (source.getSource() instanceof PlayerEntity)
                	return false;
                </#if>
                <#if data.immuneToPotions>
                	if (source.getSource() instanceof PotionEntity)
                	return false;
                </#if>
                <#if data.immuneToFallDamage>
                	if (source == DamageSource.FALL)
                	return false;
                </#if>
                <#if data.immuneToCactus>
                	if (source == DamageSource.CACTUS)
                	return false;
                </#if>
                <#if data.immuneToDrowning>
                	if (source == DamageSource.DROWN)
                	return false;
                </#if>
                <#if data.immuneToLightning>
                	if (source == DamageSource.LIGHTNING_BOLT)
                	return false;
                </#if>
                <#if data.immuneToExplosion>
                	if (source.isExplosive())
                	return false;
                </#if>
                <#if data.immuneToTrident>
                	if (source.getName().equals("trident"))
                	return false;
                </#if>
                <#if data.immuneToAnvil>
                	if (source == DamageSource.ANVIL)
                	return false;
                </#if>
                <#if data.immuneToDragonBreath>
                	if (source == DamageSource.DRAGON_BREATH)
                	return false;
                </#if>
                <#if data.immuneToWither>
                	if (source == DamageSource.WITHER)
                	return false;
                	if (source.getName().equals("witherSkull"))
                	return false;
                </#if>
        	return super.damage(source, amount);
        	}
    </#if>

	<#if hasProcedure(data.whenMobDies)>
	@Override
	public void onDeath(DamageSource source) {
		super.onDeath(source);
		double x = this.getX();
		double y = this.getY();
		double z = this.getZ();
		Entity sourceentity = source.getAttacker();
		Entity entity = this;
		<@procedureOBJToCode data.whenMobDies/>
	}
        </#if>

	<#if hasProcedure(data.onInitialSpawn)>
	@Nullable
    @Override
    public EntityData initialize(ServerWorldAccess world, LocalDifficulty difficulty, SpawnReason spawnReason, @Nullable EntityData entityData, @Nullable CompoundTag entityTag) {
        EntityData retval = super.initialize(world, difficulty, spawnReason, entityData, entityTag);
		double x = this.getX();
		double y = this.getY();
		double z = this.getZ();
		Entity entity = this;
		<@procedureOBJToCode data.onInitialSpawn/>

        return retval;
    }
    </#if>

    <#if hasProcedure(data.onRightClickedOn) || data.tameable || data.ridable>
	    @Override
	    public ActionResult interactMob(PlayerEntity sourceentity, Hand hand) {
		    ItemStack itemstack = sourceentity.getStackInHand(hand);
            ActionResult retval = ActionResult.success(this.world.isClient);
        <#if data.tameable>
            Item item = itemstack.getItem();
            if (this.world.isClient) {
                if (this.isTamed() && this.isOwner(sourceentity)) {
                    return ActionResult.SUCCESS;
                } else {
                    return !this.isBreedingItem(itemstack) || !(this.getHealth() < this.getMaxHealth()) && this.isTamed() ? ActionResult.PASS : ActionResult.SUCCESS;
                }
            } else {
                if (this.isTamed()) {
                    if (this.isOwner(sourceentity)) {
                        if (!(item instanceof DyeItem)) {
                            if (item.isFood() && this.isBreedingItem(itemstack) && this.getHealth() < this.getMaxHealth()) {
                                this.eat(sourceentity, itemstack);
                                this.heal((float)item.getFoodComponent().getHunger());
                                return ActionResult.CONSUME;
                            }

                            retval = super.interactMob(sourceentity, hand);
                            if (!retval.isAccepted() || this.isBaby()) {
                                this.setSitting(!this.isSitting());
                            }

                            return retval;
                        }
                    }
                } else if (this.isBreedingItem(itemstack)) {
                    this.eat(sourceentity, itemstack);
                    if (this.random.nextInt(3) == 0) {
                        this.setOwner(sourceentity);
                        this.setSitting(true);
                        this.world.sendEntityStatus(this, (byte)7);
                    } else {
                        this.world.sendEntityStatus(this, (byte)6);
                    }

                    this.setPersistent();
                    return ActionResult.CONSUME;
                }

                retval = super.interactMob(sourceentity, hand);
                if (retval.isAccepted()) {
                    this.setPersistent();
                }
            }
        </#if>

		<#if data.ridable>
            sourceentity.startRiding(this);
        </#if>

			double x = this.getX();
			double y = this.getY();
			double z = this.getZ();
			Entity entity = this;
			<@procedureOBJToCode data.onRightClickedOn/>
		    return retval;
		}    
    </#if>

	<#if hasProcedure(data.whenThisMobKillsAnother)>
	public void updateKilledAdvancementCriterion(Entity entity, int score, DamageSource damageSource) {
		super.updateKilledAdvancementCriterion(entity, score, damageSource);
			double x = this.getX();
			double y = this.getY();
			double z = this.getZ();
			Entity sourceentity = this;
			<@procedureOBJToCode data.whenThisMobKillsAnother/>
		}
    </#if>

	<#if hasProcedure(data.onMobTickUpdate)>
		@Override public void baseTick() {
			super.baseTick();
			double x = this.getX();
			double y = this.getY();
			double z = this.getZ();
			Entity entity = this;
			<@procedureOBJToCode data.onMobTickUpdate/>
		}
    </#if>

	<#if hasProcedure(data.onPlayerCollidesWith)>
		@Override public void onPlayerCollision(PlayerEntity sourceentity) {
			super.onPlayerCollision(sourceentity);
			Entity entity = this;
			double x = this.getX();
			double y = this.getY();
			double z = this.getZ();
			<@procedureOBJToCode data.onPlayerCollidesWith/>
		}
    </#if>

    <#if data.breedable>
	    @Override
	    public boolean isBreedingItem(ItemStack stack) {
		    if (stack == null)
			    return false;

            <#list data.breedTriggerItems as breedTriggerItem>
			    if (${mappedMCItemToItemStackCode(breedTriggerItem,1)}.asItem() == stack.getItem())
				    return true;
            </#list>

			return false;
	    }

        @Override
        public PassiveEntity createChild(ServerWorld world, PassiveEntity entity) {
            return ENTITY.create(world);
        }
	</#if>

    <#if hasCondition(data.spawningCondition)>
    @Override
    public boolean canSpawn(WorldView w) {
        World world = getEntityWorld();
        return <@procedureOBJToConditionCode data.spawningCondition/>;
    }
    </#if>
}
<#-- @formatter:on -->