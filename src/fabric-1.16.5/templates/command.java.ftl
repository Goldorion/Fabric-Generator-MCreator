<#--
This file is part of Fabric-Generator-MCreator.

MCreatorFabricGenerator is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

MCreatorFabricGenerator is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with MCreatorFabricGenerator.  If not, see <https://www.gnu.org/licenses/>.
-->

<#-- @formatter:off -->
<#include "procedures.java.ftl">

package ${package}.server;

import java.util.HashMap;
import java.util.Map;

public class ${name}Command {

    public static void register(CommandDispatcher<ServerCommandSource> dispatcher) {
        dispatcher.register(CommandManager.literal("${data.commandName}")
                <#if data.permissionLevel != "No requirement">.requires(s -> s.hasPermissionLevel(${data.permissionLevel}))</#if>
        .then(CommandManager.argument("arguments", StringArgumentType.greedyString())
			<#if hasProcedure(data.onCommandExecuted)>
            .executes(${name}Command::execute)
            </#if>
        )
			<#if hasProcedure(data.onCommandExecuted)>
            .executes(${name}Command::execute)
            </#if>
        );
    }

    private static int execute(CommandContext<ServerCommandSource> ctx) {
        ServerWorld world = ctx.getSource().getWorld();

        double x = ctx.getSource().getPosition().getX();
        double y = ctx.getSource().getPosition().getY();
        double z = ctx.getSource().getPosition().getZ();

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