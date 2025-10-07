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

/*
 *	MCreator note: This file will be REGENERATED on each build.
 */

package ${package}.init;

public class ${JavaModName}KeyMappingsServer {

	public static void serverLoad() {
		<#list keybinds as keybind>
			PayloadTypeRegistry.playC2S().register(${keybind.getModElement().getName()}Message.TYPE, ${keybind.getModElement().getName()}Message.STREAM_CODEC);
			ServerPlayNetworking.registerGlobalReceiver(${keybind.getModElement().getName()}Message.TYPE, ${keybind.getModElement().getName()}Message::handleData);
		</#list>
	}
}
<#-- @formatter:on -->