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

import com.google.common.collect.Lists;
import org.spongepowered.asm.mixin.injection.Constant;

@Mixin(RepairItemRecipe.class)
public abstract class RepairItemRecipeMixin {
	@Inject(method = "assemble(Lnet/minecraft/world/item/crafting/CraftingInput;Lnet/minecraft/core/HolderLookup$Provider;)Lnet/minecraft/world/item/ItemStack;", at = @At("HEAD"), cancellable = true)
	public void assemble(CraftingInput craftingInput, HolderLookup.Provider provider, CallbackInfoReturnable<ItemStack> cir) {
		ItemStack itemStack3;
		ItemStack itemStack;
		ArrayList<ItemStack> list = Lists.newArrayList();
		for (int i = 0; i < craftingInput.ingredientCount(); ++i) {
			ItemStack itemStack2;
			itemStack = craftingInput.getItem(i);
			if (itemStack.isEmpty())
				continue;
			list.add(itemStack);
		}
		<#list items as item>
		<#if item.getModElement().getTypeString() == "item" || item.getModElement().getTypeString() == "tool">
			<#if item.stayInGridWhenCrafting>
				if ((itemStack3 = (ItemStack) list.get(0)).is((${JavaModName}Items.${item.getModElement().getRegistryNameUpper()}))) {
					cir.setReturnValue(ItemStack.EMPTY);
				}
			</#if>
		</#if>
		</#list>
	}
}
<#-- @formatter:on -->
