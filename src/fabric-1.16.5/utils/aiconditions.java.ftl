<#include "procedures.java.ftl">
<#-- @formatter:off -->
<#macro conditionCode conditionfield="" includeBractets=true>
    <#if conditionfield?has_content>
        <#assign conditions = generator.procedureNamesToObjects(conditionfield)>
        <#if hasCondition(conditions[0]) || hasCondition(conditions[1])>
			<#if includeBractets>{</#if>
                <#if hasCondition(conditions[0])>
                @Override public boolean canStart() {
                	double x = ${name}Entity.this.getX();
			        double y = ${name}Entity.this.getY();
			        double z = ${name}Entity.this.getZ();
			        Entity entity = ${name}Entity.this;
			        World world = entity.getEntityWorld();
                	return super.canStart() && <@procedureOBJToConditionCode conditions[0]/>;
                }
                </#if>
                <#if hasCondition(conditions[1])>
                @Override public boolean shouldContinue() {
                	double x = ${name}Entity.this.getX();
			        double y = ${name}Entity.this.getY();
			        double z = ${name}Entity.this.getZ();
			        Entity entity = ${name}Entity.this;
			        World world = entity.getEntityWorld();
                	return super.shouldContinue() && <@procedureOBJToConditionCode conditions[0]/>;
                }
                </#if>
			<#if includeBractets>}</#if>
        </#if>
    </#if>
</#macro>
<#-- @formatter:on -->