<#function translateTokens source>
    <#local varTokens = source.toString().split("(?=<(VAR|ENBT|BNBT|energy|fluidlevel)|(?<=>))")>
    <#assign sourceNew = "">
    <#list varTokens as token>
        <#if token.toString()?starts_with("<VAR:integer:")>
            <#assign sourceNew += "<(int) "+translateGlobalVarName(token.replace("<VAR:integer:", "").replace(">", "").toString())+">">
        <#elseif token.toString()?starts_with("<VAR:")>
            <#assign sourceNew += "<"+translateGlobalVarName(token.replace("<VAR:", "").replace(">", "").toString())+">">
        <#elseif token.toString()?starts_with("<ENBT:number:")>
            <#assign sourceNew += "<(entity.getPersistentData().getDouble(\"" + (token.replace("<ENBT:number:", "").replace(">", "").toString()) + "\"))>">
        <#elseif token.toString()?starts_with("<ENBT:integer:")>
            <#assign sourceNew += "<((int)entity.getPersistentData().getDouble(\"" + (token.replace("<ENBT:integer:", "").replace(">", "").toString()) + "\"))>">
        <#elseif token.toString()?starts_with("<ENBT:logic:")>
            <#assign sourceNew += "<(entity.getPersistentData().getBoolean(\"" + (token.replace("<ENBT:logic:", "").replace(">", "").toString()) + "\"))>">
        <#elseif token.toString()?starts_with("<ENBT:text:")>
            <#assign sourceNew += "<(entity.getPersistentData().getString(\"" + (token.replace("<ENBT:text:", "").replace(">", "").toString()) + "\"))>">
        <#elseif token.toString()?starts_with("<BNBT:number:")>
            <#assign sourceNew += "<(new Object(){
                                        public double getValue(BlockPos pos, String tag){
                                        	TileEntity tileEntity=world.getTileEntity(pos);
                                            if(tileEntity!=null) return tileEntity.getTileData().getDouble(tag);
                                            return 0;
                                        }
                                        }.getValue(new BlockPos((int) x, (int) y, (int) z), \"" + (token.replace("<BNBT:number:", "").replace(">", "").toString()) + "\"))>">
        <#elseif token.toString()?starts_with("<BNBT:integer:")>
            <#assign sourceNew += "<((int) new Object(){
                                        public double getValue(BlockPos pos, String tag){
                                            TileEntity tileEntity=world.getTileEntity(pos);
                                            if(tileEntity!=null) return tileEntity.getTileData().getDouble(tag);
                                            return 0;
                                        }
                                        }.getValue(new BlockPos((int) x, (int) y, (int) z), \"" + (token.replace("<BNBT:integer:", "").replace(">", "").toString()) + "\"))>">
        <#elseif token.toString()?starts_with("<BNBT:logic:")>
            <#assign sourceNew += "<(new Object(){
                                        public boolean getValue(BlockPos pos, String tag){
                                        	TileEntity tileEntity=world.getTileEntity(pos);
                                            if(tileEntity!=null) return tileEntity.getTileData().getBoolean(tag);
                                            return false;
                                        }
                                        }.getValue(new BlockPos((int) x, (int) y, (int) z), \"" + (token.replace("<BNBT:logic:", "").replace(">", "").toString()) + "\"))>">
        <#elseif token.toString()?starts_with("<BNBT:text:")>
            <#assign sourceNew += "<(new Object(){
                                        public String getValue(BlockPos pos, String tag){
                                        	TileEntity tileEntity=world.getTileEntity(pos);
                                            if(tileEntity!=null) return tileEntity.getTileData().getString(tag);
                                            return \"\";
                                        }
                                        }.getValue(new BlockPos((int) x, (int) y, (int) z), \"" + (token.replace("<BNBT:text:", "").replace(">", "").toString()) + "\"))>">
        <#else>
            <#assign sourceNew += token>
        </#if>
    </#list>
    <#return sourceNew?replace(":text>", ".getText()+\"")
                ?replace("(?<!\\\\)<", "\"+", "r")?replace("(?<!\\\\)>", "+\"", "r")
                ?replace("\\\\<", "<")?replace("\\\\>", ">")
    >
</#function>
