<#-- @formatter:off -->

package ${package}.block;

import net.fabricmc.fabric.api.tools.FabricToolTags;
import net.fabricmc.fabric.api.object.builder.v1.block.FabricBlockSettings;
import net.fabricmc.api.EnvType;
import net.fabricmc.api.Environment;

public class ${name} extends Block {

	public ${name}(){
		super(FabricBlockSettings.of(Material.${data.material})<#if data.destroyTool != "Not specified">.breakByTool(FabricToolTags.${data.destroyTool?upper_case}S, ${data.breakHarvestLevel})<#else>
.breakByHand(true)
</#if>
.sounds(BlockSoundGroup.${data.soundOnStep}).strength(${data.hardness}f, ${data.resistance}f));
	}
	<#if data.mx != 0 || data.my != 0 || data.mz != 0 || data.Mx != 1 || data.My != 1 || data.Mz != 1>
	@Override
 	public VoxelShape getOutlineShape(BlockState state, BlockView view, BlockPos pos, EntityContext ctx) {
     return VoxelShapes.cuboid(${data.mx}D, ${data.my}D, ${data.mz}D, ${data.Mx}D, ${data.My}D, ${data.Mz}D);
 	}
 	</#if>

    @Override
    public int getLuminance(BlockState state) {
        return ${(data.luminance * 15)?round};
    }

		@Override
    public int getOpacity(BlockState state, BlockView view, BlockPos pos) {
        return ${data.lightOpacity};
    }

}

<#-- @formatter:on -->
