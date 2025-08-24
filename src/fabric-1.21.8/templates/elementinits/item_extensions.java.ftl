<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2020-2025, Goldorion, opensource contributors
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
<#include "../mcitems.ftl">
<#include "../procedures.java.ftl">

/*
 *	MCreator note: This file will be REGENERATED on each build.
 */

package ${package}.init;

public class ${JavaModName}ItemExtensions {

	public static void load() {
		<#compress>

		<#list itemextensions as extension>
		    <#if extension.hasDispenseBehavior>
		        ${extension.getModElement().getName()}ItemExtension.init();
		    </#if>

		    <#if (extension.compostLayerChance > 0)>
		        CompostingChanceRegistry.INSTANCE.add(${mappedMCItemToItem(extension.item)}, ${extension.compostLayerChance}f);
		    </#if>
		</#list>

		FuelRegistryEvents.BUILD.register((builder, context) -> {
		<#list itemextensions?filter(e -> e.enableFuel) as extension>
		    <#if extension.enableFuel>
		        <#if hasProcedure(extension.fuelSuccessCondition)>if(<@procedureOBJToConditionCode extension.fuelSuccessCondition/>)</#if>
		            builder.add(${mappedMCItemToItem(extension.item)},
                    <#if hasProcedure(extension.fuelPower)>
                        (int) <@procedureOBJToNumberCode extension.fuelPower/>
                    <#else>
                        ${extension.fuelPower.getFixedValue()}
                    </#if>);
		        </#if>
		</#list>
		});
		</#compress>
	}
}
<#-- @formatter:on -->