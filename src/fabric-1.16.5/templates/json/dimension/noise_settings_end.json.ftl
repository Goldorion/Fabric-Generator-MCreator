<#-- @formatter:off -->
<#include "../../mcitems.ftl">
{
  "aquifers_enabled": ${data.imitateOverworldBehaviour},
  "noise_caves_enabled": ${data.imitateOverworldBehaviour},
  "deepslate_enabled": ${data.imitateOverworldBehaviour},
  "bedrock_roof_position": -2147483648,
  "bedrock_floor_position": -2147483648,
  "sea_level": 0,
  "disable_mob_generation": ${!data.imitateOverworldBehaviour},
  "default_block": ${mappedMCItemToBlockStateJSON(data.mainFillerBlock)},
  "default_fluid": ${mappedMCItemToBlockStateJSON(data.fluidBlock)},
  "noise": {
    "simplex_surface_noise": true,
    "island_noise_override": true,
    "size_vertical": 1,
    "density_factor": 0.0,
    "density_offset": 0.0,
    "top_slide": {
      "target": -3000,
      "size": 64,
      "offset": -46
    },
    "bottom_slide": {
      "target": -30,
      "size": 7,
      "offset": 1
    },
    "size_horizontal": 2,
    "min_y": 0,
    "height": 128,
    "sampling": {
      "xz_scale": 2.0,
      "y_scale": 1.0,
      "xz_factor": 80.0,
      "y_factor": 160.0
    }
  },
  "structures": {
    "structures": {}
  }
}
<#-- @formatter:o`n -->