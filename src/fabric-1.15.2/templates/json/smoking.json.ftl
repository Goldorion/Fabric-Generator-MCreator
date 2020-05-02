<#-- @formatter:off -->
<#include "../mcitems.ftl">
{
    "group": "<#if data.group?has_content>${data.group}<#else>${modid}</#if>",
    "type": "minecraft:smoking",
    "experience": ${data.xpReward},
    "ingredient": {
      ${mappedMCItemToIngameItemName(data.smokingInputStack)}
    },
    "result": {
      ${mappedMCItemToIngameItemName(data.smokingReturnStack)}
    }
}
<#-- @formatter:on -->