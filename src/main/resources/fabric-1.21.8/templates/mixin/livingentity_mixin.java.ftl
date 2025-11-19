<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2020-2025, Goldorion, opensource contributors
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
<#include "../procedures.java.ftl">

<#assign itemsWithEntitySwing = []>
<#list w.getGElementsOfType("item") as item>
	<#if hasProcedure(item.onEntitySwing)>
	<#assign itemsWithEntitySwing += [item]>
	</#if>
</#list>
<#list w.getGElementsOfType("tool") as tool>
	<#if hasProcedure(tool.onEntitySwing)>
	<#assign itemsWithEntitySwing += [tool]>
	</#if>
</#list>

package ${package}.mixin;

@Mixin(LivingEntity.class)
public abstract class LivingEntityMixin {
    @Shadow
    protected int lastHurtByPlayerMemoryTime;

    @Shadow
    protected boolean isAlwaysExperienceDropper() {
        return false;
    }

	@Inject(method = "swing(Lnet/minecraft/world/InteractionHand;Z)V", at = @At("HEAD"))
	public void swing(InteractionHand hand, boolean updateSelf, CallbackInfo ci) {
		ItemStack stack = ((LivingEntity) (Object) this).getItemInHand(hand);
		if (!stack.isEmpty()) {
		<#list itemsWithEntitySwing as item>
			if (stack.getItem() instanceof ${item.getModElement().getName()}Item)
				((${item.getModElement().getName()}Item)stack.getItem()).onEntitySwing(stack, (LivingEntity) (Object) this, hand);
		</#list>
		}
	}
	
	@Inject(method = "startUsingItem(Lnet/minecraft/world/InteractionHand;)V", at = @At("HEAD"))
	public void startUsingItem(InteractionHand hand, CallbackInfo ci) {
		LivingEntity entity = (LivingEntity) (Object) this;
		ItemStack stack = entity.getItemInHand(hand);
		if (!stack.isEmpty() && !entity.isUsingItem()) {
			LivingEntityEvents.START_USE_ITEM.invoker().onStartUseItem(entity, stack);
		}
	}

	@Inject(method = "heal(F)V", at = @At("HEAD"), cancellable = true)
	public void heal(float amount, CallbackInfo ci) {
		if (!LivingEntityEvents.ENTITY_HEAL.invoker().onEntityHeal((LivingEntity) (Object) this, amount))
			ci.cancel();
	}

	@Inject(method = "applyItemBlocking(Lnet/minecraft/server/level/ServerLevel;Lnet/minecraft/world/damagesource/DamageSource;F)F", at = @At("HEAD"), cancellable = true)
	public void applyItemBlocking(ServerLevel serverLevel, DamageSource damageSource, float f, CallbackInfoReturnable<Float> cir) {
		if (!LivingEntityEvents.ENTITY_BLOCK.invoker().onEntityBlock((LivingEntity) (Object) this, damageSource, (double) f))
			cir.cancel();
	}

	@Inject(method = "dropExperience(Lnet/minecraft/server/level/ServerLevel;Lnet/minecraft/world/entity/Entity;)V", at = @At("HEAD"), cancellable = true)
	public void dropExperience(ServerLevel serverLevel, Entity entity, CallbackInfo ci) {
	    LivingEntity self = (LivingEntity) (Object) this;
	    if (!self.wasExperienceConsumed() && (this.isAlwaysExperienceDropper() || this.lastHurtByPlayerMemoryTime > 0 && self.shouldDropExperience() && serverLevel.getGameRules().getBoolean(GameRules.RULE_DOMOBLOOT))) {
		    if (!LivingEntityEvents.ENTITY_DROP_XP.invoker().onEntityDropXp(self, self.getLastHurtByPlayer(), (double) self.getExperienceReward(serverLevel, entity)))
			    ci.cancel();
	    }
	}

	@Inject(method = "causeFallDamage(DFLnet/minecraft/world/damagesource/DamageSource;)Z", at = @At("HEAD"), cancellable = true)
	public void causeFallDamage(double d, float f, DamageSource damageSource, CallbackInfoReturnable<Boolean> cir) {
		if (!LivingEntityEvents.ENTITY_FALL.invoker().onEntityFall((LivingEntity) (Object) this, d, (double) f))
			cir.setReturnValue(false);
	}

	@Inject(method = "onItemPickup(Lnet/minecraft/world/entity/item/ItemEntity;)V", at = @At("HEAD"))
	public void onItemPickup(ItemEntity itemEntity, CallbackInfo ci) {
        LivingEntityEvents.ENTITY_PICKUP_ITEM.invoker().onEntityPickupItem(itemEntity.getOwner(), itemEntity.getItem());
	}

	@Inject(method = "jumpFromGround()V", at = @At("TAIL"))
	public void jumpFromGround(CallbackInfo ci) {
        LivingEntityEvents.ENTITY_JUMP.invoker().onEntityJump((LivingEntity) (Object) this);
	}
}
<#-- @formatter:on -->