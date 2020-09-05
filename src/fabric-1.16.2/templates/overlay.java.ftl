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
<#include "procedures.java.ftl">
<#include "tokens.ftl">

package ${package}.client;

import net.fabricmc.api.EnvType;
import net.fabricmc.api.Environment;

@Environment(EnvType.CLIENT)
public class ${name}Overlay {
    public static void render(MatrixStack matrices, float tickDelta) {
        int posX = (MinecraftClient.getInstance().getWindow().getScaledWidth()) / 2;
        int posY = (MinecraftClient.getInstance().getWindow().getScaledHeight()) / 2;

        PlayerEntity entity = MinecraftClient.getInstance().player;
        World world = entity.world;
        double x = entity.getX();
        double y = entity.getY();
        double z = entity.getZ();

        if (<@procedureOBJToConditionCode data.displayCondition/>) {
            <#if data.baseTexture?has_content>
					RenderSystem.disableDepthTest();
      				RenderSystem.depthMask(false);
      				RenderSystem.blendFuncSeparate(GlStateManager.SrcFactor.SRC_ALPHA, GlStateManager.DstFactor.ONE_MINUS_SRC_ALPHA, GlStateManager.SrcFactor.ONE, GlStateManager.DstFactor.ZERO);
      				RenderSystem.color3f(1.0F, 1.0F, 1.0F);
      				RenderSystem.disableAlphaTest();

					MinecraftClient.getInstance().getTextureManager()
                            .bindTexture(new Identifier("${modid}:textures/${data.baseTexture}"));
					MinecraftClient.getInstance().inGameHud.drawTexture(matrices, 0, 0, 0, 0, ${data.getBaseTextureWidth()}, ${data.getBaseTextureHeight()});
                            MinecraftClient.getInstance().getWindow().getScaledWidth();
                            MinecraftClient.getInstance().getWindow().getScaledHeight();

					RenderSystem.depthMask(true);
      				RenderSystem.enableDepthTest();
      				RenderSystem.enableAlphaTest();
      				RenderSystem.color4f(1.0F, 1.0F, 1.0F, 1.0F);
            </#if>

            <#list data.components as component>
                <#assign x = (component.x/2 - 213)?round>
                <#assign y = (component.y/2 - 120)?round>
                <#if component.getClass().getSimpleName() == "Label">
						MinecraftClient.getInstance().textRenderer.draw(matrices, "${translateTokens(JavaConventions.escapeStringForJava(component.text))}",
                                posX + ${x}, posY + ${y}, ${component.color.getRGB()});
                <#elseif component.getClass().getSimpleName() == "Image">
						RenderSystem.disableDepthTest();
						RenderSystem.depthMask(false);
						RenderSystem.blendFuncSeparate(GlStateManager.SrcFactor.SRC_ALPHA, GlStateManager.DstFactor.ONE_MINUS_SRC_ALPHA, GlStateManager.SrcFactor.ONE, GlStateManager.DstFactor.ZERO);
						RenderSystem.color3f(1.0F, 1.0F, 1.0F);
						RenderSystem.disableAlphaTest();

						MinecraftClient.getInstance().getTextureManager().bindTexture(new Identifier("${modid}:textures/${component.image}"));
						MinecraftClient.getInstance().inGameHud.drawTexture(matrices, posX + ${x}, posY + ${y}, 0, 0, 256, 256);

						RenderSystem.depthMask(true);
      					RenderSystem.enableDepthTest();
      					RenderSystem.enableAlphaTest();
      					RenderSystem.color4f(1.0F, 1.0F, 1.0F, 1.0F);
                </#if>
            </#list>
        }
    }
}

<#-- @formatter:on -->
