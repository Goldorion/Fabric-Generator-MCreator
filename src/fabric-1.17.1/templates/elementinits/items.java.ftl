<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2020-2021, Goldorion, opensource contributors
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

/*
 *    MCreator note: This file will be REGENERATED on each build.
 */

package ${package}.init;

<#assign hasBlocks = false>

public class ${JavaModName}Items {

    <#list items as item>
        <#if item.getModElement().getTypeString() != "dimension">
            public static Item ${item.getModElement().getRegistryNameUpper()};
        </#if>
    </#list>

    public static void load() {
        <#list items as item>
            <#if item.getModElement().getType().getBaseType()?string == "BLOCK">
            ${item.getModElement().getRegistryNameUpper()} = Registry.register(Registry.ITEM,new ResourceLocation(${JavaModName}.MODID,
                "${item.getModElement().getRegistryName()}"), new BlockItem(${JavaModName}Blocks.${item.getModElement().getRegistryNameUpper()}, new Item.Properties().tab(${item.creativeTab})));
            <#else>
                <#if item.getModElement().getTypeString() != "dimension">
                    ${item.getModElement().getRegistryNameUpper()} = Registry.register(Registry.ITEM,
                        new ResourceLocation(${JavaModName}.MODID, "${item.getModElement().getRegistryName()}"), new ${item.getModElement().getName()}Item());
                </#if>
                <#if item.getModElement().getTypeString() == "item" && item.hasDispenseBehavior>
                    ${item.getModElement().getName()}Item.init();
                </#if>
            </#if>
        </#list>

    }

}

<#-- @formatter:on -->