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
<#include "../procedures.java.ftl">

package ${package}.network;

public record ${name}ButtonMessage(int buttonID, int x, int y, int z) implements CustomPacketPayload {

	public static final Type<${name}ButtonMessage> TYPE = new Type<>(ResourceLocation.fromNamespaceAndPath(${JavaModName}.MODID, "${registryname}_buttons"));

	public static final StreamCodec<RegistryFriendlyByteBuf, ${name}ButtonMessage> STREAM_CODEC = StreamCodec.of(
			(RegistryFriendlyByteBuf buffer, ${name}ButtonMessage message) -> {
				buffer.writeInt(message.buttonID);
				buffer.writeInt(message.x);
				buffer.writeInt(message.y);
				buffer.writeInt(message.z);
			},
			(RegistryFriendlyByteBuf buffer) -> new ${name}ButtonMessage(buffer.readInt(), buffer.readInt(), buffer.readInt(), buffer.readInt())
	);

	@Override public Type<${name}ButtonMessage> type() {
		return TYPE;
	}

	public static void handleData(final ${name}ButtonMessage message, final ServerPlayNetworking.Context context) {
		context.server().execute(() -> handleButtonAction(context.player(), message.buttonID, message.x, message.y, message.z));
	}

	public static void handleButtonAction(Player entity, int buttonID, int x, int y, int z) {
		Level world = entity.level();

		// security measure to prevent arbitrary chunk generation
		if (!world.getChunkSource().hasChunk(SectionPos.blockToSectionCoord(x), SectionPos.blockToSectionCoord(z)))
			return;

		<#assign btid = 0>
		<#list data.getComponentsOfType("Button") as component>
			<#if hasProcedure(component.onClick)>
				if (buttonID == ${btid}) {
					<@procedureOBJToCode component.onClick/>
				}
			</#if>
			<#assign btid +=1>
		</#list>
		<#list data.getComponentsOfType("ImageButton") as component>
			<#if hasProcedure(component.onClick)>
				if (buttonID == ${btid}) {
					<@procedureOBJToCode component.onClick/>
				}
			</#if>
			<#assign btid +=1>
		</#list>
	}
}
<#-- @formatter:on -->