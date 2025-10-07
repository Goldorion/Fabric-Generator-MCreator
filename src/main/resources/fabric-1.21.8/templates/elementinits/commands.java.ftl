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

/*
 *	MCreator note: This file will be REGENERATED on each build.
 */

package ${package}.init;

<#assign clientCommands = commands?filter(e -> e.type == "CLIENTSIDE")>
<#assign nonClientCommands = commands?filter(e -> e.type != "CLIENTSIDE")>

public class ${JavaModName}Commands {

	<#if nonClientCommands?has_content>
	public static void load() {
		CommandRegistrationCallback.EVENT.register((dispatcher, commandBuildContext, environment) -> {
		<#list nonClientCommands as command>
			${command.getModElement().getName()}Command.register(dispatcher, commandBuildContext, environment);
		</#list>
		});
	}
	</#if>

	<#if clientCommands?has_content>
	@Environment(EnvType.CLIENT) public static void clientLoad() {
		CommandRegistrationCallback.EVENT.register((dispatcher, commandBuildContext, environment) -> {
		<#list clientCommands as command>
			${command.getModElement().getName()}Command.register(dispatcher, commandBuildContext, environment);
		</#list>
		});
	}
	</#if>
}
<#-- @formatter:on -->