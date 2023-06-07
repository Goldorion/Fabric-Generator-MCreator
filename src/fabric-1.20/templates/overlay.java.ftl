<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2012-2020, Pylo
 # Copyright (C) 2020-2021, Pylo, opensource contributors
 # Copyright (C) 2020-2022, Goldorion, opensource contributors
 #
 # Fabric-Generator-MCreator is free software: you can redistribute it and/or modify
 # it under the terms of the GNU Lesser General Public License as published by
 # the Free Software Foundation, either version 3 of the License, or
 # (at your option) any later version.

 # Fabric-Generator-MCreator is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 # GNU Lesser General Public License for more details.
 #
 # You should have received a copy of the GNU Lesser General Public License
 # along with Fabric-Generator-MCreator.  If not, see <https://www.gnu.org/licenses/>.
-->

<#-- @formatter:off -->
<#compress>
<#include "procedures.java.ftl">

package ${package}.client.gui;

import net.fabricmc.api.Environment;

@Environment(EnvType.CLIENT)
public class ${name}Overlay {

	public static void render(PoseStack matrices, float tickDelta) {
		int posX = Minecraft.getInstance().getWindow().getGuiScaledWidth() / 2;
		int posY = Minecraft.getInstance().getWindow().getGuiScaledHeight() / 2;

		Level _world = null;
		double _x = 0;
		double _y = 0;
		double _z = 0;

		Player entity = Minecraft.getInstance().player;
		if (entity != null) {
			_world = entity.level;
			_x = entity.getX();
			_y = entity.getY();
			_z = entity.getZ();
		}

		Level world = _world;
		double x = _x;
		double y = _y;
		double z = _z;

		<#if hasTextures>
			RenderSystem.disableDepthTest();
			RenderSystem.depthMask(false);
			RenderSystem.setShader(GameRenderer::getPositionTexShader);
			RenderSystem.blendFuncSeparate(GlStateManager.SourceFactor.SRC_ALPHA, GlStateManager.DestFactor.ONE_MINUS_SRC_ALPHA,
				GlStateManager.SourceFactor.ONE, GlStateManager.DestFactor.ZERO);
			RenderSystem.setShaderColor(1, 1, 1, 1);
		</#if>

		if (<@procedureOBJToConditionCode data.displayCondition/>) {
			<#if data.baseTexture?has_content>
				RenderSystem.setShaderTexture(0, new ResourceLocation("${modid}:textures/screens/${data.baseTexture}"));
				GuiComponent.blit(matrices, 0, 0, 0, 0, posX, posY, posX, posY);
			</#if>

            <#list data.getComponentsOfType("Image") as component>
                <#assign x = component.x - 213>
                <#assign y = component.y - 120>
                <#if hasProcedure(component.displayCondition)>
                        if (<@procedureOBJToConditionCode component.displayCondition/>) {
                </#if>
                    RenderSystem.setShaderTexture(0, new ResourceLocation("${modid}:textures/screens/${component.image}"));
                    Minecraft.getInstance().gui.blit(event.getPoseStack(), posX + ${x}, posY + ${y}, 0, 0,
                        ${component.getWidth(w.getWorkspace())}, ${component.getHeight(w.getWorkspace())},
                        ${component.getWidth(w.getWorkspace())}, ${component.getHeight(w.getWorkspace())});
                <#if hasProcedure(component.displayCondition)>}</#if>
            </#list>

            <#list data.getComponentsOfType("Label") as component>
                <#assign x = component.x - 213>
                <#assign y = component.y - 120>
                    <#if hasProcedure(component.displayCondition)>
                        if (<@procedureOBJToConditionCode component.displayCondition/>)
                    </#if>
                    Minecraft.getInstance().font.draw(event.getPoseStack(),
                        <#if hasProcedure(component.text)><@procedureOBJToStringCode component.text/><#else>Component.translatable("gui.${modid}.${registryname}.${component.getName()}")</#if>,
                        posX + ${x}, posY + ${y}, ${component.color.getRGB()});
            </#list>

			<#list data.getComponentsOfType("EntityModel") as component>
			    if (<@procedureOBJToConditionCode component.entityModel/> instanceof LivingEntity livingEntity) {
			    	<#if hasProcedure(component.displayCondition)>
                        if (<@procedureOBJToConditionCode component.displayCondition/>)
                    </#if>
			        InventoryScreen.renderEntityInInventory(posX + ${component.x - 202}, posY + ${component.y - 100},
                        ${component.scale}, ${component.rotationX / 20.0}f, 0, livingEntity);
			    }
			</#list>
		}

		<#if data.hasTextures()>
			RenderSystem.depthMask(true);
			RenderSystem.enableDepthTest();
			RenderSystem.setShaderColor(1, 1, 1, 1);
		</#if>
	}
}
</#compress>
<#-- @formatter:on -->