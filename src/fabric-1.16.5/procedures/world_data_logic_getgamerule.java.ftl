<#if generator.map(field$gamerulesboolean, "gamerules") != "null">
    world.getGameRules().getBoolean(${generator.map(field$gamerulesboolean, "gamerules")})
<#else>
    false
</#if>