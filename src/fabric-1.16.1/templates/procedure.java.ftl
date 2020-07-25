<#-- @formatter:off -->
package ${package}.procedures;

import java.util.Map;
import java.util.HashMap;

public class ${name}Procedure {

    public static void executeProcedure(Map<String, Object> dependencies){
        <#list dependencies as dependency>
            if(dependencies.get("${dependency.getName()}")==null){
                System.err.println("Failed to load dependency ${dependency.getName()} for procedure ${name}!");
                return;
            }
        </#list>

        <#list dependencies as dependency>
            ${dependency.getType(generator.getWorkspace())} ${dependency.getName()} =(${dependency.getType(generator.getWorkspace())})dependencies.get("${dependency.getName()}" );
        </#list>

        ${procedurecode}
    }

    ${trigger_code}

}
<#-- @formatter:on -->
