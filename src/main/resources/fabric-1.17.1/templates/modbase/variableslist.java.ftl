<#-- @formatter:off -->
package ${package}.network;

import ${package}.${JavaModName};

import net.minecraft.nbt.Tag;

public class ${JavaModName}Variables {

	<#if w.hasVariablesOfScope("GLOBAL_SESSION")>
		<#list variables as var>
			<#if var.getScope().name() == "GLOBAL_SESSION">
				<@var.getType().getScopeDefinition(generator.getWorkspace(), "GLOBAL_SESSION")['init']?interpret/>
			</#if>
		</#list>
	</#if>

}
<#-- @formatter:on -->