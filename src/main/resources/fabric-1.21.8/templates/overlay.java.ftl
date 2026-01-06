<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2012-2020, Pylo
 # Copyright (C) 2020-2025, Pylo, opensource contributors
 # Copyright (C) 2020-2025, Goldorion, opensource contributors
 #
 # Fabric-Generator-MCreator is free software: you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
 # the Free Software Foundation, either version 3 of the License, or
 # (at your option) any later version.
 #
 # Fabric-Generator-MCreator is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
 # along with Fabric-Generator-MCreator. If not, see <https://www.gnu.org/licenses/>.
-->

<#-- @formatter:off -->
<#include "procedures.java.ftl">
package ${package}.client.screens;

@Environment(EnvType.CLIENT) public class ${name}Overlay {
	<#if data.baseTexture?has_content>
		private static final ResourceLocation BACKGROUND = ResourceLocation.parse("${modid}:textures/screens/${data.baseTexture}");
	</#if>

	<#list data.getComponentsOfType("Image") as component>
		private static final ResourceLocation IMAGE_${component?index} = ResourceLocation.parse("${modid}:textures/screens/${component.image}");
	</#list>

	<#list data.getComponentsOfType("Sprite") as component>
		private static final ResourceLocation SPRITE_${component?index} = ResourceLocation.parse("${modid}:textures/screens/${component.sprite}");
	</#list>

	public static void render(GuiGraphics guiGraphics, DeltaTracker deltaTracker) {
			int w = guiGraphics.guiWidth();
			int h = guiGraphics.guiHeight();

		Level world = null;
		double x = 0;
		double y = 0;
		double z = 0;

		Player entity = Minecraft.getInstance().player;
		if (entity != null) {
			world = entity.level();
			x = entity.getX();
			y = entity.getY();
			z = entity.getZ();
		}

		if (<@procedureOBJToConditionCode data.displayCondition/>) {
			<#if data.baseTexture?has_content>
				guiGraphics.blit(RenderPipelines.GUI_TEXTURED, BACKGROUND, 0, 0, 0, 0, w, h, w, h);
			</#if>

			<#list data.getComponentsOfType("Image") as component>
				<#if hasProcedure(component.displayCondition)>
						if (<@procedureOBJToConditionCode component.displayCondition/>) {
				</#if>
					guiGraphics.blit(RenderPipelines.GUI_TEXTURED, IMAGE_${component?index}, <@calculatePosition component/>, 0, 0,
						${component.getWidth(w.getWorkspace())}, ${component.getHeight(w.getWorkspace())},
						${component.getWidth(w.getWorkspace())}, ${component.getHeight(w.getWorkspace())});
				<#if hasProcedure(component.displayCondition)>}</#if>
			</#list>

			<#list data.getComponentsOfType("Sprite") as component>
				<#if hasProcedure(component.displayCondition)>if (<@procedureOBJToConditionCode component.displayCondition/>) {</#if>
					guiGraphics.blit(RenderPipelines.GUI_TEXTURED, SPRITE_${component?index}, <@calculatePosition component/>,
						<#if (component.getTextureWidth(w.getWorkspace()) > component.getTextureHeight(w.getWorkspace()))>
							<@getSpriteByIndex component "width"/>, 0
						<#else>
							0, <@getSpriteByIndex component "height"/>
						</#if>,
						${component.getWidth(w.getWorkspace())}, ${component.getHeight(w.getWorkspace())},
						${component.getTextureWidth(w.getWorkspace())}, ${component.getTextureHeight(w.getWorkspace())});
				<#if hasProcedure(component.displayCondition)>}</#if>
			</#list>

			<#list data.getComponentsOfType("Label") as component>
				<#if hasProcedure(component.displayCondition)>
					if (<@procedureOBJToConditionCode component.displayCondition/>)
				</#if>
				guiGraphics.drawString(Minecraft.getInstance().font,
					<#if hasProcedure(component.text)><@procedureOBJToStringCode component.text/><#else>Component.translatable("gui.${modid}.${registryname}.${component.getName()}")</#if>,
					<@calculatePosition component/>, ${component.color.getRGB()}, ${component.hasShadow});
			</#list>

			<#list data.getComponentsOfType("EntityModel") as component>
				if (<@procedureOBJToConditionCode component.entityModel/> instanceof LivingEntity livingEntity) {
					<#if hasProcedure(component.displayCondition)>
						if (<@procedureOBJToConditionCode component.displayCondition/>)
					</#if>
					InventoryScreen.renderEntityInInventoryFollowsMouse(guiGraphics,
						<@calculatePosition component=component x_offset=(10 - 1000) y_offset=(20 - 1000)/>,
						<@calculatePosition component=component x_offset=(10 + 1000) y_offset=(20 + 1000)/>,
						${component.scale}, -livingEntity.getBbHeight() / (2.0f * livingEntity.getScale()),
						${component.rotationX / 20.0}f, 0, livingEntity);
				}
			</#list>
		}
	}
}

<#macro calculatePosition component x_offset=0 y_offset=0>
	<#if component.anchorPoint.name() == "TOP_LEFT">
		${component.x + x_offset}, ${component.y + y_offset}
	<#elseif component.anchorPoint.name() == "TOP_CENTER">
		w / 2 + ${component.x - (213 - x_offset)}, ${component.y + y_offset}
	<#elseif component.anchorPoint.name() == "TOP_RIGHT">
		w - ${427 - (component.x + x_offset)}, ${component.y + y_offset}
	<#elseif component.anchorPoint.name() == "CENTER_LEFT">
		${component.x + x_offset}, h / 2 + ${component.y - (120 - y_offset)}
	<#elseif component.anchorPoint.name() == "CENTER">
		w / 2 + ${component.x - (213 - x_offset)}, h / 2 + ${component.y - (120 - y_offset)}
	<#elseif component.anchorPoint.name() == "CENTER_RIGHT">
		w - ${427 - (component.x + x_offset)}, h / 2 + ${component.y - (120 - y_offset)}
	<#elseif component.anchorPoint.name() == "BOTTOM_LEFT">
		${component.x + x_offset}, h - ${240 - (component.y + y_offset)}
	<#elseif component.anchorPoint.name() == "BOTTOM_CENTER">
		w / 2 + ${component.x - (213 - x_offset)}, h - ${240 - (component.y + y_offset)}
	<#elseif component.anchorPoint.name() == "BOTTOM_RIGHT">
		w - ${427 - (component.x + x_offset)}, h - ${240 - (component.y + y_offset)}
	</#if>
</#macro>

<#macro getSpriteByIndex component dim>
	<#if hasProcedure(component.spriteIndex)>
		Mth.clamp((int) <@procedureOBJToNumberCode component.spriteIndex/> *
			<#if dim == "width">
				${component.getWidth(w.getWorkspace())}
			<#else>
				${component.getHeight(w.getWorkspace())}
			</#if>,
			0,
			<#if dim == "width">
				${component.getTextureWidth(w.getWorkspace()) - component.getWidth(w.getWorkspace())}
			<#else>
				${component.getTextureHeight(w.getWorkspace()) - component.getHeight(w.getWorkspace())}
			</#if>
		)
	<#else>
		<#if dim == "width">
			${component.getWidth(w.getWorkspace()) * component.spriteIndex.getFixedValue()}
		<#else>
			${component.getHeight(w.getWorkspace()) * component.spriteIndex.getFixedValue()}
		</#if>
	</#if>
</#macro>
<#-- @formatter:on -->