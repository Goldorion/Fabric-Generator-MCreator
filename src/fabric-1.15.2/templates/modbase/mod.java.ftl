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

import net.fabricmc.fabric.api.event.world.WorldTickCallback;

import ${package}.procedures.*;
import ${package}.item.*;
import ${package}.block.*;

public class ${JavaModName} implements ModInitializer {

    public static final Logger LOGGER = LogManager.getLogger();

<#list w.getElementsOfType("ITEM") as item>
	public static final Item ${item}_ITEM = Registry.register(Registry.ITEM, id("${item.getRegistryName()}"), new ${item}());
</#list>

<#list w.getElementsOfType("BLOCK") as block>
	<#assign ge = block.getGeneratableElement()>
	public static final Block ${block}_BLOCK = Registry.register(Registry.BLOCK, id("${block.getRegistryName()}"), new ${block}());
	public static final BlockItem ${block}_BLOCK_ITEM = Registry.register(Registry.ITEM, id("${block.getRegistryName()}"), new BlockItem(${block}, new Item.Settings().group(${ge.creativeTab})));
</#list>

	public void onInitialize() {
		LOGGER.info("[${JavaModName}] Initializing");

		WorldTickCallback.EVENT.register((world) -> {
		<#list w.getElementsOfType("PROCEDURE") as procedure>
			${procedure}Procedure.worldTick(world);
		</#list>
		});
	}

	public static final Identifier id(String s) {
		return new Identifier("${modid}", s);
	}
}
<#-- @formatter:on -->
