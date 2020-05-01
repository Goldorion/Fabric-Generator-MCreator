<#-- @formatter:off -->
<#include "mcitems.ftl">

package ${package}.fuel;

public class ${name}Fuel {

	@Override
	public void initialize() {
		FuelRegistry.INSTANCE.add(${mappedMCItemToItem(data.block)}, ${data.power});
	}

}
<#-- @formatter:on -->