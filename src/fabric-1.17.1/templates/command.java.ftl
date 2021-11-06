<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2020-2021, Goldorion, opensource contributors
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

	public static void register(CommandDispatcher<CommandSourceStack> dispatcher) {
		dispatcher.register(Commands.literal("${data.commandName}")
			<#if data.permissionLevel != "No requirement">.requires(s -> s.hasPermission(${data.permissionLevel}))</#if>
			.then(Commands.argument("arguments", StringArgumentType.greedyString())
				<#if hasProcedure(data.onCommandExecuted)>
            	    .executes(${name}Command::execute)
				</#if>
			)
			<#if hasProcedure(data.onCommandExecuted)>
                .executes(${name}Command::execute)
			</#if>
		);
	}

    private static int execute(CommandContext<CommandSourceStack> ctx) {
		ServerLevel world = ctx.getSource().getLevel();

		double x = ctx.getSource().getPosition().x();
		double y = ctx.getSource().getPosition().y();
		double z = ctx.getSource().getPosition().z();

		Entity entity = ctx.getSource().getEntity();

		HashMap<String, String> cmdparams = new HashMap<>();
		int[] index = { -1 };
		Arrays.stream(ctx.getInput().split("\\s+")).forEach(param -> {
			if(index[0] >= 0)
				cmdparams.put(Integer.toString(index[0]), param);
			index[0]++;
		});

		<@procedureOBJToCode data.onCommandExecuted/>

		return 0;
	}

}
<#-- @formatter:on -->