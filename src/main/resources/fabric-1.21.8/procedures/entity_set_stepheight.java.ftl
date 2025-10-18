<@head>if (${input$entity} instanceof LivingEntity _entity) {</@head>
	AttributeInstance _attrInst${cbi} = _entity.getAttribute(Attributes.STEP_HEIGHT);
	if (_attrInst${cbi} != null)
		_attrInst${cbi}.setBaseValue(${opt.toFloat(input$stepHeight)});
<@tail>}</@tail>