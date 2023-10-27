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
package ${package}.procedures;

import javax.annotation.Nullable;

<#assign nullableDependencies = []/>
<#list dependencies as dependency>
	<#if dependency.getType(generator.getWorkspace()) != "double"
		&& dependency.getType(generator.getWorkspace()) != "LevelAccessor"
		&& dependency.getType(generator.getWorkspace()) != "ItemStack"
		&& dependency.getType(generator.getWorkspace()) != "BlockState"
		&& dependency.getType(generator.getWorkspace()) != "InteractionResult"
		&& dependency.getType(generator.getWorkspace()) != "boolean"
		&& dependency.getType(generator.getWorkspace()) != "CommandContext<CommandSourceStack>">
		<#assign nullableDependencies += [dependency.getName()]/>
	</#if>
</#list>

<#compress>

public class ${name}Procedure {

<#if trigger_code?has_content>
    ${trigger_code}
</#if>

	public static <#if return_type??>${return_type.getJavaType(generator.getWorkspace())}<#else>void</#if> execute(
		<#list dependencies as dependency>
				${dependency.getType(generator.getWorkspace())} ${dependency.getName()}<#if dependency?has_next>,</#if>
		</#list>
	) {
		<#if nullableDependencies?has_content>
			if(
			<#list nullableDependencies as dependency>
			${dependency} == null <#if dependency?has_next>||</#if>
			</#list>
			) return <#if return_type??>${return_type.getDefaultValue(generator.getWorkspace())}</#if>;
		</#if>

		<#list localvariables as var>
			<@var.getType().getScopeDefinition(generator.getWorkspace(), "LOCAL")['init']?interpret/>
		</#list>

		${procedurecode}
	}

}

</#compress>

<#-- @formatter:on -->
