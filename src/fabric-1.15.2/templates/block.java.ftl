<#-- @formatter:off -->

package ${package}.block;

import net.fabricmc.fabric.api.tools.FabricToolTags;
import net.fabricmc.fabric.api.object.builder.v1.block.FabricBlockSettings;

public class ${name} extends Block {

	public ${name}(){
		super(FabricBlockSettings.of(Material.${data.material})<#if data.destroyTool != "Not specified">.breakByTool(FabricToolTags.${data.destroyTool?upper_case}S, ${data.breakHarvestLevel})<#else>
.breakByHand(true)
</#if>
.sounds(BlockSoundGroup.${data.soundOnStep}).strength(${data.hardness}f, ${data.resistance}f));
	}
}

<#-- @formatter:on -->
