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
<#include "../mcitems.ftl">
/*
 *    MCreator note: This file will be REGENERATED on each build.
 */

package ${package}.init;

<#assign hasTintedBlocks = false>
<#list blocks as block>
	<#if block.getModElement().getTypeString() == "block">
		<#if block.tintType != "No tint">
			<#assign hasTintedBlocks = true>
		</#if>
	<#elseif block.getModElement().getTypeString() == "plant">
		<#if block.tintType != "No tint">
			<#assign hasTintedBlocks = true>
		</#if>
	</#if>
</#list>

<#assign chunks = blocks?chunk(2500)>
<#assign has_chunks = chunks?size gt 1>

public class ${JavaModName}Blocks {

	<@javacompress>
	<#list blocks as block>
		<#if block.getModElement().getTypeString() == "dimension">
            public static Block ${block.getModElement().getRegistryNameUpper()}_PORTAL;
		<#else>
			public static Block ${block.getModElement().getRegistryNameUpper()};
			<#if (block.getModElement().getTypeString() == "block") && (block.blockBase! == "Sign")>
				public static Block ${block.getWallRegistryNameUpper()};
			</#if>
		</#if>
	</#list>
	</@javacompress>

	<#list chunks as sub_blocks>
	public static void <#if has_chunks>register${sub_blocks?index}<#else>load</#if>() {
		<#list sub_blocks as block>
			<#if block.getModElement().getTypeString() == "dimension">
        	    ${block.getModElement().getRegistryNameUpper()}_PORTAL =
					register("${block.getModElement().getRegistryName()}_portal", ${block.getModElement().getName()}PortalBlock::new);
			<#else>
				${block.getModElement().getRegistryNameUpper()} =
					register("${block.getModElement().getRegistryName()}", ${block.getModElement().getName()}Block::new);
				<#if (block.getModElement().getTypeString() == "block") && (block.blockBase! == "Sign")>
					${block.getWallRegistryNameUpper()} =
						register("${block.getWallRegistryName()}", ${block.getWallName()}Block::new);
				</#if>
			</#if>
		</#list>

        <#if !has_chunks>
            <#list sub_blocks as block>
                <#if block.getModElement().getTypeString() != "dimension">
                    <#if block.strippingResult?? && !block.strippingResult.isEmpty()>
                        StrippableBlockRegistry.register(${JavaModName}Blocks.${block.getModElement().getRegistryNameUpper()}, ${mappedBlockToBlock(block.strippingResult)});
                    </#if>
                </#if>
            </#list>
        </#if>
	}
	</#list>

	<#if has_chunks>
	public static void load() {
		<#list 0..chunks?size-1 as i>register${i}();</#list>

        <#list sub_blocks as block>
            <#if block.getModElement().getTypeString() != "dimension">
                <#if block.strippingResult?? && !block.strippingResult.isEmpty()>
                    StrippableBlockRegistry.register(${JavaModName}Blocks.${block.getModElement().getRegistryNameUpper()}, ${mappedBlockToBlock(block.strippingResult)});
                </#if>
            </#if>
        </#list>
	}
	</#if>

	// Start of user code block custom blocks
	// End of user code block custom blocks

	private static <B extends Block> B register(String name, Function<BlockBehaviour.Properties, B> supplier) {
		return (B) Blocks.register(ResourceKey.create(Registries.BLOCK, ResourceLocation.fromNamespaceAndPath(${JavaModName}.MODID, name)), (Function<BlockBehaviour.Properties, Block>) supplier, BlockBehaviour.Properties.of());
	}

	<#if hasTintedBlocks>
	public static void clientLoad() {
		<#list blocks as block>
			<#if block.getModElement().getTypeString() == "block" || block.getModElement().getTypeString() == "plant">
				<#if block.tintType != "No tint">
					 ${block.getModElement().getName()}Block.blockColorLoad();
				</#if>
			</#if>
		</#list>
	}
	</#if>
}
<#-- @formatter:on -->