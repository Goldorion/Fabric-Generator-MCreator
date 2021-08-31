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

	<#if hasProcedure(data.onTick)>
		@SubscribeEvent public void onPlayerTick(TickEvent.PlayerTickEvent event) {
			PlayerEntity entity = event.player;
			if(event.phase == TickEvent.Phase.END && entity.openContainer instanceof GuiContainerMod) {
				World world = entity.world;
				double x = entity.getPosX();
				double y = entity.getPosY();
				double z = entity.getPosZ();
				<@procedureOBJToCode data.onTick/>
			}
		}
	</#if>

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
				pos = entity.getBlockPos();
				this.x = pos.getX();
				this.y = pos.getY();
				this.z = pos.getZ();
			}
		}

		public GuiContainerMod(int id, PlayerInventory inv, PlayerEntity player) {
			super(${JavaModName}.${name}ScreenType, id);

			this.entity = inv.player;
			this.world = inv.player.world;

			BlockPos pos = null;
			if (player != null) {
				pos = player.getBlockPos();
				this.x = pos.getX();
				this.y = pos.getY();
				this.z = pos.getZ();
			}

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
		@Override public ItemStack transferStackInSlot(PlayerEntity playerIn, int index) {
			ItemStack itemstack = ItemStack.EMPTY;
			Slot slot = (Slot) this.inventorySlots.get(index);

			if (slot != null && slot.getHasStack()) {
				ItemStack itemstack1 = slot.getStack();
				itemstack = itemstack1.copy();

				if (index < ${slotnum}) {
					if (!this.mergeItemStack(itemstack1, ${slotnum}, this.inventorySlots.size(), true)) {
						return ItemStack.EMPTY;
					}
					slot.onSlotChange(itemstack1, itemstack);
				} else if (!this.mergeItemStack(itemstack1, 0, ${slotnum}, false)) {
					if (index < ${slotnum} + 27) {
						if (!this.mergeItemStack(itemstack1, ${slotnum} + 27, this.inventorySlots.size(), true)) {
							return ItemStack.EMPTY;
						}
					} else {
						if (!this.mergeItemStack(itemstack1, ${slotnum}, ${slotnum} + 27, false)) {
							return ItemStack.EMPTY;
						}
					}
					return ItemStack.EMPTY;
				}

				if (itemstack1.getCount() == 0) {
					slot.putStack(ItemStack.EMPTY);
				} else {
					slot.onSlotChanged();
				}

				if (itemstack1.getCount() == itemstack.getCount()) {
					return ItemStack.EMPTY;
				}

				slot.onTake(playerIn, itemstack1);
			}
			return itemstack;
		}

		<#-- #47997 -->
		@Override ${mcc.getMethod("net.minecraft.inventory.container.Container", "mergeItemStack", "ItemStack", "int", "int", "boolean")
			.replace("slot.onSlotChanged();", "slot.putStack(itemstack);")
			.replace("!itemstack.isEmpty()", "slot.isItemValid(itemstack) && !itemstack.isEmpty()")}

		@Override public void onContainerClosed(PlayerEntity playerIn) {
			super.onContainerClosed(playerIn);

			<#if hasProcedure(data.onClosed)>
				<@procedureOBJToCode data.onClosed/>
			</#if>

			if (!bound && (playerIn instanceof ServerPlayerEntity)) {
				if (!playerIn.isAlive() || playerIn instanceof ServerPlayerEntity && ((ServerPlayerEntity)playerIn).hasDisconnected()) {
					for(int j = 0; j < internal.getSlots(); ++j) {
						<#list data.components as component>
							<#if component.getClass().getSimpleName()?ends_with("Slot") && !component.dropItemsWhenNotBound>
								if(j == ${component.id}) continue;
							</#if>
						</#list>
						playerIn.dropItem(internal.extractItem(j, internal.getStackInSlot(j).getCount(), false), false);
					}
				} else {
					for(int i = 0; i < internal.getSlots(); ++i) {
						<#list data.components as component>
							<#if component.getClass().getSimpleName()?ends_with("Slot") && !component.dropItemsWhenNotBound>
								if(i == ${component.id}) continue;
							</#if>
						</#list>
						playerIn.inventory.placeItemBackInInventory(playerIn.world, internal.extractItem(i, internal.getStackInSlot(i).getCount(), false));
					}
				}
			}
		}

		private void slotChanged(int slotid, int ctype, int meta) {
			if(this.world != null && this.world.isRemote()) {
				${JavaModName}.PACKET_HANDLER.sendToServer(new GUISlotChangedMessage(slotid, x, y, z, ctype, meta));
				handleSlotAction(entity, slotid, ctype, meta, x, y, z);
			}
		}

		</#if>
	}

	public static class ButtonPressedMessage extends PacketByteBuf {
	    int buttonID;
        public ButtonPressedMessage(int buttonID) {
            super(Unpooled.buffer());
            this.buttonID = buttonID;
        }

        public static void apply(MinecraftServer server, ServerPlayerEntity entity, ServerPlayNetworkHandler handler, PacketByteBuf buf, PacketSender responseSender) {
            server.execute(() -> {
                double x = entity.getX();
                double y = entity.getY();
                double z = entity.getZ();
                World world = entity.getServerWorld();
		        <#assign btid = 0>
                <#list data.components as component>
                    <#if component.getClass().getSimpleName() == "Button">
				        <#if hasProcedure(component.onClick)>
        	    	        if (buf.readByte() == ${btid}) {
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