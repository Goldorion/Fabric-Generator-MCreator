<#-- @formatter:off -->
<#include "../mcitems.ftl">
{
    "group": "<#if data.group?has_content>${data.group}<#else>${modid}</#if>",
    "type": "minecraft:campfire_cooking",
    "experience": ${data.xpReward},
    "ingredient": {
      ${mappedMCItemToIngameItemName(data.campfireCookingInputStack)}
    },
    "result": {
      ${mappedMCItemToIngameItemName(data.campfireCookingReturnStack)}
    }
}
<#-- @formatter:on -->