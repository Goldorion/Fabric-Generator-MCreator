<#include "mcelements.ftl">
<@head>if (${input$entity} instanceof LivingEntity _entity) {</@head>
	_entity.getAttribute(${generator.map(field$attribute, "attributes")}).removeModifier(${toResourceLocation('"' + modid + ':' + field$name + '"')});
<@tail>}</@tail>