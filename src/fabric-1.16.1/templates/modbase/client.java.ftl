<#-- @formatter:off -->
/*
*    MCreator note:
*
*    If you lock base mod element files, you can edit this file and the proxy files
*    and they won't get overwritten. If you change your mod package or modid, you
*    need to apply these changes to this file MANUALLY.
*
*
*    If you do not lock base mod element files in Workspace settings, this file
*    will be REGENERATED on each build.
*
*/

package ${package};

import net.fabricmc.fabric.api.blockrenderlayer.v1.*;
import net.fabricmc.api.ClientModInitializer;

public class ClientInit implements ClientModInitializer{
    @Override
    public void onInitializeClient(){
    <#list w.getElementsOfType("BLOCK") as block>
        <#assign ge = block.getGeneratableElement()>
        <#if ge.transparencyType == "CUTOUT">
		BlockRenderLayerMap.INSTANCE.putBlock(block, RenderLayer.getCutout());
        <#elseif ge.transparencyType == "CUTOUT_MIPPED">
		BlockRenderLayerMap.INSTANCE.putBlock(block, RenderLayer.getCutoutMipped());
        <#elseif ge.transparencyType == "TRANSLUCENT">
		BlockRenderLayerMap.INSTANCE.putBlock(block, RenderLayer.getTranslucent());
        </#if>
    </#list>
        <#list w.getElementsOfType("CODE") as code>
            ${code}CustomCode.initializeClient();
        </#list>
    }
}

<#-- @formatter:on -->

