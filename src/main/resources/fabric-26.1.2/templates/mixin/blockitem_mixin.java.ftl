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
package ${package}.mixin;

@Mixin(BlockItem.class)
public abstract class BlockItemMixin {
	@Inject(method = "useOn(Lnet/minecraft/world/item/context/UseOnContext;)Lnet/minecraft/world/InteractionResult;", at = @At("HEAD"), cancellable = true)
	public void useOn(UseOnContext context, CallbackInfoReturnable<InteractionResult> cir) {
		BlockPlaceContext placeContext = new BlockPlaceContext(context);
		boolean result = BlockEvents.BLOCK_PLACE.invoker().onBlockPlaced(context.getClickedPos(), (Entity) placeContext.getPlayer(), ((BlockItem) placeContext.getItemInHand().getItem()).getBlock().defaultBlockState(), placeContext.getPlayer().level().getBlockState(context.getClickedPos()));
		if (!result)
			cir.setReturnValue(InteractionResult.FAIL);
	}
}
<#-- @formatter:on -->