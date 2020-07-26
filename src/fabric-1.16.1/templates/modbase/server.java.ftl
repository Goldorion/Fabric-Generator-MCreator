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

import net.fabricmc.api.DedicatedServerModInitializer;

public class ServerInit implements DedicatedServerModInitializer{
    @Override
    public void onInitializeServer() {
        <#list w.getElementsOfType("CODE") as code>
            ${code}CustomCode.initializeServer();
        </#list>
    }
}

<#-- @formatter:on -->

