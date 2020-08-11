<#-- @formatter:off -->
<#include "procedures.java.ftl">

package ${package}.server;

import java.util.HashMap;
import java.util.Map;

public class ${name}Command {

    public static void register(CommandDispatcher<ServerCommandSource> dispatcher) {
        dispatcher.register(CommandManager.literal("${data.commandName}")
                .requires(s -> s.hasPermissionLevel(${data.permissionLevel}))
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

    private static int execute(Command<ServerCommandSource> ctx) {
        ServerWorld world = ctx.getSource().getWorld();

        double x = ctx.getSource().getPos().getX();
        double y = ctx.getSource().getPos().getY();
        double z = ctx.getSource().getPos().getZ();

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