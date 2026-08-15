<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2012-2020, Pylo
 # Copyright (C) 2020-2025, Pylo, opensource contributors
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
package ${package}.procedures;

<#assign nullableDependencies = []/>
<#if !(data.skipDependencyNullCheck)>
	<#list dependencies as dependency>
		<#if dependency.getRawType() != "number"
			&& dependency.getRawType() != "world"
			&& dependency.getRawType() != "itemstack"
			&& dependency.getRawType() != "blockstate"
			&& dependency.getRawType() != "actionresulttype"
			&& dependency.getRawType() != "logic"
			&& dependency.getRawType() != "cmdcontext">
			<#assign nullableDependencies += [dependency.getName()]/>
		</#if>
	</#list>
</#if>

<#assign methodSignature><#list dependencies as d>${d.getType(generator.getWorkspace())} ${d.getName()}<#sep>, </#list></#assign>
<#assign methodArgs><#list dependencies as d>${d.getName()}<#sep>, </#list></#assign>

<#-- Variants without the world dependency, with a leading comma per entry, so blocks can pass a custom world in its place -->
<#assign methodSignatureNoWorld><#list dependencies as d><#if d.getName() != "world">, ${d.getType(generator.getWorkspace())} ${d.getName()}</#if></#list></#assign>
<#assign methodArgsNoWorld><#list dependencies as d><#if d.getName() != "world">, ${d.getName()}</#if></#list></#assign>

<@javacompress>

public class ${name}Procedure {
<#if trigger_code?has_content>
    public static boolean eventResult = true;

    ${trigger_code}
</#if>

	public static <#if return_type??>${return_type.getJavaType(generator.getWorkspace())}<#else>void</#if> execute(${methodSignature}) {
		<#if nullableDependencies?has_content>
			if (
			<#list nullableDependencies as dependency>
			${dependency} == null <#sep>||
			</#list>
			) return <#if return_type??>${return_type.getDefaultValue(generator.getWorkspace())}</#if>;
		</#if>

		<#list localvariables as var>
			<@var.getType().getScopeDefinition(generator.getWorkspace(), "LOCAL")['init']?interpret/>
		</#list>

		${procedurecode?replace("@procedureSignatureNoWorld@", methodSignatureNoWorld)?replace("@procedureArgsNoWorld@", methodArgsNoWorld)}
	}

	${additional_code?replace("@procedureSignatureNoWorld@", methodSignatureNoWorld)?replace("@procedureArgsNoWorld@", methodArgsNoWorld)}

	${extra_templates_code}
}
</@javacompress>
<#-- @formatter:on -->