package ${package};

import net.fabricmc.api.ClientModInitializer;
import net.fabricmc.fabric.api.blockrenderlayer.v1.BlockRenderLayerMap;
import net.minecraft.client.render.RenderLayer;
import net.fabricmc.api.EnvType;
import net.fabricmc.api.Environment;

public class ClientInit implements ClientModInitializer{
  @Override
  public void onInitializeClient(){

    <#list w.getElementsOfType("PLANT") as plant>
    BlockRenderLayerMap.INSTANCE.putBlock(${JavaModName}.${plant}Plant, RenderLayer.getCutout());
    </#list>

  }
}
