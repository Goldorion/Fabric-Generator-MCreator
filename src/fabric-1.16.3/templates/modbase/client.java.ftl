<#--
This file is part of MCreatorFabricGenerator.

MCreatorFabricGenerator is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

MCreatorFabricGenerator is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with MCreatorFabricGenerator.  If not, see <https://www.gnu.org/licenses/>.
-->

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
import ${package}.client;
import net.fabricmc.fabric.api.client.event.lifecycle.v1.ClientTickEvents;

public class ClientInit implements ClientModInitializer{

    <#list w.getElementsOfType("KEYBIND") as keybind>
        public static final KeyBinding ${keybind}_KEY = KeyBindingHelper.registerKeyBinding(new ${keybind}KeyBinding());
    </#list>

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

    <#list w.getElementsOfType("BLOCK") as block>
        BlockRenderLayerMap.INSTANCE.putBlock(${JavaModName}.block_BLOCK, RenderLayer.getCutoutMipped());
    </#list>
        <#list w.getElementsOfType("CODE") as code>
            ${code}CustomCode.initializeClient();
        </#list>

        HudRenderCallback.EVENT.register((matrices, tickDelta) -> {
        <#list w.getElementsOfType("OVERLAY") as overlay>
            ${overlay}Overlay.render(matrices, tickDelta);
        </#list>
        });

        ClientTickEvents.END_CLIENT_TICK.register((client) -> {
            <#list w.getElementsOfType("KEYBIND") as keybind>
            if(((${keybind}KeyBinding) ${keybind}_KEY).isPressed() && !((${keybind}KeyBinding) ${keybind}_KEY).wasPressed()){
                ((${keybind}KeyBinding) ${keybind}_KEY).keyPressed(client.player);
            }
            if(!((${keybind}KeyBinding) ${keybind}_KEY).isPressed() && ((${keybind}KeyBinding) ${keybind}_KEY).wasPressed()){
                ((${keybind}KeyBinding) ${keybind}_KEY).keyReleased(client.player);
            };
            </#list>
        });
    }
}

<#-- @formatter:on -->
