<#-- @formatter:off -->
/*
 *    MCreator note:
 *
 *    If you lock base mod element files, you can edit this file and the proxy files
 *    and they won't get overwritten. If you change your mod package or modid, you
 *    need to apply these changes to this file MANUALLY.
 *
 *
 *
 *    If you do not lock base mod element files in Workspace settings, this file
 *    will be REGENERATED on each build.
 *
 */
package ${package}.registry;

public class ${JavaModName}Biomes {

  <#list w.getElementsOfType("BIOME") as biome>
  public static Biome ${biome?upper_case};
  </#list>

  public static void registerBiomes()
  {
    <#list w.getElementsOfType("BIOME") as biome>
    ${biome?upper_case} = register(new ${biome}(), "${modid}:${biome.getRegistryName()}");
    FabricBiomes.addSpawnBiome(${JavaModName}Biomes.${biome?upper_case});
    </#list>
  }

  private static Biome register(Biome biome, String ID) {
		return Registry.register(Registry.BIOME, ID, biome);
	}

}
<#-- @formatter:on -->
