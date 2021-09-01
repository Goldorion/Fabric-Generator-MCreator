<#--
This file is part of Fabric-Generator-MCreator.

Fabric-Generator-MCreator is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Fabric-Generator-MCreator is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with Fabric-Generator-MCreator.  If not, see <https://www.gnu.org/licenses/>.
-->

<#-- @formatter:off -->
<#include "mcitems.ftl">
<#include "procedures.java.ftl">

<#assign mx = data.W - data.width>
<#assign my = data.H - data.height>
<#assign slotnum = 0>

package ${package}.screen;

public class ${name}Gui {

	public static HashMap guistate = new HashMap();

	public static class GuiContainerMod extends ScreenHandler implements Supplier<Map<Integer, Slot>> {

		public World world;
		public PlayerEntity entity;
		public int x, y, z;

		private Map<Integer, Slot> customSlots = new HashMap<>();

		private boolean bound = false;

		public GuiContainerMod(int id, PlayerInventory inv, PacketByteBuf data) {
			super(${JavaModName}.${name}ScreenType, id);
			this.entity = inv.player;
			this.world = inv.player.world;
			BlockPos pos = null;
			if (data != null) {
                pos = data.readBlockPos();
                this.x = pos.getX();
                this.y = pos.getY();
                this.z = pos.getZ();
            }

			<#if data.type == 1>
				if (pos != null) {
					if (data.readableBytes() == 1) { // bound to item
						byte hand = data.readByte();
						ItemStack itemstack;
						if(hand == 0)
							itemstack = this.entity.getMainHandStack();
						else
							itemstack = this.entity.getOffHandStack();
						itemstack.getCapability(CapabilityItemHandler.ITEM_HANDLER_CAPABILITY, null).ifPresent(capability -> {
							this.internal = capability;
							this.bound = true;
						});
					} else if (data.readableBytes() > 1) {
						data.readByte(); // drop padding
						Entity entity = world.getEntityById(data.readVarInt());
						if(entity != null)
							entity.getCapability(CapabilityItemHandler.ITEM_HANDLER_CAPABILITY, null).ifPresent(capability -> {
								this.internal = capability;
								this.bound = true;
							});
					} else { // might be bound to block
						BlockEntity ent = inv.player != null ? inv.player.world.getBlockEntity(pos) : null;
						if (ent != null) {
							ent.getCapability(CapabilityItemHandler.ITEM_HANDLER_CAPABILITY, null).ifPresent(capability -> {
								this.internal = capability;
								this.bound = true;
							});
						}
					}
				}

				<#list data.components as component>
					<#if component.getClass().getSimpleName()?ends_with("Slot")>
						<#assign slotnum += 1>
            	    this.customSlots.put(${component.id}, this.addSlot(new SlotItemHandler(internal, ${component.id},
						${(component.x - mx / 2)?int + 1},
						${(component.y - my / 2)?int + 1}) {

            	    	<#if component.disableStackInteraction>
						@Override public boolean canTakeStack(PlayerEntity player) {
							return false;
						}
            	    	</#if>

						<#if hasProcedure(component.onSlotChanged)>
            	        @Override public void onSlotChanged() {
							super.onSlotChanged();
							GuiContainerMod.this.slotChanged(${component.id}, 0, 0);
						}
						</#if>

						<#if hasProcedure(component.onTakenFromSlot)>
            	        @Override public ItemStack onTake(PlayerEntity entity, ItemStack stack) {
							ItemStack retval = super.onTake(entity, stack);
							GuiContainerMod.this.slotChanged(${component.id}, 1, 0);
							return retval;
						}
						</#if>

						<#if hasProcedure(component.onStackTransfer)>
            	        @Override public void onSlotChange(ItemStack a, ItemStack b) {
							super.onSlotChange(a, b);
							GuiContainerMod.this.slotChanged(${component.id}, 2, b.getCount() - a.getCount());
						}
						</#if>

						<#if component.disableStackInteraction>
							@Override public boolean isItemValid(ItemStack stack) {
								return false;
							}
            	        <#elseif component.getClass().getSimpleName() == "InputSlot">
							<#if component.inputLimit.toString()?has_content>
            	             @Override public boolean isItemValid(ItemStack stack) {
								 return (${mappedMCItemToItem(component.inputLimit)} == stack.getItem());
							 }
							</#if>
						<#elseif component.getClass().getSimpleName() == "OutputSlot">
            	            @Override public boolean isItemValid(ItemStack stack) {
								return false;
							}
						</#if>
					}));
					</#if>
				</#list>

				<#assign coffx = ((data.width - 176) / 2 + data.inventoryOffsetX)?int>
				<#assign coffy = ((data.height - 166) / 2 + data.inventoryOffsetY)?int>

            	int si;
				int sj;

				for (si = 0; si < 3; ++si)
					for (sj = 0; sj < 9; ++sj)
						this.addSlot(new Slot(inv, sj + (si + 1) * 9, ${coffx} + 8 + sj * 18, ${coffy}+ 84 + si * 18));

				for (si = 0; si < 9; ++si)
					this.addSlot(new Slot(inv, si, ${coffx} + 8 + si * 18, ${coffy} + 142));
			</#if>

			<#if hasProcedure(data.onOpen)>
				<@procedureOBJToCode data.onOpen/>
			</#if>
		}

		public Map<Integer, Slot> get() {
			return customSlots;
		}

		@Override
		public boolean canUse(PlayerEntity player) {
			return true;
		}

		<#if data.type == 1>
		@Override public ItemStack transferSlot(PlayerEntity playerIn, int index) {
			ItemStack itemstack = ItemStack.EMPTY;
			Slot slot = (Slot) this.slots.get(index);

			if (slot != null && slot.hasStack()) {
				ItemStack itemstack1 = slot.getStack();
				itemstack = itemstack1.copy();

				if (index < ${slotnum}) {
					if (!this.insertItem(itemstack1, ${slotnum}, this.slots.size(), true)) {
						return ItemStack.EMPTY;
					}
					slot.onQuickTransfer(itemstack1, itemstack);
				} else if (!this.insertItem(itemstack1, 0, ${slotnum}, false)) {
					if (index < ${slotnum} + 27) {
						if (!this.insertItem(itemstack1, ${slotnum} + 27, this.slots.size(), true)) {
							return ItemStack.EMPTY;
						}
					} else {
						if (!this.insertItem(itemstack1, ${slotnum}, ${slotnum} + 27, false)) {
							return ItemStack.EMPTY;
						}
					}
					return ItemStack.EMPTY;
				}

				if (itemstack1.getCount() == 0) {
					slot.setStack(ItemStack.EMPTY);
				} else {
					slot.markDirty();
				}

				if (itemstack1.getCount() == itemstack.getCount()) {
					return ItemStack.EMPTY;
				}

				slot.onTakeItem(playerIn, itemstack1);
			}
			return itemstack;
		}

		@Override
		protected boolean insertItem(ItemStack stack, int startIndex, int endIndex, boolean fromLast) {
            boolean bl = false;
            int i = startIndex;
            if (fromLast) {
            	i = endIndex - 1;
            }

            Slot slot2;
            ItemStack itemStack;
            if (stack.isStackable()) {
            	while(!stack.isEmpty()) {
            		if (fromLast) {
            			if (i < startIndex) {
            				break;
            			}
            		} else if (i >= endIndex) {
            			break;
            		}

            		slot2 = (Slot)this.slots.get(i);
            		itemStack = slot2.getStack();
            		if (slot2.canInsert(itemStack) && !itemStack.isEmpty()) {
            			int j = itemStack.getCount() + stack.getCount();
            			if (j <= stack.getMaxCount()) {
            				stack.setCount(0);
            				itemStack.setCount(j);
            				slot2.setStack(itemStack);
            				bl = true;
            			} else if (itemStack.getCount() < stack.getMaxCount()) {
            				stack.decrement(stack.getMaxCount() - itemStack.getCount());
            				itemStack.setCount(stack.getMaxCount());
            				slot2.setStack(itemStack);
            				bl = true;
            			}
            		}

            		if (fromLast) {
            			--i;
            		} else {
            			++i;
            		}
            	}
            }

            if (!stack.isEmpty()) {
            	if (fromLast) {
            		i = endIndex - 1;
            	} else {
            		i = startIndex;
            	}

            	while(true) {
            		if (fromLast) {
            			if (i < startIndex) {
            				break;
            			}
            		} else if (i >= endIndex) {
            			break;
            		}

            		slot2 = (Slot)this.slots.get(i);
            		itemStack = slot2.getStack();
            		if (itemStack.isEmpty() && slot2.canInsert(stack)) {
            			if (stack.getCount() > slot2.getMaxItemCount()) {
            				slot2.setStack(stack.split(slot2.getMaxItemCount()));
            			} else {
            				slot2.setStack(stack.split(stack.getCount()));
            			}

            			slot2.setStack(itemStack);
            			bl = true;
            			break;
            		}

            		if (fromLast) {
            			--i;
            		} else {
            			++i;
            		}
            	}
            }

            return bl;
        }

		@Override
		public void close(PlayerEntity playerIn) {
			super.close(playerIn);

			<#if hasProcedure(data.onClosed)>
				<@procedureOBJToCode data.onClosed/>
			</#if>

			if (!bound && (playerIn instanceof ServerPlayerEntity)) {
				if (!playerIn.isAlive() || playerIn instanceof ServerPlayerEntity && ((ServerPlayerEntity)playerIn).isDisconnected()) {
					for(int j = 0; j < slots.size(); ++j) {
						<#list data.components as component>
							<#if component.getClass().getSimpleName()?ends_with("Slot") && !component.dropItemsWhenNotBound>
								if(j == ${component.id}) continue;
							</#if>
						</#list>
						playerIn.dropItem(slots.get(j).takeStack(slots.get(j).getStack().getCount()), false);
					}
				} else {
					for(int i = 0; i < slots.size(); ++i) {
						<#list data.components as component>
							<#if component.getClass().getSimpleName()?ends_with("Slot") && !component.dropItemsWhenNotBound>
								if(i == ${component.id}) continue;
							</#if>
						</#list>
						playerIn.inventory.offerOrDrop(playerIn.world, slots.get(i).takeStack(slots.get(i).getStack().getCount()));
					}
				}
			}
		}

		</#if>
	}

	public static class ButtonPressedMessage extends PacketByteBuf {
        public ButtonPressedMessage(int buttonID, int x, int y, int z) {
            super(Unpooled.buffer());
			writeInt(buttonID);
			writeInt(x);
			writeInt(y);
			writeInt(z);
        }

        public static void apply(MinecraftServer server, ServerPlayerEntity entity, ServerPlayNetworkHandler handler, PacketByteBuf buf, PacketSender responseSender) {
			int buttonID = buf.readInt();
            double x = buf.readInt();
            double y = buf.readInt();
            double z = buf.readInt();
            server.execute(() -> {
                World world = entity.getServerWorld();
		        <#assign btid = 0>
                <#list data.components as component>
                    <#if component.getClass().getSimpleName() == "Button">
				        <#if hasProcedure(component.onClick)>
        	    	        if (buttonID == ${btid}) {
        	    	            <@procedureOBJToCode component.onClick/>
					        }
				        </#if>
				        <#assign btid +=1>
			        </#if>
                </#list>
            });
        }
    }

}
<#-- @formatter:on -->