<#-- @formatter:off -->

package ${package}.block;

public class ${name} extends PlantBlock{
  public TestBlock(Settings settings) {
        super(settings);
  }

  @Override
  public OffsetType getOffsetType() {
      return OffsetType.XZ;
  }
}

<#-- @formatter:on -->
