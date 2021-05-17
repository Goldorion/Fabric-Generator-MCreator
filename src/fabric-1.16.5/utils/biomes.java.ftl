<#macro biomeKeys biomes>
    <#list biomes as biome>
        RegistryKey.of(Registry.BIOME_KEY, new Identifier("${biome?lower_case}"))<#if biome?has_next>,</#if>
    </#list>
</#macro>