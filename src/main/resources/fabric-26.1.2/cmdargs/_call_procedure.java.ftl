<#include "procedures.java.ftl">
.executes(arguments -> {
    Level world = arguments.getSource().getLevel();

    double x = arguments.getSource().getPosition().x();
    double y = arguments.getSource().getPosition().y();
    double z = arguments.getSource().getPosition().z();

    Entity entity = arguments.getSource().getEntity();
    if (entity == null && world instanceof ServerLevel _servLevel)
        entity = FakePlayer.get(_servLevel);

    Direction direction = Direction.DOWN;
    if (entity != null)
    	direction = entity.getDirection();

    <@procedureToCode name=procedure dependencies=dependencies/>
    return 0;
})