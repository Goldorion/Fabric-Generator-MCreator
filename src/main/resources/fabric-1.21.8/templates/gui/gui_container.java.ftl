<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2012-2020, Pylo
 # Copyright (C) 2020-2025, Pylo, opensource contributors
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
<#include "../mcitems.ftl">
<#include "../procedures.java.ftl">
<#assign slotnum = 0>
package ${package}.world.inventory;

import ${package}.${JavaModName};

<@javacompress>
public class ${name}Menu extends AbstractContainerMenu implements ${JavaModName}Menus.MenuAccessor {

	public final Map<String, Object> menuState = new HashMap<>() {
		@Override public Object put(String key, Object value) {
			<#-- Prevent arbitrary data storage beyond the menu state -->
			if (!this.containsKey(key) && this.size() >= ${data.components?size}) return null;
			return super.put(key, value);
		}
	};

	public final Level world;
	public final Player entity;
	public int x, y, z;
	private ContainerLevelAccess access = ContainerLevelAccess.NULL;

	private final Container inventory;

	private final Map<Integer, Slot> customSlots = new HashMap<>();

	private boolean bound = false;
	private Supplier<Boolean> boundItemMatcher = null;
	private ItemStack boundItem = null;

	public ${name}Menu(int id, Inventory inv) {
		this(id, inv, new SimpleContainer(${data.getMaxSlotID() + 1}));
		this.x = (int) inv.player.getX();
		this.y = (int) inv.player.getY();
		this.z = (int) inv.player.getZ();
		access = ContainerLevelAccess.create(inv.player.level(), new BlockPos(x, y, z));
	}

	public ${name}Menu(int id, Inventory inv, FriendlyByteBuf extraData) {
		this(id, inv, new SimpleContainer(${data.getMaxSlotID() + 1}), extraData);
	}

	public ${name}Menu(int id, Inventory inv, Container container, FriendlyByteBuf extraData) {
		this(id, inv, container);
		BlockPos pos = null;
		if (extraData != null) {
			pos = extraData.readBlockPos();
			this.x = pos.getX();
			this.y = pos.getY();
			this.z = pos.getZ();
			access = ContainerLevelAccess.create(world, pos);
		}

		<#if data.type == 1>
			if (pos != null) {
				if (extraData.readableBytes() == 1) { // bound to item
					byte hand = extraData.readByte();
					ItemStack itemstack = hand == 0 ? this.entity.getMainHandItem() : this.entity.getOffhandItem();
					this.boundItem = itemstack;
					this.boundItemMatcher = () -> itemstack == (hand == 0 ? this.entity.getMainHandItem() : this.entity.getOffhandItem());
					this.bound = true;
				}
			}
		</#if>
	}

	public ${name}Menu(int id, Inventory inv, Container container) {
		super(${JavaModName}Menus.${REGISTRYNAME}, id);

		this.entity = inv.player;
		this.world = inv.player.level();

		this.inventory = container;

		<#if data.type == 1>
			<#list data.components as component>
				<#if component.getClass().getSimpleName()?ends_with("Slot")>
					<#assign slotnum += 1>
					this.customSlots.put(${component.id}, this.addSlot(new Slot(inventory, ${component.id},
						${component.gx(data.width) + 1},
						${component.gy(data.height) + 1}) {
						private final int slot = ${component.id}; <#-- #5209, this is needed for procedure dependencies -->
						private int x = ${name}Menu.this.x; <#-- #5239 - x and y provided by slot are in-GUI, not in-world coordinates -->
						private int y = ${name}Menu.this.y;

						<#if hasProcedure(component.disablePickup) || component.disablePickup.getFixedValue()>
						@Override public boolean mayPickup(Player entity) {
							return <@procedureOBJToConditionCode component.disablePickup false true/>;
						}
						</#if>

						<#if hasProcedure(component.onSlotChanged)>
						@Override public void setChanged() {
							super.setChanged();
							slotChanged(${component.id}, 0, 0);
						}
						</#if>

						<#if hasProcedure(component.onTakenFromSlot)>
						@Override public void onTake(Player entity, ItemStack stack) {
							super.onTake(entity, stack);
							slotChanged(${component.id}, 1, stack.getCount());
						}
						</#if>

						<#if hasProcedure(component.onStackTransfer)>
						@Override public void onQuickCraft(ItemStack a, ItemStack b) {
							super.onQuickCraft(a, b);
							slotChanged(${component.id}, 2, b.getCount() - a.getCount());
						}
						</#if>

						<#if component.getClass().getSimpleName() == "InputSlot">
							<#if hasProcedure(component.disablePlacement) || component.disablePlacement.getFixedValue()>
								@Override public boolean mayPlace(ItemStack itemstack) {
									return <@procedureOBJToConditionCode component.disablePlacement false true/>;
								}
							<#elseif component.inputLimit.toString()?has_content>
								@Override public boolean mayPlace(ItemStack stack) {
									<#if component.inputLimit.getUnmappedValue().startsWith("TAG:")>
										<#assign tag = "\"" + component.inputLimit.getUnmappedValue().replace("TAG:", "").replace("mod:", modid + ":") + "\"">
										return stack.is(TagKey.create(Registries.ITEM, ResourceLocation.parse(${tag})));
									<#else>
										return ${mappedMCItemToItem(component.inputLimit)} == stack.getItem();
									</#if>
								}
							</#if>
						<#elseif component.getClass().getSimpleName() == "OutputSlot">
							@Override public boolean mayPlace(ItemStack stack) {
								return false;
							}
						</#if>
					}));
				</#if>
			</#list>

			<#assign coffx = data.getInventorySlotsX()>
			<#assign coffy = data.getInventorySlotsY()>

			for (int si = 0; si < 3; ++si)
				for (int sj = 0; sj < 9; ++sj)
					this.addSlot(new Slot(inv, sj + (si + 1) * 9, ${coffx} + 8 + sj * 18, ${coffy} + 84 + si * 18));

			for (int si = 0; si < 9; ++si)
				this.addSlot(new Slot(inv, si, ${coffx} + 8 + si * 18, ${coffy} + 142));
		</#if>

		<#if hasProcedure(data.onOpen)>
			<@procedureOBJToCode data.onOpen/>
		</#if>
	}

	@Override public boolean stillValid(Player player) {
		if (this.bound) {
			if (this.boundItemMatcher != null)
				return this.boundItemMatcher.get();
		}
		return this.inventory.stillValid(player);
	}

	<#if data.type == 1>
		@Override public ItemStack quickMoveStack(Player playerIn, int index) {
			ItemStack itemstack = ItemStack.EMPTY;
			Slot slot = (Slot) this.slots.get(index);

			if (slot != null && slot.hasItem()) {
				ItemStack itemstack1 = slot.getItem();
				itemstack = itemstack1.copy();

				if (index < ${slotnum}) {
					if (!this.moveItemStackTo(itemstack1, ${slotnum}, this.slots.size(), true))
						return ItemStack.EMPTY;
					slot.onQuickCraft(itemstack1, itemstack);
				} else if (boundItem != null && itemstack1 == boundItem) {
				    return ItemStack.EMPTY;
				} else if (!this.moveItemStackTo(itemstack1, 0, ${slotnum}, false)) {
					if (index < ${slotnum} + 27) {
						if (!this.moveItemStackTo(itemstack1, ${slotnum} + 27, this.slots.size(), true))
							return ItemStack.EMPTY;
					} else {
						if (!this.moveItemStackTo(itemstack1, ${slotnum}, ${slotnum} + 27, false))
							return ItemStack.EMPTY;
					}
					return ItemStack.EMPTY;
				}

				if (itemstack1.isEmpty()) {
					slot.setByPlayer(ItemStack.EMPTY);
				} else {
					slot.setChanged();
				}

				if (itemstack1.getCount() == itemstack.getCount()) {
					return ItemStack.EMPTY;
				}

				slot.onTake(playerIn, itemstack1);
			}
			return itemstack;
		}

		@Override
		public void clicked(int slotId, int button, ClickType clickType, Player player) {
			if (clickType == ClickType.SWAP && boundItem != null) {
				if (slotId >= 0 && slotId < this.slots.size()) {
					ItemStack slotItem = this.slots.get(slotId).getItem();
					ItemStack hotbarItem = player.getInventory().getItem(button);
					if (slotItem == boundItem || hotbarItem == boundItem) {
						return;
					}
				}
			}
			super.clicked(slotId, button, clickType, player);
		}

		@Override
		protected boolean moveItemStackTo(ItemStack itemstack, int i, int j, boolean bl) {
			int l;
			ItemStack itemstack2;
			Slot slot;
			boolean bl2 = false;
			int k = i;
			if (bl) {
				k = j - 1;
			}
			if (itemstack.isStackable()) {
				while (!itemstack.isEmpty() && (bl ? k >= i : k < j)) {
					slot = this.slots.get(k);
					itemstack2 = slot.getItem();
					if (!itemstack2.isEmpty() && ItemStack.isSameItemSameComponents(itemstack, itemstack2)) {
						int m;
						l = itemstack2.getCount() + itemstack.getCount();
						if (l <= (m = slot.getMaxStackSize(itemstack2))) {
							itemstack.setCount(0);
							itemstack2.setCount(l);
							slot.set(itemstack2);
							bl2 = true;
						} else if (itemstack2.getCount() < m) {
							itemstack.shrink(m - itemstack2.getCount());
							itemstack2.setCount(m);
							slot.set(itemstack2);
							bl2 = true;
						}
					}
					if (bl) {
						--k;
						continue;
					}
					++k;
				}
			}
			if (!itemstack.isEmpty()) {
				k = bl ? j - 1 : i;
				while (bl ? k >= i : k < j) {
					slot = this.slots.get(k);
					itemstack2 = slot.getItem();
					if (itemstack2.isEmpty() && slot.mayPlace(itemstack)) {
						l = slot.getMaxStackSize(itemstack);
						slot.setByPlayer(itemstack.split(Math.min(itemstack.getCount(), l)));
						bl2 = true;
						break;
					}
					if (bl) {
						--k;
						continue;
					}
					++k;
				}
			}
			return bl2;
		}

		@Override public void removed(Player playerIn) {
			super.removed(playerIn);

			<#if hasProcedure(data.onClosed)>
				<@procedureOBJToCode data.onClosed/>
			</#if>
		}

		<#if data.hasSlotEvents()>
			private void slotChanged(int slotid, int ctype, int meta) {
				if(this.world != null && this.world.isClientSide()) {
					ClientPlayNetworking.send(new ${name}SlotMessage(slotid, x, y, z, ctype, meta));
					${name}SlotMessage.handleSlotAction(entity, slotid, ctype, meta, x, y, z);
				}
			}
		</#if>
	<#else>
		@Override public ItemStack quickMoveStack(Player playerIn, int index) {
			return ItemStack.EMPTY;
		}
		<#if hasProcedure(data.onClosed)>
			@Override public void removed(Player playerIn) {
				super.removed(playerIn);
				<@procedureOBJToCode data.onClosed/>
			}
		</#if>
	</#if>

	@Override public Map<Integer, Slot> getSlots() {
		return Collections.unmodifiableMap(customSlots);
	}

	@Override public Map<String, Object> getMenuState() {
		return menuState;
	}

	public static void screenInit() {
		<#if data.hasButtonEvents()>
			PayloadTypeRegistry.playC2S().register(${name}ButtonMessage.TYPE, ${name}ButtonMessage.STREAM_CODEC);
			ServerPlayNetworking.registerGlobalReceiver(${name}ButtonMessage.TYPE, ${name}ButtonMessage::handleData);
		</#if>
		<#if data.hasSlotEvents()>
			PayloadTypeRegistry.playC2S().register(${name}SlotMessage.TYPE, ${name}SlotMessage.STREAM_CODEC);
			ServerPlayNetworking.registerGlobalReceiver(${name}SlotMessage.TYPE, ${name}SlotMessage::handleData);
		</#if>
		<#if data.hasSliderEvents()>
			PayloadTypeRegistry.playC2S().register(${name}SliderMessage.TYPE, ${name}SliderMessage.STREAM_CODEC);
			ServerPlayNetworking.registerGlobalReceiver(${name}SliderMessage.TYPE, ${name}SliderMessage::handleData);
		</#if>

		<#if hasProcedure(data.onTick)>
			PlayerEvents.END_PLAYER_TICK.register(entity -> {
				if (entity.containerMenu instanceof ${name}Menu menu) {
					Level world = menu.world;
					double x = menu.x;
					double y = menu.y;
					double z = menu.z;
					<@procedureOBJToCode data.onTick/>
				}
			});
		</#if>
	}
}
</@javacompress>
<#-- @formatter:on -->