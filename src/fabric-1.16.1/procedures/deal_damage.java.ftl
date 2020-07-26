<#if field$damagesource?has_content>
    ${input$entity}.damage(DamageSource.${generator.map(field$damagesource, "damagesources")},(float)${input$amount}F);
<#else>
    ${input$entity}.damage(DamageSource.GENERIC,(float)${input$amount});
</#if>