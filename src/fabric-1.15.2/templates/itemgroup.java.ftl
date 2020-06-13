<#-- @formatter:off -->
<#include "mcitems.ftl">

package ${package}.item;

import net.fabricmc.fabric.api.client.itemgroup.FabricItemGroupBuilder;

public class ${name}ItemGroup {
    private static ItemGroup get(){
        return FabricItemGroupBuilder
        .create(new Identifier("${modid}","${registryname}"))
        .icon(()->{
          return new ItemStack(${mappedMCItemToItemStackCode(data.icon)});
        })
        .build();
    }

    public static ItemGroup tab = get();
}

<#-- @formatter:on -->
