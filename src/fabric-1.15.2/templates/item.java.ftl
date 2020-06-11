<#-- @formatter:off -->
<#include "mcitems.ftl">

package ${package}.item;

public class ${name} extends Item
{
    public ${name}()
    {
        super(new Settings().group(${data.creativeTab})
			<#if data.damageCount != 0>.maxDamage(${data.damageCount})
			<#else>.maxCount(${data.stackSize})</#if>
			<#if data.stayInGridWhenCrafting>
			.recipeRemainder(${mappedMCItemToItem(mappedBlock,1)})</#if>);
    }
}
<#-- @formatter:on -->