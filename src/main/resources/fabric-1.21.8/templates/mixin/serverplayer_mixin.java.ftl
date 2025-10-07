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

package ${package}.mixin;

@Mixin(ServerPlayer.class)
public abstract class ServerPlayerMixin {
	@Inject(method = "Lnet/minecraft/server/level/ServerPlayer;drop(Z)Z", at = @At("HEAD"), cancellable = true)
	public void drop(boolean dropStack, CallbackInfoReturnable<Boolean> cir) {
		ServerPlayer self = (ServerPlayer) (Object) this;
		Inventory inventory = self.getInventory();
		ItemStack itemstack = inventory.removeFromSelected(dropStack);
		self.containerMenu
			.findSlot(inventory, inventory.getSelectedSlot())
			.ifPresent(p_401732_ -> self.containerMenu.setRemoteSlot(p_401732_, inventory.getSelectedItem()));
		<#list items as item>
			<#if item.getModElement().getTypeString() == "item">
				<#if hasProcedure(item.onDroppedByPlayer)>
					if (itemstack.getItem() instanceof ${item.getModElement().getName()}Item)
						((${item.getModElement().getName()}Item)itemstack.getItem()).onDroppedByPlayer(itemstack, self);
				</#if>
			</#if>
		</#list>
		cir.setReturnValue(self.drop(itemstack, false, true) != null);
	}
}
<#-- @formatter:on -->