<#-- @formatter:off -->
<#include "mcitems.ftl">

package ${package}.item;

import net.fabricmc.fabric.api.registry.FuelRegistry;

public class ${name}Fuel {
    public static void initialize() {
        FuelRegistry.INSTANCE.add(${mappedMCItemToItemStackCodeNoItemStackValue(data.block)}, ${data.power});
    }
}
<#-- @formatter:on -->
