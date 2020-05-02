<#-- @formatter:off -->

package ${package}.item;

public class ${name}Item extends <#if data.toolType == "Pickaxe"> PickaxeItem  <#elseif data.toolType == "Axe"> AxeItem <#elseif data.toolType == "Sword"> SwordItem <#elseif data.toolType == "Spade"> ShovelItem <#elseif data.toolType == "Hoe"> HoeItem </#if> {

	public ${name}Item(${name}Material ${name}) {
		super(${name}, 0,<#if data.toolType != "Hoe"> -1.0f,</#if> new Item.Settings().group(${data.creativeTab}));


	}

}
<#-- @formatter:on -->