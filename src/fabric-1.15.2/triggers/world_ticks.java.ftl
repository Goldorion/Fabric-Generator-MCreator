@Override
public void worldTick(World world){
    Map<String, Object> dependencies = new HashMap<>();
    dependencies.put("world",world);
    this.executeProcedure(dependencies);
}