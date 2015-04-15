package llvmast;
public  class LlvmBranch extends LlvmInstruction{
	
	public LlvmValue cond;
	public LlvmLabelValue label1;
	public LlvmLabelValue label2;
	public boolean conditional;

    public LlvmBranch(LlvmLabelValue label){
    	this.label1 = label;
    	this.conditional = false;
    }
    
    public LlvmBranch(LlvmValue cond,  LlvmLabelValue brTrue, LlvmLabelValue brFalse){
    	this.cond = cond;
    	this.label1 = brTrue;
    	this.label2 = brFalse;
    	this.conditional = true;
    }

    public String toString(){
		if(conditional)
			return "  br i1 " + cond + ", label %" + label1 + ", label %" + label2;
		return "  br label %" + label1;
    }
}