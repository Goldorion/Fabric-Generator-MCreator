<#-- @formatter:off -->
<#include "../../mcitems.ftl">
{
  "aquifers_enabled": ${data.imitateOverworldBehaviour},
  "noise_caves_enabled": ${data.imitateOverworldBehaviour},
  "deepslate_enabled": ${data.imitateOverworldBehaviour},
  "bedrock_roof_position": 0,
  "bedrock_floor_position": 0,
  "sea_level": 32,
  "disable_mob_generation": ${!data.imitateOverworldBehaviour},
  "default_block": ${mappedMCItemToBlockStateJSON(data.mainFillerBlock)},
  "default_fluid": ${mappedMCItemToBlockStateJSON(data.fluidBlock)},
  "noise": {
    "simplex_surface_noise": false,
    "size_vertical": 2,
    "density_factor": 0.0,
    "density_offset": 0.019921875,
    "top_slide": {
      "target": 120,
      "size": 3,
      "offset": 0
    },
    "bottom_slide": {
      "target": 320,
      "size": 4,
      "offset": -1
    },
    "size_horizontal": 1,
  <#if data.imitateOverworldBehaviour>
    "min_y": -64,
    "height": 384,
  <#else>
    "min_y": 0,
    "height": 128,
  </#if>
    "sampling": {
      "xz_scale": 1.0,
      "y_scale": 3.0,
      "xz_factor": 80.0,
      "y_factor": 60.0
    }
  },
  "structures": {
    "structures": {}
  }
}
<#-- @formatter:o`n -->