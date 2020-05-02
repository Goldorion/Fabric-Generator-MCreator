<#-- @formatter:off -->
<#include "mcitems.ftl">

package ${package}.block;

import net.fabricmc.fabric.api.tools.FabricToolTags;

public class ${name} extends Block {
	
	public ${name}(){
		super(FabricBlockSettings.of(Material.${data.material})<#if data.destroyTool != "Not Specified">.breakByTool(FabricToolTags.${data.destroyTool?upper_case}S)</#if>.sounds(BlockSoundGroup.${data.soundOnStep}).strength(${data.hardness}, ${data.resistance}f).build());
	}
}

<#-- @formatter:on -->