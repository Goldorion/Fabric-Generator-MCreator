<@head>if (${input$entity} instanceof LivingEntity _livingEntity${cbi} && _livingEntity${cbi}.getAttributes().hasAttribute(${generator.map(field$attribute, "attributes")})) {</@head>
	_livingEntity${cbi}.getAttribute(${generator.map(field$attribute, "attributes")}).setBaseValue(${input$value});
<@tail>}</@tail>