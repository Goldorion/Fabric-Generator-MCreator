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

public record ${name}SliderMessage(int sliderID, int x, int y, int z, double value) implements CustomPacketPayload {

	public static final Type<${name}SliderMessage> TYPE = new Type<>(ResourceLocation.fromNamespaceAndPath(${JavaModName}.MODID, "${registryname}_sliders"));

	public static final StreamCodec<RegistryFriendlyByteBuf, ${name}SliderMessage> STREAM_CODEC = StreamCodec.of(
			(RegistryFriendlyByteBuf buffer, ${name}SliderMessage message) -> {
				buffer.writeInt(message.sliderID);
				buffer.writeInt(message.x);
				buffer.writeInt(message.y);
				buffer.writeInt(message.z);
				buffer.writeDouble(message.value);
			},
			(RegistryFriendlyByteBuf buffer) -> new ${name}SliderMessage(buffer.readInt(), buffer.readInt(), buffer.readInt(), buffer.readInt(), buffer.readDouble())
	);

	@Override public Type<${name}SliderMessage> type() {
		return TYPE;
	}

	public static void handleData(final ${name}SliderMessage message, final ServerPlayNetworking.Context context) {
		context.server().execute(() -> handleSliderAction(context.player(), message.sliderID, message.x, message.y, message.z, message.value));
	}

	public static void handleSliderAction(Player entity, int sliderID, int x, int y, int z, double value) {
		Level world = entity.level();

		// security measure to prevent arbitrary chunk generation
		if (!world.getChunkSource().hasChunk(SectionPos.blockToSectionCoord(x), SectionPos.blockToSectionCoord(z)))
			return;

		<#assign slid = 0>
		<#list data.getComponentsOfType("Slider") as component>
			<#if hasProcedure(component.whenSliderMoves)>
				if (sliderID == ${slid}) {
					<@procedureOBJToCode component.whenSliderMoves/>
				}
			</#if>
			<#assign slid +=1>
		</#list>
	}
}
<#-- @formatter:on -->