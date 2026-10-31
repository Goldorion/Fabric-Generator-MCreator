{
	"replace": false,
	"values": [
		<#assign elements = []>
		<#list types.fluids as mod>
			<#if mod.type.toString()?lower_case == var_type>
				<#assign elements += ["${modid}:${mod.getModElement().getRegistryName()?lower_case}"]>
				<#assign elements += ["${modid}:flowing_${mod.getModElement().getRegistryName()?lower_case}"]>
			</#if>
		</#list>

		<#list elements as e>
			"${e}"<#sep>,
		</#list>
	]
}