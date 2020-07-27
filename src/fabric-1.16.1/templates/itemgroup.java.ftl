<#-- @formatter:off -->
<#include "mcitems.ftl">

package ${package}.item;

import net.fabricmc.fabric.api.client.itemgroup.FabricItemGroupBuilder;

public final class ${name}ItemGroup {
    public static ItemGroup get(){
        return ITEM_GROUP;
    }

    private static final ItemGroup ITEM_GROUP = FabricItemGroupBuilder
            .create(new Identifier("${modid}","${registryname}"))
            .icon(()->{
                return new ItemStack(${mappedMCItemToItem(data.icon)?remove_ending(", (int)(1)")});
            })
            .build();
}

<#-- @formatter:on -->
