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
package ${package}.procedures;

public class ${name}Procedure {

    ${trigger_code}

	public static <#if return_type??>${return_type.getJavaType(generator.getWorkspace())}<#else>void</#if> execute(Map<String, Object> dependencies) {
    		<#list dependencies as dependency>
    			if(dependencies.get("${dependency.getName()}") == null) {
    				if(!dependencies.containsKey("${dependency.getName()}"))
    					${JavaModName}.LOGGER.warn("Failed to load dependency ${dependency.getName()} for procedure ${name}!");
    				<#if return_type??>return ${return_type.getDefaultValue(generator.getWorkspace())}<#else>return</#if>;
    			}
            </#list>

    		<#list dependencies as dependency>
    			<#if dependency.getType(generator.getWorkspace()) == "double">
    				double ${dependency.getName()} = dependencies.get("${dependency.getName()}") instanceof Integer
    					? (int) dependencies.get("${dependency.getName()}") : (double) dependencies.get("${dependency.getName()}");
    			<#else>
    				${dependency.getType(generator.getWorkspace())} ${dependency.getName()} = (${dependency.getType(generator.getWorkspace())}) dependencies.get("${dependency.getName()}");
    			</#if>
    		</#list>

    		<#list localvariables as var>
    			<@var.getType().getScopeDefinition(generator.getWorkspace(), "LOCAL")['init']?interpret/>
    		</#list>

    		${procedurecode}
    	}

}
<#-- @formatter:on -->
