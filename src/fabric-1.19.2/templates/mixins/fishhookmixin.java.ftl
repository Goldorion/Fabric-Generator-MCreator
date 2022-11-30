<#--
 # This file is part of Fabric-Generator-MCreator.
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
package ${package}.mixins;

import ${package}.mixins.EntityMixin;

@Mixin(FishingHook.class)
public abstract class ${JavaModName}FishingHookMixin extends EntityMixin {

	@Inject(method = "shouldStopFishing", at = @At("HEAD"), cancellable = true)
	public void shouldStopFishing(Player player, CallbackInfoReturnable<Boolean> cir) {
		ItemStack itemStack = player.getMainHandItem();
		ItemStack itemStack2 = player.getOffhandItem();
		<#list tools as tool>
			<#if tool.toolType == "Fishing rod">
				if (!player.isRemoved() && player.isAlive() && (itemStack.is(${JavaModName}Items.${tool.getModElement().getRegistryNameUpper()}) || itemStack2.is(${JavaModName}Items.${tool.getModElement().getRegistryNameUpper()})) && this.distanceToSqr(player) < 1024.0) {
					cir.setReturnValue(false);
				}
			</#if>
		</#list>
	}
}
<#-- @formatter:on -->
