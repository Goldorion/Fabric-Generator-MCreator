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
		public int x, y, z = 0;

		private Map<Integer, Slot> customSlots = new HashMap<>();

		private boolean bound = false;

		private final Inventory inventory;

		public GuiContainerMod(int id, PlayerInventory inv, PacketByteBuf data) {
			this(id, inv, new SimpleInventory(${data.getMaxSlotID() + 1}));
			BlockPos pos;
			if (data != null) {
				pos = data.readBlockPos();
				this.x = pos.getX();
				this.y = pos.getY();
				this.z = pos.getZ();
			}
		}

		public GuiContainerMod(int id, PlayerInventory inv, Inventory inventory) {
			super(${JavaModName}.${name}ScreenType, id);
			this.entity = inv.player;
			this.world = inv.player.world;
			this.inventory = inventory;

			<#if data.type == 1>
			    <#list data.components as component>
					<#if component.getClass().getSimpleName()?ends_with("Slot")>
						<#assign slotnum += 1>
            	    this.customSlots.put(${component.id}, this.addSlot(new Slot(this.inventory, ${component.id},
						${(component.x - mx / 2)?int + 1},
						${(component.y - my / 2)?int + 1}) {

            	    	<#if component.disableStackInteraction>
						@Override public boolean canTakeItems(PlayerEntity player) {
							return false;
						}
            	    	</#if>

						<#if hasProcedure(component.onSlotChanged)>
            	        @Override public void markDirty() {
							super.markDirty();
							GuiContainerMod.this.slotChanged(${component.id}, 0, 0);
						}
						</#if>

						<#if hasProcedure(component.onTakenFromSlot)>
            	        @Override public ItemStack onTakeItem(PlayerEntity entity, ItemStack stack) {
							ItemStack retval = super.onTakeItem(entity, stack);
							GuiContainerMod.this.slotChanged(${component.id}, 1, 0);
							return retval;
						}
						</#if>

						<#if hasProcedure(component.onStackTransfer)>
            	        @Override public void onQuickTransfer(ItemStack a, ItemStack b) {
							super.onQuickTransfer(a, b);
							GuiContainerMod.this.slotChanged(${component.id}, 2, b.getCount() - a.getCount());
						}
						</#if>

						<#if component.disableStackInteraction>
							@Override public boolean canInsert(ItemStack stack) {
								return false;
							}
            	        <#elseif component.getClass().getSimpleName() == "InputSlot">
							<#if component.inputLimit.toString()?has_content>
            	             @Override public boolean canInsert(ItemStack stack) {
								 return (${mappedMCItemToItem(component.inputLimit)} == stack.getItem());
							 }
							</#if>
						<#elseif component.getClass().getSimpleName() == "OutputSlot">
            	            @Override public boolean canInsert(ItemStack stack) {
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
		@Override
        public ItemStack transferSlot(PlayerEntity player, int index) {
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

				slot.onTakeItem(player, itemstack1);
			}
			return itemstack;
        }

		@Override
		public void close(PlayerEntity playerIn) {
			super.close(playerIn);

			<#if hasProcedure(data.onClosed)>
				<@procedureOBJToCode data.onClosed/>
			</#if>
		}

		private void slotChanged(int slotid, int ctype, int meta) {
			if(this.world != null && this.world.isClient()) {
				ClientPlayNetworking.send(${JavaModName}.id("${name?lower_case}_slot_" + slotid), new GUISlotChangedMessage(slotid, x, y, z, ctype, meta));
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

	public static class GUISlotChangedMessage extends PacketByteBuf {
        public GUISlotChangedMessage(int slotID, int x, int y, int z, int changeType, int meta) {
            super(Unpooled.buffer());
			writeInt(slotID);
			writeInt(x);
			writeInt(y);
			writeInt(z);
			writeInt(changeType);
			writeInt(meta);
        }

        public static void apply(MinecraftServer server, ServerPlayerEntity entity, ServerPlayNetworkHandler handler, PacketByteBuf buf, PacketSender responseSender) {
			int slotID = buf.readInt();
            double x = buf.readInt();
            double y = buf.readInt();
            double z = buf.readInt();
            int changeType = buf.readInt();
            int meta = buf.readInt();
            server.execute(() -> {
                World world = entity.getServerWorld();
		        <#list data.components as component>
                    <#if component.getClass().getSimpleName()?ends_with("Slot")>
                    	<#if hasProcedure(component.onSlotChanged)>
                    		if (slotID == ${component.id} && changeType == 0) {
                    			<@procedureOBJToCode component.onSlotChanged/>
                    		}
                    	</#if>
                    	<#if hasProcedure(component.onTakenFromSlot)>
                    		if (slotID == ${component.id} && changeType == 1) {
                    			<@procedureOBJToCode component.onTakenFromSlot/>
                    		}
                    	</#if>
                    	<#if hasProcedure(component.onStackTransfer)>
                    		if (slotID == ${component.id} && changeType == 2) {
                    			int amount = meta;
                    			<@procedureOBJToCode component.onStackTransfer/>
                    		}
                    	</#if>
                    </#if>
                </#list>
            });
        }
    }

}
<#-- @formatter:on -->