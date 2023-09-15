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
<#include "../procedures.java.ftl">

package ${package}.network;

public class ${name}SlotMessage extends FriendlyByteBuf {

	public ${name}SlotMessage(int slot, int x, int y, int z, int changeType, int meta) {
		super(Unpooled.buffer());
			writeInt(slot);
			writeInt(x);
			writeInt(y);
			writeInt(z);
			writeInt(changeType);
			writeInt(meta);
	}

	public static void apply(MinecraftServer server, ServerPlayer entity, ServerGamePacketListenerImpl handler, FriendlyByteBuf buf, PacketSender responseSender) {
		int slot = buf.readInt();
		double x = buf.readInt();
		double y = buf.readInt();
		double z = buf.readInt();
		int changeType = buf.readInt();
		int meta = buf.readInt();
		server.execute(() -> {
			Level world = entity.level();
			HashMap guistate = ${name}Menu.guistate;
			<#list data.components as component>
				<#if component.getClass().getSimpleName()?ends_with("Slot")>
					<#if hasProcedure(component.onSlotChanged)>
						if (slot == ${component.id} && changeType == 0) {
							<@procedureOBJToCode component.onSlotChanged/>
						}
					</#if>
					<#if hasProcedure(component.onTakenFromSlot)>
						if (slot == ${component.id} && changeType == 1) {
							<@procedureOBJToCode component.onTakenFromSlot/>
						}
					</#if>
					<#if hasProcedure(component.onStackTransfer)>
						if (slot == ${component.id} && changeType == 2) {
							int amount = meta;
							<@procedureOBJToCode component.onStackTransfer/>
						}
					</#if>
				</#if>
					</#list>
		});
	}
}
<#-- @formatter:on -->
