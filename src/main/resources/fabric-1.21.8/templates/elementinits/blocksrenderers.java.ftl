<#--
 # This file is part of Fabric-Generator-MCreator.
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
/*
 *	MCreator note: This file will be REGENERATED on each build.
 */

package ${package}.init;

@Environment(EnvType.CLIENT) public class ${JavaModName}BlocksRenderers {

	public static void clientLoad() {
		<#list blocks as block>
			<#if block.getModElement().getTypeString() == "block">
				<#if block.transparencyType != "SOLID" || block.hasTransparency>
					${block.getModElement().getName()}Block.registerRenderLayer();
				</#if>
				<#if block.renderType() == 4>
					${block.getModElement().getName()}Renderer.registerBlockEntityRenderers();
				</#if>
			<#elseif block.getModElement().getTypeString() == "plant">
				${block.getModElement().getName()}Block.registerRenderLayer();
			<#elseif block.getModElement().getTypeString() == "dimension">
				${block.getModElement().getName()}PortalBlock.registerRenderLayer();
			<#elseif block.getModElement().getTypeString() == "fluid">
				${block.getModElement().getName()}Fluid.registerRenderLayer();
			</#if>
		</#list>
	}

	// Start of user code block custom block renderers
	// End of user code block custom block renderers
}
<#-- @formatter:on -->