<#macro procedureToCode name dependencies customVals={}>
    {
            java.util.HashMap<String, Object> $_dependencies=new java.util.HashMap<>();
    	<#list dependencies as dependency>
            <#if !customVals[dependency.getName()]?? >
		        $_dependencies.put("${dependency.getName()}",${dependency.getName()});
            </#if>
        </#list>
        <#list customVals as key, value>
            $_dependencies.put("${key}",${value});
        </#list>

    ${(name)}Procedure.executeProcedure($_dependencies);
        }
</#macro>

<#macro procedureOBJToCode object="">
    <#if object?? && object?has_content && object.getName() != "null">
        <@procedureToCode name=object.getName() dependencies=object.getDependencies(generator.getWorkspace()) />
    </#if>
</#macro>

<#macro procedureToRetvalCode name dependencies customVals={}>
    <#assign depsBuilder = []>

    <#list dependencies as dependency>
        <#if !customVals[dependency.getName()]?? >
            <#assign depsBuilder += ["\"" + dependency.getName() + "\""]>
            <#assign depsBuilder += [dependency.getName()]>
        </#if>
    </#list>

    <#list customVals as key, value>
        <#assign depsBuilder += ["\"" + key + "\""]>
        <#assign depsBuilder += [value]>
    </#list>

    ${(name)}Procedure.executeProcedure(ImmutableMap.of(
        <#list depsBuilder as dep>
            ${dep}<#if dep?has_next>,</#if>
        </#list>
    ))
</#macro>

<#function hasProcedure object="">
    <#return object?? && object?has_content && object.getName() != "null">
</#function>

<#macro procedureOBJToConditionCode object="">
    <#if object?? && object?has_content && object.getName() != "null">
        <@procedureToRetvalCode name=object.getName() dependencies=object.getDependencies(generator.getWorkspace()) />
    <#else>
        true
    </#if>
</#macro>
