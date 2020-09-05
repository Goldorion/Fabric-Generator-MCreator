<#--
This file is part of MCreatorFabricGenerator.

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
