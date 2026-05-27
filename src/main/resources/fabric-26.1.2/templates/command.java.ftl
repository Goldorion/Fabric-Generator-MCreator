<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2012-2020, Pylo
 # Copyright (C) 2020-2026, Pylo, opensource contributors
 # Copyright (C) 2020-2026, Goldorion, opensource contributors
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
<#include "procedures.java.ftl">

package ${package}.command;

<#if data.type == "CLIENTSIDE">@Environment(EnvType.CLIENT)</#if>
public class ${name}Command {

	public static void register(CommandDispatcher<CommandSourceStack> dispatcher, CommandBuildContext commandBuildContext, Commands.CommandSelection environment) {
		<#if data.type = "MULTIPLAYER_ONLY" || data.type = "SINGLEPLAYER_ONLY">
		if (environment.include${data.type?replace("MULTIPLAYER_ONLY", "Dedicated")?replace("SINGLEPLAYER_ONLY", "Integrated")})
		</#if>
		dispatcher.register(Commands.literal("${data.commandName}")
			<#if data.permissionLevel != "No requirement">.requires(Commands.hasPermission(Commands.${permissionLevelNumberToEnum(data.permissionLevel)}))</#if>
			${argscode}
		);
	}
}

<#function permissionLevelNumberToEnum level>
	<#if level == "0">
		<#return "LEVEL_ALL">
	<#elseif level == "1">
		<#return "LEVEL_MODERATORS">
	<#elseif level == "2">
		<#return "LEVEL_GAMEMASTERS">
	<#elseif level == "3">
		<#return "LEVEL_ADMINS">
	<#elseif level == "4">
		<#return "LEVEL_OWNERS">
	</#if>
</#function>
<#-- @formatter:on -->