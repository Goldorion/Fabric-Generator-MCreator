<#--
This file is part of Fabric-Generator-MCreator.

Fabric-Generator-MCreator is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Fabric-Generator-MCreator is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with Fabric-Generator-MCreator.  If not, see <https://www.gnu.org/licenses/>.
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

@Environment(EnvType.CLIENT)
public class ClientInit implements ClientModInitializer{

    <#list w.getElementsOfType("keybind") as keybind>
        public static final KeyBinding ${keybind}_KEY = KeyBindingHelper.registerKeyBinding(new ${keybind}KeyBinding());
    </#list>

    <#list w.getElementsOfType("particle") as particle>
        <#assign ge = particle.getGeneratableElement()>
        public static final DefaultParticleType ${particle}_PARTICLE = Registry.register(Registry.PARTICLE_TYPE, "${modid}:${particle.getRegistryName()}",
            FabricParticleTypes.simple(${ge.alwaysShow}));
    </#list>

    @Override
    public void onInitializeClient(){
    <#list w.getElementsOfType("block") as block>
        <#assign ge = block.getGeneratableElement()>
        <#if ge.transparencyType == "CUTOUT">
		    BlockRenderLayerMap.INSTANCE.putBlock(${block}_BLOCK, RenderLayer.getCutout());
        <#elseif ge.transparencyType == "TRANSLUCENT">
		    BlockRenderLayerMap.INSTANCE.putBlock(${block}_BLOCK, RenderLayer.getTranslucent());
		<#else>
            BlockRenderLayerMap.INSTANCE.putBlock(${JavaModName}.${block}_BLOCK, RenderLayer.getCutoutMipped());
        </#if>
    </#list>

    <#list w.getElementsOfType("plant") as plant>
        BlockRenderLayerMap.INSTANCE.putBlock(${JavaModName}.${plant}_BLOCK, RenderLayer.getCutoutMipped());
    </#list>

	<#list w.getElementsOfType("livingentity") as entity>
		${entity}EntityRenderer.clientInit();
	</#list>

    <#list w.getElementsOfType("code") as code>
        ${code}CustomCode.initializeClient();
    </#list>

    <#list w.getElementsOfType("particle") as particle>
        ParticleFactoryRegistry.getInstance().register(${particle}_PARTICLE, ${particle}Particle.CustomParticleFactory::new);
    </#list>

        HudRenderCallback.EVENT.register((matrices, tickDelta) -> {
        <#list w.getElementsOfType("overlay") as overlay>
            ${overlay}Overlay.render(matrices, tickDelta);
        </#list>
        });

        <#list w.getElementsOfType("gui") as gui>
            ScreenRegistry.register(${JavaModName}.${gui}ScreenType, ${gui}GuiWindow::new);
        </#list>

        ClientTickEvents.END_CLIENT_TICK.register((client) -> {
            <#list w.getElementsOfType("keybind") as keybind>
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
