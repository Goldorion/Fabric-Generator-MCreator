<#-- @formatter:off -->
/*
 *    MCreator note:
 *
 *    If you lock base mod element files, you can edit this file and the proxy files
 *    and they won't get overwritten. If you change your mod package or modid, you
 *    need to apply these changes to this file MANUALLY.
 *
 *
 *    If you do not lock base mod element files in Workspace settings, this file
 *    will be REGENERATED on each build.
 *
 */

package ${package};

import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.LogManager;

public class ${JavaModName} implements ModInitializer {

    public static final Logger LOGGER = LogManager.getLogger();

	<#list w.getElementsOfType("ITEM") as item>
		public static final Item ${item}Item = Registry.register(Registry.ITEM, id("${item.getRegistryName()}"), new ${item}());
	</#list>

	public void onInitialize() {
		LOGGER.info("[${JavaModName}] Initializing");
	}

	public static final Identifier id(String s) {
		return new Identifier("${modid}", s);
	}
}
<#-- @formatter:on -->
