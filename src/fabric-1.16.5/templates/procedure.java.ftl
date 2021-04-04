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
package ${package}.procedures;

import java.util.Map;
import java.util.HashMap;

public class ${name}Procedure {

    public static <#if return_type??>${return_type.getJavaType(generator.getWorkspace())}<#else>void</#if> executeProcedure(Map<String, Object> dependencies){
        <#list dependencies as dependency>
            if(dependencies.get("${dependency.getName()}")==null){
                System.err.println("Failed to load dependency ${dependency.getName()} for procedure ${name}!");
                <#if return_type??>return ${return_type.getDefaultValue(generator.getWorkspace())}<#else>return</#if>;
            }
        </#list>

        <#list dependencies as dependency>
            <#if dependency.getType(generator.getWorkspace()) == "double">
                double ${dependency.getName()} = (double) dependencies.get("${dependency.getName()}");
            <#else>
            	${dependency.getType(generator.getWorkspace())} ${dependency.getName()} = (${dependency.getType(generator.getWorkspace())}) dependencies.get("${dependency.getName()}");
            </#if>
        </#list>

        ${procedurecode}
    }

    ${trigger_code}

}
<#-- @formatter:on -->
