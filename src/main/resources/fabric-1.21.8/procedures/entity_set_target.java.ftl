<#if input$sourceentity == "null">
<@head>if (${input$entity} instanceof Mob _entity) {</@head>
    _entity.setTarget(null);
<@tail>}</@tail>
<#else>
<@head>if (${input$entity} instanceof Mob _entity && ${input$sourceentity} instanceof LivingEntity _ent) { </@head>
    _entity.setTarget(_ent);
<@tail>}</@tail>
</#if>