<#--
 # This file is part of Fabric-Generator-MCreator.
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
package ${package}.mixin;

<#assign shears = w.getGElementsOfType('tool')?filter(e -> e.toolType.equals('Shears'))>

@Mixin(Sheep.class)
public abstract class SheepMixin {

	@Inject(method = "mobInteract(Lnet/minecraft/world/entity/player/Player;Lnet/minecraft/world/InteractionHand;)Lnet/minecraft/world/InteractionResult;", at = @At("HEAD"), cancellable = true)
	public void mobInteract(Player player, InteractionHand hand, CallbackInfoReturnable<InteractionResult> cir) {
		Sheep sheep = (Sheep) (Object) this;
		ItemStack itemStack = player.getItemInHand(hand);

		if (<#list shears as tool>itemStack.is(${JavaModName}Items.${tool.getModElement().getRegistryNameUpper()})<#sep>||</#list>) {
			if (sheep.level() instanceof ServerLevel serverLevel && sheep.readyForShearing()) {
				sheep.shear(serverLevel, SoundSource.PLAYERS, itemStack);
				sheep.gameEvent(GameEvent.SHEAR, player);
				itemStack.hurtAndBreak(1, player, hand.asEquipmentSlot());
				cir.setReturnValue(InteractionResult.SUCCESS_SERVER);
			}

			cir.setReturnValue(InteractionResult.CONSUME);
		}
	}
}
<#-- @formatter:on -->