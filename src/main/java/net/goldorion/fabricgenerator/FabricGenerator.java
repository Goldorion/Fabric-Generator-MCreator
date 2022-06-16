package net.goldorion.fabricgenerator;

import net.mcreator.plugin.JavaPlugin;
import net.mcreator.plugin.Plugin;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class FabricGenerator extends JavaPlugin {

    public static final Logger LOG = LogManager.getLogger("Fabric Generator");

    public FabricGenerator(Plugin plugin) {
        super(plugin);
    }
}
