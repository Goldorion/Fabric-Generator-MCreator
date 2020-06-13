<#-- @formatter:off -->
<#include "mcitems.ftl">

package ${package}.item;

public class ${name}Fuel {

	public void initialize() {
		FuelRegistry.INSTANCE.add(${mappedMCItemToItem(data.block)?replace("Blocks.", "")}, ${data.power});
	}

}
<#-- @formatter:on -->
