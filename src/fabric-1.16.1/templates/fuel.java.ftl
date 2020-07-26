<#-- @formatter:off -->
<#include "mcitems.ftl">

package ${package}.item;

import net.fabricmc.fabric.api.registry.FuelRegistry;

public class ${name}Fuel {
    public static void initialize() {
        FuelRegistry.INSTANCE.add(${mappedMCItemToItem(data.block)?remove_ending(", (int)(1))")}, ${data.power});
    }
}
<#-- @formatter:on -->
