<#-- @formatter:off -->
<#include "mcitems.ftl">

package ${package}.itemgroup;

public class ${name} implements ModInitializer{

		public static final ItemGroup ${name} = FabricItemGroupBuilder.build(
    		new Identifier("${modid}", "${registryname}"),
    		() -> new ItemStack(${mappedMCItemToItemStackCode(data.icon, 1)}));

}
<#-- @formatter:on -->