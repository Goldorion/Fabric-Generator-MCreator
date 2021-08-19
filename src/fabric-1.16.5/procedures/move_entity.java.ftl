{
	Entity _ent = ${input$entity};
    _ent.teleport(${input$x},${input$y},${input$z});
    if (_ent instanceof ServerPlayerEntity) {
    	((ServerPlayerEntity) _ent).networkHandler.requestTeleport(${input$x}, ${input$y}, ${input$z}, _ent.yaw, _ent.pitch, Collections.emptySet());
    }
}