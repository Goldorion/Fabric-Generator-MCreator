{
  "trigger": "minecraft:placed_block",
  "conditions": {
	"location": [
		{
			"block": "${input$block}",
			"condition": "minecraft:block_state_property"
		}
	]
  }
}