<#--
 # This file is part of Fabric-Generator-MCreator.
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
package ${package}.mixins;

import ${package}.mixins.EntityMixin;

@Mixin(FishingHook.class)
public abstract class ${JavaModName}FishingHookMixin extends EntityMixin {

	@Inject(method = "shouldStopFishing", at = @At("HEAD"), cancellable = true)
	public void shouldStopFishing(Player player, CallbackInfoReturnable<Boolean> cir) {
		ItemStack itemStack = player.getMainHandItem();
		ItemStack itemStack2 = player.getOffhandItem();
		if (!player.isRemoved() && player.isAlive() && ((itemStack.getItem() instanceof FishingRodItem) || (itemStack2.getItem() instanceof FishingRodItem)) && this.distanceToSqr(player) < 1024.0) {
			cir.setReturnValue(false);
		}
	}
}
<#-- @formatter:on -->
