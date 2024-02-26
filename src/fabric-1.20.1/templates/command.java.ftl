<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2012-2020, Pylo
 # Copyright (C) 2020-2023, Pylo, opensource contributors
 # Copyright (C) 2020-2023, Goldorion, opensource contributors
 #
 # Fabric-Generator-MCreator is free software: you can redistribute it and/or modify
 # it under the terms of the GNU Lesser General Public License as published by
 # the Free Software Foundation, either version 3 of the License, or
 # (at your option) any later version.

 # Fabric-Generator-MCreator is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 # GNU Lesser General Public License for more details.
 #
 # You should have received a copy of the GNU Lesser General Public License
 # along with Fabric-Generator-MCreator.  If not, see <https://www.gnu.org/licenses/>.
-->

<#-- @formatter:off -->
<#include "procedures.java.ftl">

package ${package}.command;

public class ${name}Command {

	public static void register(CommandDispatcher<CommandSourceStack> dispatcher, CommandBuildContext commandBuildContext, Commands.CommandSelection environment) {
	    <#if data.type = "MULTIPLAYER_ONLY" || data.type = "SINGLEPLAYER_ONLY">
		if (environment.include${data.type?replace("MULTIPLAYER_ONLY", "Dedicated")?replace("SINGLEPLAYER_ONLY", "Integrated")?replace("STANDARD", "")?replace("CLIENTSIDE", "")})
		</#if>
			dispatcher.register(Commands.literal("${data.commandName}")
				<#if data.permissionLevel != "No requirement">.requires(s -> s.hasPermission(${data.permissionLevel}))</#if>
				${argscode}
			);
	}

}
<#-- @formatter:on -->