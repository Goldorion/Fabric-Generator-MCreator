<#-- @formatter:off -->

package ${package}.item;


import net.fabricmc.api.EnvType;
import net.fabricmc.api.Environment;

public class ${name}Item extends <#if data.toolType == "Pickaxe"> PickaxeItem  <#elseif data.toolType == "Axe"> AxeItem <#elseif data.toolType == "Sword"> SwordItem <#elseif data.toolType == "Spade"> ShovelItem <#elseif data.toolType == "Hoe"> HoeItem </#if> {

	public ${name}Item(${name}Material ${name})
 	{
		super(${name}, 0,<#if data.toolType != "Hoe"> -1.0f,</#if> new Item.Settings().group(${data.creativeTab}));
	}

<<<<<<< HEAD
	<#if data.hasGlow>
	@Environment(EnvType.CLIENT)
	@Override
	public boolean hasEnchantmentGlint(ItemStack stack)
	{
			return true;
	}
	</#if>

=======
>>>>>>> 4b3d429296c3c8b7ae0d6a72719c396482d1b620
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


=======
>>>>>>> 4b3d429296c3c8b7ae0d6a72719c396482d1b620
}
<#-- @formatter:on -->
