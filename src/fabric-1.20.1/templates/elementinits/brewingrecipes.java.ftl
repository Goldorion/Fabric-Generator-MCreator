<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2020-2023, Goldorion, opensource contributors
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
<#compress>

/*
 *	MCreator note: This file will be REGENERATED on each build.
 */

package ${package}.init;

public class ${JavaModName}BrewingRecipes {

	public static void load() {
		<#list recipes as recipe>
			<#if recipe.recipeType == "Brewing">
				<#if (recipe.brewingInputStack?starts_with("POTION:")) && (recipe.brewingReturnStack?starts_with("POTION:")) &&
					!(recipe.brewingIngredientStack?starts_with("TAG:"))>
					PotionBrewing.addMix(${generator.map(recipe.brewingInputStack?replace("POTION:",""), "potions")},
							${mappedMCItemToItem(recipe.brewingIngredientStack)},
							${generator.map(recipe.brewingReturnStack?replace("POTION:",""), "potions")});
				</#if>
			</#if>
		</#list>
	}

}
</#compress>
<#-- @formatter:on -->