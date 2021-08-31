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
<#include "procedures.java.ftl">
<#include "tokens.ftl">

<#assign mx = data.W - data.width>
<#assign my = data.H - data.height>

package ${package}.client.gui.screen;

@Environment(EnvType.CLIENT)
public class ${name}GuiWindow extends HandledScreen<${name}Gui.GuiContainerMod> {

	private World world;
	private int x, y, z;
	private PlayerEntity entity;

	private final static HashMap guistate = ${name}Gui.guistate;

	<#list data.components as component>
		<#if component.getClass().getSimpleName() == "TextField">
	    TextFieldWidget ${component.name};
		<#elseif component.getClass().getSimpleName() == "Checkbox">
	    CheckboxWidget ${component.name};
		</#if>
	</#list>

	public ${name}GuiWindow(${name}Gui.GuiContainerMod container, PlayerInventory inventory, Text text) {
		super(container, inventory, text);
		this.world = container.world;
		this.x = container.x;
		this.y = container.y;
		this.z = container.z;
		this.entity = container.entity;
		this.backgroundWidth = ${data.width};
		this.backgroundHeight = ${data.height};
	}

	<#if data.doesPauseGame>
	@Override public boolean isPauseScreen() {
		return true;
	}
	</#if>

	<#if data.renderBgLayer>
	private static final Identifier texture = new Identifier("${modid}:textures/${registryname}.png" );
	</#if>

	@Override public void render(MatrixStack ms, int mouseX, int mouseY, float partialTicks) {
		this.renderBackground(ms);
		super.render(ms, mouseX, mouseY, partialTicks);
		this.drawMouseoverTooltip(ms, mouseX, mouseY);

		<#list data.components as component>
			<#if component.getClass().getSimpleName() == "TextField">
				${component.name}.render(ms, mouseX, mouseY, partialTicks);
			</#if>
		</#list>
	}

	@Override protected void drawBackground(MatrixStack ms, float partialTicks, int gx, int gy) {
		RenderSystem.color4f(1, 1, 1, 1);
		RenderSystem.enableBlend();
		RenderSystem.defaultBlendFunc();

		<#if data.renderBgLayer>
		MinecraftClient.getInstance().getTextureManager().bindTexture(texture);
		int k = (this.width - this.backgroundWidth) / 2;
		int l = (this.height - backgroundHeight) / 2;
		drawTexture(ms, k, l, 0, 0, this.backgroundWidth, backgroundHeight, this.backgroundWidth, backgroundHeight);
		</#if>

		<#list data.components as component>
			<#if component.getClass().getSimpleName() == "Image">
				<#if hasProcedure(component.displayCondition)>if (<@procedureOBJToConditionCode component.displayCondition/>) {</#if>
					MinecraftClient.getInstance().getTextureManager().bindTexture(new Identifier("${modid}:textures/${component.image}"));
					drawTexture(ms, this.x + ${(component.x - mx/2)?int}, this.y + ${(component.y - my/2)?int}, 0, 0,
						${component.getWidth(w.getWorkspace())}, ${component.getHeight(w.getWorkspace())},
						${component.getWidth(w.getWorkspace())}, ${component.getHeight(w.getWorkspace())});
				<#if hasProcedure(component.displayCondition)>}</#if>
			</#if>
		</#list>

		RenderSystem.disableBlend();
	}

	@Override public boolean keyPressed(int key, int b, int c) {
		if (key == 256) {
			this.client.player.closeScreen();
			return true;
		}

		<#list data.components as component>
			<#if component.getClass().getSimpleName() == "TextField">
		    if(${component.name}.isFocused())
		    	return ${component.name}.keyPressed(key, b, c);
			</#if>
		</#list>

		return super.keyPressed(key, b, c);
	}

	@Override public void tick() {
		super.tick();
		<#list data.components as component>
			<#if component.getClass().getSimpleName() == "TextField">
				${component.name}.tick();
			</#if>
		</#list>
	}

	@Override protected void drawForeground(MatrixStack ms, int mouseX, int mouseY) {
		<#list data.components as component>
			<#if component.getClass().getSimpleName() == "Label">
				<#if hasProcedure(component.displayCondition)>
				if (<@procedureOBJToConditionCode component.displayCondition/>)
				</#if>
		    	this.textRenderer.draw(ms, "${translateTokens(JavaConventions.escapeStringForJava(component.text))}",
					${(component.x - mx / 2)?int}, ${(component.y - my / 2)?int}, ${component.color.getRGB()});
			</#if>
		</#list>
	}

	@Override public void onClose() {
		super.onClose();
		MinecraftClient.getInstance().keyboard.setRepeatEvents(false);
	}

	@Override public void init(MinecraftClient client, int width, int height) {
		super.init(client, width, height);
		client.keyboard.setRepeatEvents(true);

		<#assign btid = 0>
		<#list data.components as component>
			<#if component.getClass().getSimpleName() == "TextField">
				${component.name} = new TextFieldWidget(this.textRenderer, this.x + ${(component.x - mx/2)?int}, this.y + ${(component.y - my/2)?int},
				${component.width}, ${component.height}, new StringTextComponent("${component.placeholder}"))
				<#if component.placeholder?has_content>
				{
					{
						setSuggestion("${component.placeholder}");
					}

					@Override public void writeText(String text) {
						super.writeText(text);

						if(getText().isEmpty())
							setSuggestion("${component.placeholder}");
						else
							setSuggestion(null);
					}

					@Override public void setCursorPosition(int pos) {
						super.setCursorPosition(pos);

						if(getText().isEmpty())
							setSuggestion("${component.placeholder}");
						else
							setSuggestion(null);
					}
				}
				</#if>;
                guistate.put("text:${component.name}", ${component.name});
				${component.name}.setMaxStringLength(32767);
                this.children.add(this.${component.name});
			<#elseif component.getClass().getSimpleName() == "Button">
				this.addButton(new ButtonWidget(this.x + ${(component.x - mx/2)?int}, this.y + ${(component.y - my/2)?int},
					${component.width}, ${component.height}, new LiteralText("${component.text}"), e -> {
						if (<@procedureOBJToConditionCode component.displayCondition/>) {
			                ClientPlayNetworking.send(${JavaModName}.id("${name?lower_case}"), new ${name}Gui.ButtonPressedMessage(${btid}));
						}
					}
				)
                <#if hasProcedure(component.displayCondition)>
                {
					@Override public void render(MatrixStack ms, int gx, int gy, float ticks) {
						if (<@procedureOBJToConditionCode component.displayCondition/>)
							super.render(ms, gx, gy, ticks);
					}
				}
				</#if>);
				<#assign btid +=1>
			<#elseif component.getClass().getSimpleName() == "Checkbox">
            	${component.name} = new CheckboxWidget(this.x + ${(component.x - mx/2)?int}, this.y + ${(component.y - my/2)?int},
            	    150, 20, new LiteralText("${component.text}"), <#if hasProcedure(component.isCheckedProcedure)>
            	    <@procedureOBJToConditionCode component.isCheckedProcedure/><#else>false</#if>);
                ${name}Gui.guistate.put("checkbox:${component.name}", ${component.name});
                this.addButton(${component.name});
			</#if>
		</#list>
	}

	public static void screenInit() {
	<#list data.components as component>
	<#if component.getClass().getSimpleName() == "Button">
	    ServerPlayNetworking.registerGlobalReceiver(${JavaModName}.id("${name?lower_case}"), ${name}Gui.ButtonPressedMessage::apply);
	</#if>
	</#list>
	}

}
<#-- @formatter:on -->