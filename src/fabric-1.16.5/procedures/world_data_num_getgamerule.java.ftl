<#if generator.map(field$gamerulesnumber, "gamerules") != "null">
    world.getGameRules().getInt(${generator.map(field$gamerulesnumber, "gamerules")})
<#else>
    0
</#if>