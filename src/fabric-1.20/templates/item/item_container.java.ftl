<#--
 # MCreator (https://mcreator.net/)
 # Copyright (C) 2012-2020, Pylo
 # Copyright (C) 2020-2023, Pylo, opensource contributors
 # Copyright (C) 2020-2023, Goldorion, opensource contributors
 #
 # This program is free software: you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
 # the Free Software Foundation, either version 3 of the License, or
 # (at your option) any later version.
 #
 # This program is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <https://www.gnu.org/licenses/>.
 #
 # Additional permission for code generator templates (*.ftl files)
 #
 # As a special exception, you may create a larger work that contains part or
 # all of the MCreator code generator templates (*.ftl files) and distribute
 # that work under terms of your choice, so long as that work isn't itself a
 # template for code generation. Alternatively, if you modify or redistribute
 # the template itself, you may (at your option) remove this special exception,
 # which will cause the template and the resulting code generator output files
 # to be licensed under the GNU General Public License without this special
 # exception.
-->

<#-- @formatter:off -->

package ${package}.item.inventory;
import net.fabricmc.api.Environment;

import org.jetbrains.annotations.Nullable;

@Environment(EnvType.CLIENT)
public class ${name}Inventory implements WorldlyContainer {
	private final ItemStack stack;
	private final NonNullList<ItemStack> items = NonNullList.withSize(${data.inventorySize}, ItemStack.EMPTY);

	public ${name}Inventory(ItemStack stack) {
		this.stack = stack;
		CompoundTag tag = stack.getTagElement("Items");

		if (tag != null) {
			ContainerHelper.loadAllItems(tag, items);
		}
	}

	public NonNullList<ItemStack> getItems() {
		return items;
	}

	@Override
	public int[] getSlotsForFace(Direction side) {
		int[] result = new int[getItems().size()];

		for (int i = 0; i < result.length; i++) {
			result[i] = i;
		}

		return result;
	}

	@Override
	public int getMaxStackSize() {
		return ${data.inventoryStackSize};
	}

	@Override
	public boolean canPlaceItemThroughFace(int slot, ItemStack stack, @Nullable Direction dir) {
		return true;
	}

	@Override
	public boolean canTakeItemThroughFace(int slot, ItemStack stack, Direction dir) {
		return true;
	}

	@Override
	public int getContainerSize() {
		return getItems().size();
	}

	@Override
	public boolean isEmpty() {
		for (int i = 0; i < getContainerSize(); i++) {
			ItemStack stack = getItem(i);

			if (!stack.isEmpty()) {
				return false;
			}
		}

		return true;
	}

	@Override
	public ItemStack getItem(int slot) {
		return getItems().get(slot);
	}

	@Override
	public ItemStack removeItem(int slot, int amount) {
		ItemStack result = ContainerHelper.removeItem(getItems(), slot, amount);

		if (!result.isEmpty()) {
			setChanged();
		}

		return result;
	}

	@Override
	public ItemStack removeItemNoUpdate(int slot) {
		return ContainerHelper.takeItem(getItems(), slot);
	}

	@Override
	public void setItem(int slot, ItemStack stack) {
		getItems().set(slot, stack);
			if (stack.getCount() > getMaxStackSize()) {
				stack.setCount(getMaxStackSize());
		}
	}

	@Override
	public void setChanged() {
		CompoundTag tag = stack.getOrCreateTagElement("Items");
		ContainerHelper.saveAllItems(tag, items);
	}

	@Override
	public boolean stillValid(Player player) {
		return true;
	}

	@Override
	public void clearContent() {
		getItems().clear();
	}
}

<#-- @formatter:on -->