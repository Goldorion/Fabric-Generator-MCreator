<#include "mcelements.ftl">
<#assign attr = generator.map(field$attribute, "attributes")>
<@head>if (${input$entity} instanceof LivingEntity _entity) {</@head>
	AttributeModifier modifier${cbi} = new AttributeModifier(${toResourceLocation('"' + modid + ':' + field$name + '"')}, ${input$value}, AttributeModifier.Operation.${field$operation});
	if (!_entity.getAttribute(${attr}).hasModifier(modifier${cbi}.id())) {
		<#if field$permanent == "TRUE">
			_entity.getAttribute(${attr}).addPermanentModifier(modifier${cbi});
		<#else>
			_entity.getAttribute(${attr}).addTransientModifier(modifier${cbi});
		</#if>
	}
<@tail>}</@tail>