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
package ${package};

import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.LogManager;
import ${package}.init.*;

public class ${JavaModName} implements ModInitializer {

	public static final Logger LOGGER = LogManager.getLogger(${JavaModName}.class);

	public static final String MODID = "${modid}";

	@Override
	public void onInitialize() {
		// Start of user code block mod constructor
		// End of user code block mod constructor

		LOGGER.info("Initializing ${JavaModName}");

		<#if w.getGElementsOfType("recipe")?filter(e -> e.recipeType == "Brewing")?size != 0>${JavaModName}BrewingRecipes.load();</#if>
		<#if w.hasElementsOfType("itemextension")>${JavaModName}ItemExtensions.load();</#if>

		// Start of user code block mod init
		// End of user code block mod init
	}

	// Start of user code block mod methods
	// End of user code block mod methods
}
<#-- @formatter:on -->
