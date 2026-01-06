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
package ${package};

import java.lang.invoke.MethodHandle;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class ${JavaModName} implements ModInitializer {

	public static final Logger LOGGER = LogManager.getLogger(${JavaModName}.class);

	public static final String MODID = "${modid}";

	@Override public void onInitialize() {
		// Start of user code block mod constructor
		// End of user code block mod constructor

		LOGGER.info("Initializing ${JavaModName}");

        <@javacompress>
		<#if w.hasSounds()>${JavaModName}Sounds.load();</#if>
		<#if w.hasItemsInTabs()>${JavaModName}Tabs.load();</#if>
		<#if w.hasVariables()>${JavaModName}Variables.variablesLoad();</#if>
		<#if types["base:features"]??>${JavaModName}Features.load();</#if>
		<#if types["particles"]??>${JavaModName}ParticleTypes.load();</#if>
		<#if types["fluids"]??>${JavaModName}Fluids.load();</#if>
		<#if types["base:entities"]??>${JavaModName}Entities.load();</#if>
		<#if types["base:blocks"]??>${JavaModName}Blocks.load();</#if>
		<#if types["base:blockentities"]??>${JavaModName}BlockEntities.load();</#if>
		<#if w.getGElementsOfType('block')?filter(e -> e.isSign())?size != 0>${JavaModName}WoodTypes.load();</#if>
		<#if types["base:items"]??>${JavaModName}Items.load();</#if>
		<#if types["attributes"]??>${JavaModName}Attributes.load();</#if>
		<#if w.getGElementsOfType("recipe")?filter(e -> e.recipeType == "Brewing")?size != 0>${JavaModName}BrewingRecipes.load();</#if>
		<#if w.getGElementsOfType('biome')?filter(e -> e.hasVines() || e.hasFruits())?size != 0>${JavaModName}Biomes.load();</#if>
		<#if w.getGElementsOfType('biome')?filter(e -> e.spawnBiome || e.spawnInCaves || e.spawnBiomeNether)?size != 0>ServerLifecycleEvents.SERVER_STARTING.register(${JavaModName}Biomes::load);</#if>
		<#if w.getGElementsOfType('dimension')?filter(e -> e.hasEffectsOrDimensionTriggers() || e.enablePortal)?size != 0>${JavaModName}Dimensions.load();</#if>
		<#if types["guis"]??>${JavaModName}Menus.load();</#if>
		<#if types["villagerprofessions"]??>${JavaModName}VillagerProfessions.load();</#if>
		<#if types["villagertrades"]??>${JavaModName}Trades.registerTrades();</#if>
		<#if w.getGElementsOfType('itemextension')?filter(e -> e.enableFuel || e.compostLayerChance gt 0)?size != 0>${JavaModName}ItemExtensions.load();</#if>
		<#if w.getGElementsOfType('itemextension')?filter(e -> e.hasDispenseBehavior)?size != 0 || types["specialentities"]??>${JavaModName}DispenseBehaviors.load();</#if>
		<#if types["potioneffects"]??>${JavaModName}MobEffects.load();</#if>
		<#if types["potions"]??>${JavaModName}Potions.load();</#if>
		<#if types["gamerules"]??>${JavaModName}GameRules.load();</#if>
		<#if w.getGElementsOfType("command")?filter(e -> e.type != "CLIENTSIDE")?size != 0>${JavaModName}Commands.load();</#if>
		<#if w.getGElementsOfType('procedure')?filter(e -> !e.procedurexml?contains('no_ext_trigger'))?size != 0>${JavaModName}Procedures.load();</#if>
		<#if types["keybinds"]??>${JavaModName}KeyMappingsServer.serverLoad();</#if>
		</@javacompress>

		tick();

		// Start of user code block mod init
		// End of user code block mod init
	}

	// Start of user code block mod methods
	// End of user code block mod methods

	<#-- Wait procedure block support below -->
	private static final Collection<Tuple<Runnable, Integer>> workQueue = new ConcurrentLinkedQueue<>();
	public static void queueServerWork(int tick, Runnable action) {
		workQueue.add(new Tuple<>(action, tick));
	}

	private void tick() {
        ServerTickEvents.END_SERVER_TICK.register((server) -> {
            List<Tuple<Runnable, Integer>> actions = new ArrayList<>();
            workQueue.forEach(work -> {
                work.setB(work.getB() - 1);
                if (work.getB() == 0)
                    actions.add(work);
            });
            actions.forEach(e -> e.getA().run());
            workQueue.removeAll(actions);
        });
	}

	<#-- Client side player query support below, we use method handles for this -->
	private static Object minecraft;
	private static MethodHandle playerHandle;
	@Nullable public static Player clientPlayer() {
		if (FabricLoader.getInstance().getEnvironmentType() == EnvType.CLIENT) {
			try {
				<#-- Lazy initialize and cache the Minecraft instance and player handle -->
				if (minecraft == null || playerHandle == null) {
					Class<?> minecraftClass = Class.forName("net.minecraft.client.Minecraft");
					minecraft = MethodHandles.publicLookup().findStatic(minecraftClass, "getInstance", MethodType.methodType(minecraftClass)).invoke();
					playerHandle = MethodHandles.publicLookup().findGetter(minecraftClass, "player", Class.forName("net.minecraft.client.player.LocalPlayer"));
				}
				return (Player) playerHandle.invoke(minecraft);
			} catch (Throwable e) {
				LOGGER.error("Failed to get client player", e);
				return null;
			}
		} else {
			return null;
		}
	}
}
<#-- @formatter:on -->