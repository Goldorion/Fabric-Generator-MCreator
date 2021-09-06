(new Object(){
	public boolean getValue(){
		CheckboxWidget checkbox = (CheckboxWidget)guistate.get("checkbox:${field$checkbox}");
		if(checkbox!=null){
			return checkbox.isChecked();
		}
		return false;
	}
}.getValue())