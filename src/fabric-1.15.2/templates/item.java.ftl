<<<<<<< HEAD
<#-- @formatter:off -->
<#include "mcitems.ftl">

package ${package}.item;

import net.fabricmc.api.EnvType;
import net.fabricmc.api.Environment;

=======
<#-- @formatter:off -->
<#include "mcitems.ftl">

package ${package}.item;

import net.fabricmc.api.EnvType;
import net.fabricmc.api.Environment;

>>>>>>> 4b3d429296c3c8b7ae0d6a72719c396482d1b620
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

    <#if data.hasGlow>
    @Environment(EnvType.CLIENT)
    @Override
    public boolean hasEnchantmentGlint(ItemStack stack)
    {
        return true;
    }
    </#if>

    <#if data.specialInfo?has_content>
		@Override
    public void appendTooltip(ItemStack stack, World world, List<Text> tooltip, TooltipContext context)
    {
		    <#list data.specialInfo as entry>
  	     tooltip.add(new LiteralText("${JavaConventions.escapeStringForJava(entry)}"));
         </#list>
		}
    </#if>
<<<<<<< HEAD
}

<#-- @formatter:on -->
=======
}
<#-- @formatter:on -->
>>>>>>> 4b3d429296c3c8b7ae0d6a72719c396482d1b620
